# Key bindings
# ------------
# this file is modified from https://github.com/junegunn/fzf/blob/master/shell/key-bindings.fish
# binding for fzf-file-widget is changed
# options of find command in fzf-file-widget and fzf-cd-widget is changed
# fzf-complete function is from https://github.com/junegunn/fzf/wiki/Examples-(fish)#completion
function fzf_key_bindings

    # Store current token in $dir as root for the 'find' command
    function fzf-file-widget -d "List files and folders"
        set -l commandline (__fzf_parse_commandline)
        set -l dir $commandline[1]
        set -l fzf_query $commandline[2]

        # "-path \$dir'*/\\.*'" matches hidden files/folders inside $dir but not
        # $dir itself, even if hidden.
        test -n "$FZF_CTRL_T_COMMAND"; or set -l FZF_CTRL_T_COMMAND "
        # "-path \$dir'*/\\.git*'" not search .git, if you need file in .git, use vim .git<Ctrl-s>
        command find -L \$dir -mindepth 1 \\( -path \$dir'*/\\.git*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' \\) -prune \
           -o -type f -print \
           -o -type d -print \
           -o -type l -print 2> /dev/null | sed 's@^\./@@'"

        test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
        begin
            set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS"
            eval "$FZF_CTRL_T_COMMAND | "(__fzfcmd)' -m --query "'$fzf_query'"' | while read -l r; set result $result $r; end
        end
        if [ -z "$result" ]
            commandline -f repaint
            return
        else
            # Remove last token from commandline.
            commandline -t ""
        end
        for i in $result
            commandline -it -- (string escape $i)
            commandline -it -- ' '
        end
        commandline -f repaint
    end

    function fzf-history-widget -d "Show command history"
        test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
        begin
            set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT $FZF_DEFAULT_OPTS --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m"

            set -l FISH_MAJOR (echo $version | cut -f1 -d.)
            set -l FISH_MINOR (echo $version | cut -f2 -d.)

            # history's -z flag is needed for multi-line support.
            # history's -z flag was added in fish 2.4.0, so don't use it for versions
            # before 2.4.0.
            if [ "$FISH_MAJOR" -gt 2 -o \( "$FISH_MAJOR" -eq 2 -a "$FISH_MINOR" -ge 4 \) ];
                history -z | eval (__fzfcmd) --read0 --print0 -q '(commandline)' | read -lz result
                and commandline -- $result
            else
                history | eval (__fzfcmd) -q '(commandline)' | read -l result
                and commandline -- $result
            end
        end
        commandline -f repaint
    end

    function fzf-cd-widget -d "Change directory"
        set -l commandline (__fzf_parse_commandline)
        set -l dir $commandline[1]
        set -l fzf_query $commandline[2]

        test -n "$FZF_ALT_C_COMMAND"; or set -l FZF_ALT_C_COMMAND "
        # change \$dir to $dir/ to include hidden dirs, replace \$dir'*/\\.*' with $dir to include deeper hidden dirs
        command find -L $dir/ -mindepth 1 \\( -path $dir/ -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' \\) -prune \
           -o -type d -print 2> /dev/null | sed 's@^\./@@'"
        test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
        begin
            set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_ALT_C_OPTS"
            eval "$FZF_ALT_C_COMMAND | "(__fzfcmd)' +m --query "'$fzf_query'"' | read -l result

            if [ -n "$result" ]
                cd $result

                # Remove last token from commandline.
                commandline -t ""
            end
        end

        commandline -f repaint
    end

    function fzf-complete -d 'fzf completion and print selection back to commandline'
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
        set cmd (string join -- ' ' $cmd)

        set -l complist (complete -C$cmd)
        set -l result
        string join -- \n $complist | sort | eval (__fzfcmd) -m --select-1 --exit-0 --header '(commandline)' | cut -f1 | while read -l r; set result $result $r; end

        set prefix (string sub -s 1 -l 1 -- (commandline -t))
        for i in (seq (count $result))
            set -l r $result[$i]
            switch $prefix
                case "'"
                    commandline -t -- (string escape -- $r)
                case '"'
                    if string match '*"*' -- $r >/dev/null
                        commandline -t --  (string escape -- $r)
                    else
                        commandline -t -- '"'$r'"'
                    end
                case '~'
                    commandline -t -- (string sub -s 2 (string escape -n -- $r))
                case '*'
                    commandline -t -- (string escape -n -- $r)
            end
            [ $i -lt (count $result) ]; and commandline -i ' '
        end

        commandline -f repaint
    end

    function __fzfcmd
        test -n "$FZF_TMUX"; or set FZF_TMUX 0
        test -n "$FZF_TMUX_HEIGHT"; or set FZF_TMUX_HEIGHT 40%
        if [ -n "$FZF_TMUX_OPTS" ]
            echo "fzf-tmux $FZF_TMUX_OPTS -- "
        else if [ $FZF_TMUX -eq 1 ]
            echo "fzf-tmux -d$FZF_TMUX_HEIGHT -- "
        else
            echo "fzf"
        end
    end

    bind \cs fzf-file-widget
    bind \cr fzf-history-widget
    bind \cw fzf-cd-widget
    bind \cx  fzf-complete

    if bind -M insert > /dev/null 2>&1
        bind -M insert \cs fzf-file-widget
        bind -M insert \cr fzf-history-widget
        bind -M insert \cw fzf-cd-widget
        bind -M insert \cx  fzf-complete
    end

    function __fzf_parse_commandline -d 'Parse the current command line token and return split of existing filepath and rest of token'
        # eval is used to do shell expansion on paths
        set -l commandline (eval "printf '%s' "(commandline -t))

        if [ -z $commandline ]
            # Default to current directory with no --query
            set dir '.'
            set fzf_query ''
        else
            set dir (__fzf_get_dir $commandline)

            if [ "$dir" = "." -a (string sub -l 1 -- $commandline) != '.' ]
                # if $dir is "." but commandline is not a relative path, this means no file path found
                set fzf_query $commandline
            else
                # Also remove trailing slash after dir, to "split" input properly
                set fzf_query (string replace -r "^$dir/?" -- '' "$commandline")
            end
        end

        echo $dir
        echo $fzf_query
    end

    function __fzf_get_dir -d 'Find the longest existing filepath from input string'
        set dir $argv

        # Strip all trailing slashes. Ignore if $dir is root dir (/)
        if [ (string length -- $dir) -gt 1 ]
            set dir (string replace -r '/*$' -- '' $dir)
        end

        # Iteratively check if dir exists and strip tail end of path
        while [ ! -d "$dir" ]
            # If path is absolute, this can keep going until ends up at /
            # If path is relative, this can keep going until entire input is consumed, dirname returns "."
            set dir (dirname -- "$dir")
        end

        echo $dir
    end
end
