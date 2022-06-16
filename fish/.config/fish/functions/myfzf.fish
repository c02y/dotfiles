# based on https://github.com/jethrokuan/fzf, merge all files into one, clean and fix
#
################################# fzf.fish
bind \co __fzf_find_file
bind \cr __fzf_reverse_isearch
bind \cw __fzf_cd
bind \es __fzf_open
bind \cs '__fzf_open --editor'

# if not bind --user \t >/dev/null 2>/dev/null
#     if set -q FZF_COMPLETE
#         bind \t __fzf_complete
#         if ! test "$fish_key_bindings" = fish_default_key_bindings
#             bind -M insert \t __fzf_complete
#         end
#     end
# end


################################# __fzf_find_file.fish
function __fzf_find_file -d "List files and folders"
    set -l commandline (__fzf_parse_commandline)
    set -l dir $commandline[1]
    set -l fzf_query $commandline[2]

    # Find file in ~/
    set -l FZF_FIND_FILE_COMMAND "fd -HIp -tf . ~/"
    begin
        eval "$FZF_FIND_FILE_COMMAND | "fzf "-m $FZF_DEFAULT_OPTS --query \"$fzf_query\"" | while read -l s
            set results $results $s
        end
    end

    if test -z "$results"
        commandline -f repaint
        return
    else
        commandline -t ""
    end

    for result in $results
        commandline -it -- (readlink -f $result)
        commandline -it -- " "
    end
    commandline -f repaint
end


################################# __fzf_reverse_isearch.fish
function __fzf_reverse_isearch
    history merge
    history --show-time='%F %T ' -z | eval fzf --read0 --print0 --tiebreak=index --toggle-sort=ctrl-r $FZF_DEFAULT_OPTS -q '(commandline)' --preview-window hidden | cut -d " " -f 3- | read -lz result
    and commandline -- $result
    commandline -f repaint
end


################################# __fzf_cd.fish
function __fzf_cd -d "Change directory"
    set -l commandline (__fzf_parse_commandline)
    set -l dir $commandline[1]
    set -l fzf_query $commandline[2]

    set -l FZF_CD_COMMAND "
    command find -L $dir \( -path '*/\.git*' -o -fstype 'dev' -o -fstype 'proc' \) -prune \
        -o -type d -print 2> /dev/null | sed 1d"

    eval "$FZF_CD_COMMAND | fzf +m $FZF_DEFAULT_OPTS --query \"$fzf_query\"" | read -l select

    if not test -z "$select"
        builtin cd "$select"

        # Remove last token from commandline.
        commandline -t ""
    end
    # commandline -f repaint
end


################################# __fzf_open.fish
function __fzf_open -d "Open files and directories."
    function __fzf_open_get_open_cmd -d "Find appropriate open command."
        if type -q xdg-open
            echo xdg-open
        else if type -q open
            echo open
        end
    end

    set -l commandline (__fzf_parse_commandline)
    set -l dir $commandline[1]
    set -l fzf_query $commandline[2]

    if not type -q argparse
        set created_argparse
        function argparse
            functions -e argparse # deletes itself
        end
        if contains -- --editor $argv; or contains -- -e $argv
            set _flag_editor yes
        end
    end

    set -l options e/editor
    argparse $options -- $argv

    # open file in ./
    set -l FZF_OPEN_COMMAND "fd -HIp -tf ."

    set -l select (eval "$FZF_OPEN_COMMAND | "fzf "-m $FZF_DEFAULT_OPTS --query \"$fzf_query\"" | string escape)

    # set how to open
    set -l open_cmd
    if set -q _flag_editor
        set open_cmd "$EDITOR"
    else
        set open_cmd (__fzf_open_get_open_cmd)
        if test -z "$open_cmd"
            echo "Couldn't find appropriate open command to use. Do you have 'xdg-open' or 'open' installed?"; and return 1
        end
    end

    set -l open_status 0
    if not test -z "$select"
        # FIXME: if there is space in select/file/dir-name, this function will fail
        set -l file_path (readlink -f $select)
        commandline "$open_cmd $file_path"; and commandline -f execute
        set open_status $status
    end

    commandline -f repaint
    return $open_status
end


################################# __fzf_complete.fish
##
# Use fzf as fish completion widget.
function __fzf_complete -d 'fzf completion and print selection back to commandline'
    # As of 2.6, fish's "complete" function does not understand
    # subcommands. Instead, we use the same hack as __fish_complete_subcommand and
    # extract the subcommand manually.
    set -l cmd (commandline -co) (commandline -ct)

    switch $cmd[1]
        case env sudo
            for i in (seq 2 (count $cmd))
                switch $cmd[$i]
                    case '-*'
                    case '*=*'
                    case '*'
                        set cmd $cmd[$i..-1]
                        break
                end
            end
    end

    set -l cmd_lastw $cmd[-1]
    set cmd (string join -- ' ' $cmd)

    set -l initial_query ''
    test -n "$cmd_lastw"; and set initial_query --query="$cmd_lastw"

    set -l complist (complete -C$cmd)
    # do nothing if there is nothing to select from
    test -z "$complist"; and return

    set -l compwc (echo $complist | wc -w)
    set -l result

    if test $compwc -eq 1
        # if there is only one option dont open fzf
        set result "$complist"
    else
        set -l query
        string join -- \n $complist \
            | eval fzf (string escape --no-quoted -- $initial_query) -1 --print-query (__fzf_complete_opts) \
            | cut -f1 \
            | while read -l r
            # first line is the user entered query
            if test -z "$query"
                set query $r
                # rest of lines are selected candidates
            else
                set result $result $r
            end
        end

        # exit if user canceled
        if test -z "$query"; and test -z "$result"
            commandline -f repaint
            return
        end

        # if user accepted but no candidate matches, use the input as result
        if test -z "$result"
            set result $query
        end
    end

    set prefix (string sub -s 1 -l 1 -- (commandline -t))
    for i in (seq (count $result))
        set -l r $result[$i]
        switch $prefix
            case "'"
                commandline -t -- (string escape -- $r)
            case '"'
                if string match '*"*' -- $r >/dev/null
                    commandline -t -- (string escape -- $r)
                else
                    commandline -t -- '"'$r'"'
                end
            case '~'
                commandline -t -- (string sub -s 2 (string escape -n -- $r))
            case '*'
                commandline -t -- $r
        end
        [ $i -lt (count $result) ]; and commandline -i ' '
    end

    commandline -f repaint
end

test "$argv[1]" = fzf_previewer; and fzf_previewer $argv[2..3]

function __fzf_complete_opts -d 'fzf options for fish tab completion'
    echo $FZF_DEFAULT_OPTS --cycle --reverse --inline-info --no-multi --bind tab:down,btab:up
end


################################# __fzf_get_dir.fish
function __fzf_get_dir -d 'Find the longest existing filepath from input string'
    set dir $argv

    # Strip all trailing slashes. Ignore if $dir is root dir (/)
    if test (string length $dir) -gt 1
        set dir (string replace -r '/*$' '' $dir)
    end

    # Iteratively check if dir exists and strip tail end of path
    while test ! -d "$dir"
        # If path is absolute, this can keep going until ends up at /
        # If path is relative, this can keep going until entire input is consumed, dirname returns "."
        set dir (dirname "$dir")
    end

    echo $dir
end


################################# __fzf_parse_commandline.fish
function __fzf_parse_commandline -d 'Parse the current command line token and return split of existing filepath and rest of token'
    # eval is used to do shell expansion on paths
    set -l commandline (eval "printf '%s' "(commandline -t))

    if test -z $commandline
        # Default to current directory with no --query
        set dir '.'
        set fzf_query ''
    else
        set dir (__fzf_get_dir $commandline)

        if test "$dir" = "." -a (string sub -l 1 $commandline) != '.'
            # if $dir is "." but commandline is not a relative path, this means no file path found
            set fzf_query $commandline
        else
            # Also remove trailing slash after dir, to "split" input properly
            set fzf_query (string replace -r "^$dir/?" '' "$commandline")
        end
    end

    echo $dir
    echo $fzf_query
end
