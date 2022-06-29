### you can use `fish_config` to config a lot of things in WYSIWYG way in browser

set -gx TERM screen-256color
set -gx EDITOR vim
set -gx GOPATH $GOPATH ~/.go
set -gx GO111MODULE on
set -gx GOPROXY https://goproxy.cn
# electron/node, for `npm install -g xxx`, default place is /usr
set -gx NODE_PATH $HOME/.npms/lib/node_modules

# fix the error: "manpath: can't set the locale; make sure $LC_* and $LANG are correct"
set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8
set -gx LANGUAGE en_US.UTF-8

# NOTE: no color of ninja output by default
# diable it since it affects AUR build
# not set -q CMAKE_GENERATOR && command -sq ninja && set -gx CMAKE_GENERATOR Ninja

# NOTE: order in PATH_A will be reversed in final PATH
# NOTE: ~/.local/bin is already in PATH from ~/.profile, so it is not affected
set -l PATH_A $GOPATH/bin $HOME/.npms/bin $HOME/.cargo/bin $HOME/anaconda3/bin $HOME/.local/bin
for path in $PATH_A
    if not contains $path $PATH
        test -d $path; and set -p PATH $path
    end
end

# By default, MANPATH variable is unset, so set MANPATH to the result of `manpath` according to
# /etc/man.config and add the customized man path to MANPATH
test "$MANPATH" = ""; and set -gx MANPATH (manpath | string split ":")

# TODO: `pip install cppman ; cppman -c` to get manual for cpp
# NOTE: use mman script to interactive select the right man page, and show the path of a man page
set -l MANPATH_A $HOME/anaconda3/share/man $HOME/.npms/lib/node_modules/npm/man $HOME/.local/share/man
for path in $MANPATH_A
    if not contains $path $MANPATH
        test -d $path; and set -p MANPATH $path
    end
end

function startup -d "execute it manually only inside fsr fucntion since it is slow"
    if test $DISPLAY
        # fix the Display :0 can't be opened problem
        if xhost >/dev/null 2>/dev/null
            if not xhost | rg (whoami) >/dev/null 2>/dev/null
                xhost +si:localuser:(whoami) >/dev/null 2>/dev/null
            end
        end
    end
end

function set_keyboard --on-event fish_preexec
    if test $DISPLAY
        # change keyboard auto repeat, this improves keyboard experience, such as the scroll in Emacs
        # Check default value and result using `xset -q`
        # 200=auto repeat delay, given in milliseconds
        # 50=repeat rate, is the number of repeats per second
        # or uncomment the following part and use System Preference
        if command -sq uname; and test (uname) = Linux
            if test (xset -q | rg "repeat rate: " | awk '{print $NF}') -ne 50
                xset r rate 200 50
            end
        end
    end
end

set -gx FISHRC (readlink -f ~/.config/fish/config.fish)
test -f ~/.spacemacs.d/init.el; and set -gx EMACS_EL (readlink -f ~/.spacemacs.d/init.el); or set -gx EMACS_EL ~/.spacemacs
test -f ~/.config/nvim/config.lua; and set -gx VIMRC (readlink -f ~/.config/lvim/config.lua)
# Please put the following lines into ~/.bashrc, putting them in config.fish won't work
# This fixes a lot problems of displaying unicodes
# https://github.com/syl20bnr/spacemacs/issues/12257
# export LC_ALL=en_US.UTF-8
# export LANG=en_US.UTF-8
# export LANGUAGE=en_US.UTF-8

# show key code and key name using xev used for other programs such as sxhkd
abbr key "xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf \"%-3s %s\n\", \$5, \$8 }'"

abbr rgr ranger
bind \cd delete-or-ranger # check the BUG part in the function
bind \cq "lazygit status"
bind \cf zz
# TODO: delete it if fish-shell itself fix it
# Ctrl-c/v is bound to fish_clipboard_copy/paste which is not working in non-X
if not test $DISPLAY
    bind --erase \cx # or bind \cx ""
    bind --erase \cv # or bind \cv ""
end

# disable ksshaskpass pop window in KDE
# if it does not always work, uninstall ksshaskpass package
set -e SSH_ASKPASS

# for ~/.linuxbrew/ (brew for linux to install programs)
#set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH ~/.linuxbrew/Library
# set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH ~/anaconda3/lib

# do not use the format above
# http://vivafan.com/2013/03/%E3%80%8Cfish%E3%80%8D%E3%82%B7%E3%82%A7%E3%83%AB%E3%82%92%E5%AE%9F%E9%9A%9B%E3%81%AB%E4%BD%BF%E3%81%86%E3%81%9F%E3%82%81%E3%81%AB/
# for more formats

# remove the greeting message
set fish_greeting
set fish_new_pager 1
set -gx fish_color_user magenta
set -gx fish_color_host yellow
# set the color of the selected on in the drop list of TAB #4695
set -g fish_color_search_match --background=blue

# start fish without configuration
abbr fishtmp "sh -c 'env HOME=\$(mktemp -d) fish'"

# This will save history before create new fish instance(such as tmux pane)
# Remove h in fish_prompt function to be executed in every new fish_prompt
# which will break the command order in current instance when using UP/DOWN
# function hisave --on-event fish_preexec
function h --on-process-exit %self
    history --merge
end
function save_history --on-event fish_preexec
    history --save
end

# fish_preexec is better than fish_prompt since it is executed before head, but empty key like Return doesn't work
function auto-source --on-event fish_preexec -d 'auto source config.fish if gets modified!'
    if not set -q FISH_CONFIG_TIME # if FISH_CONFIG_TIME not set, status != 0
        set -g FISH_CONFIG_TIME (date +%s -r $FISHRC)
    else
        set FISH_CONFIG_TIME_NEW (date +%s -r $FISHRC)
        if test "$FISH_CONFIG_TIME" != "$FISH_CONFIG_TIME_NEW"
            fsr
            set FISH_CONFIG_TIME (date +%s -r $FISHRC)
        end
    end
end

# modified version of default prompt_pwd in /usr/share/fish/functions/prompt_pwd.fish
# if the path is longer than the $COLUMNS (with a little tweak)
# function prompt_pwd -d "Print the current working directory, shortened to fit the prompt"
#     set -l options h/help
#     argparse -n prompt_pwd --max-args=0 $options -- $argv
#     or return

#     if set -q _flag_help
#         __fish_print_help prompt_pwd
#         return 0
#     end

#     # This allows overriding fish_prompt_pwd_dir_length from the outside (global or universal) without leaking it
#     set -q fish_prompt_pwd_dir_length
#     or set -l fish_prompt_pwd_dir_length 1

#     # Replace $HOME with "~"
#     set realhome ~
#     set -l tmp (string replace -r '^'"$realhome"'($|/)' '~$1' $PWD)

#     # NOTE: the following part is modified to put [] around the original version
#     echo [
#     if [ $fish_prompt_pwd_dir_length -eq 0 ]
#         echo $tmp
#     else
#         # Shorten to at most $fish_prompt_pwd_dir_length characters per directory
#         string replace -ar '(\.?[^/]{'"$fish_prompt_pwd_dir_length"'})[^/]*/' '$1/' $tmp
#     end
#     echo ]
# end

function dirp --on-event fish_preexec
    set -g OLDPWD $PWD
end
function path_prompt
    # check if tmux is running in current terminal/tty
    if test $TMUX
        # if the PWD is not the same as the PWD of previous prompt,
        # print the directory changing message
        if set -q OLDPWD
            if test "$OLDPWD" != "$PWD"
                set_color -o green
                set msg (echo "=== $OLDPWD" | sed "s#$HOME#~#g")
                echo $msg
                set msg (echo "==> $PWD" | sed "s#$HOME#~#g")
                echo $msg
                set_color normal
            end
        end
        return
    else
        set_color -o yellow
        echo -n (prompt_pwd)
        set_color normal
        echo
    end
end
function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus

    path_prompt

    # Write pipestatus
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" (set_color $fish_color_status) (set_color --bold $fish_color_status) $last_pipestatus)
    echo -n -s $prompt_status (set_color -o yellow) ">> " (set_color normal)

    measure_time
end

set -gx MEASURE_TIME 0
function tg_mt -d 'Toggle to enable/disable measure_time'
    test $MEASURE_TIME = 0; and set -gx MEASURE_TIME 1; or set -gx MEASURE_TIME 0
    echo MEASURE_TIME: $MEASURE_TIME
end
function measure_time
    if test $MEASURE_TIME != 0
        if test $CMD_DURATION
            if test $CMD_DURATION -gt (math "1000 * 1")
                set secs (math "$CMD_DURATION / 1000")
                printf (set_color red)" ($secs"s")"(set_color normal)
            end
            # clean, in case the old time is still printed in the next prompt
            set CMD_DURATION 0
        end
    end
end

function fsr --description 'Reload your Fish config after configuration'
    source $FISHRC
    startup
    echo $FISHRC is reloaded!
    vars -c >/dev/null 2>/dev/null
end

# tmux related
abbr tls 'tmux list-panes -s'
function tk -d 'tmux kill-session all(default)/single(id)/multiple(id1 id2)/except(-e)/list(-l) sessions'
    if test (ps -ef | rg -w -v rg | rg tmux | wc -l ) = 0
        echo "No tmux server is running!!!"
        return
    end
    set -l options e l
    argparse -n tk $options -- $argv
    or return

    if set -q _flag_l
        tmux ls
        if set -q TMUX_PANE # check if running inside a tmux session
            echo
            echo Already inside tmux session: (tmux display-message -p '#S')
        end
        return
    end
    if not set -q argv[1]
        # check if running inside a tmux session
        set -q TMUX_PANE; and echo Inside a tmux session!
        read -n 1 -l -p 'echo "Kill all sessions? [y/N] "' answer
        test "$answer" = y -o "$answer" = " "; and tmux kill-server
        return
    end

    if test (count $argv) -gt 0
        set -l sid (tmux ls | nl | awk '{print $2}' | sed 's/://g')
        for i in $sid
            if set -q _flag_e
                if not contains $i $argv
                    tmux kill-session -t $i
                    echo Tmux session $i is killed
                end
            else
                if contains $i $argv
                    tmux kill-session -t $i
                    echo Tmux session $i is killed
                end
            end
        end
        echo \n--------------\n
        echo Left sessions:
        tmux ls
    end
end

# or just use 'M-c r', it is defiend in ~/.config/tmux/tmux.conf
abbr tsr 'tmux source-file ~/.config/tmux/tmux.conf; echo ~/.config/tmux/tmux.conf reloaded!'
# this line will make the indentation of lines below it wrong, TODO: weird
# abbr tt 'tmux switch-client -t'
function twp -d 'tmux swap-pane to current pane to the target pane'
    # tmux display-panes "'%%'"
    # read -n 1 -p 'echo "Target pane number? "' -l num
    tmux swap-pane -s $argv
end

alias check 'checkpatch.pl --ignore SPDX_LICENSE_TAG,CONST_STRUCT,AVOID_EXTERNS,NEW_TYPEDEFS --no-tree -f'

function utf8 -d 'convert encoding(argv[1]) file(argv[2]) to UTF-8 file'
    iconv -f $argv[1] -t UTF-8 $argv[2] >"$argv[2]".tmp
    rm -fv $argv[2]
    mv -v $argv[2]{.tmp,}
end
# TODO: the following part will make fish print "No protocol specified" error line
source $HOME/.config/fish/functions/done.fish

# LS_COLORS, color for ls command
# http://linux-sxs.org/housekeeping/lscolors.html
# http://www.bigsoft.co.uk/blog/index.php/2008/04/11/configuring-ls_colors
set -gx LS_COLORS 'ex=01;33:ln=96:*~=90:*.swp=90:*.bak=90:*.o=90:*#=90'

# fix the `^[]0;fish  /home/chz^G` message in shell of Emacs
if test "$TERM" = dumb
    function fish_title
    end
end

function delete-or-ranger -d 'modified from delete-or-exit, delete one char if in command, execute ranger instead exiting the current terminal otherwise'
    set -l cmd (commandline)

    switch "$cmd"
        case ''
            # BUG: ranger will get stuck on the final step of cw(bulkrename)
            # it works fine if running ranger without binding in fish
            ranger
        case '*'
            commandline -f delete-char
    end
end

abbr pm-sl 'sudo pm-suspend' # 'Suspend to ram' in GUI buttom, power button to wake up
abbr pm-hb 'sudo pm-hibernate' # not work in old CentOS6

abbr fpp '~/Public/PathPicker/fpp'
abbr ga 'glances -t 1 --hide-kernel-threads -b --disable-irq --enable-process-extended'
function ml -d 'mutt or neomutt'
    if command -sq neomutt
        set MUTT neomutt
    else if command -sq mutt
        set MUTT mutt
    else
        echo "mutt/neomutt is not installed!"
        return -1
    end
    eval (PXY) $MUTT
end

# User specific aliases and functions
function lsx -d 'cp the full path of a file/dir to sytem clipboard'
    if test $DISPLAY
        if test -f $argv -o -d $argv
            readlink -fn $argv | xc
            readlink -f $argv
            echo \n---- Path Copied to Clipboard! ----
        end
    else
        readlink -f $argv
    end
end
function xcp -d 'paste the echo string into system clipper board'
    echo -n $argv | xc
    echo "'$argv'"
    echo Copied to system clipped board!!!
end
# pastebin service in command line
function bxp -d 'pastebin service in command line'
    eval $argv
    eval $argv | curl -F 'f:1=<-' ix.io
    # slow
    # eval $argv | curl -F 'sprunge=<-' http://sprunge.us
end
#
alias ls 'exa --icons'
alias ll 'exa -l --icons'
function lls -d 'ls/exa operations'
    set -l options l e s r t a "E="
    argparse -n lls $options -- $argv
    or return

    # no dir is given, assign it to .
    # the single quote in `'$argv'` is for directories with space like `~/VirtualBox VMs/`
    set -q argv[1]; and set ARGV '$argv'; or set ARGV .

    if command -sq exa
        set OPT -a -b --color-scale --color=always --icons --changed --time-style iso
        set -q _flag_l; or set -a OPT -l
        set PIP "| nl -v 1 | sort -nr"
        set -q _flag_e; and eval exa $OPT -s extension --group-directories-first $ARGV && return
        set -q _flag_s; and set -a OPT -l -s size; or set -a OPT -s modified
        set -q _flag_r; or set -a OPT -r
        set -q _flag_a; and set -a OPT --git
        set CMD exa
    else
        set OPT --color=yes
        if set -q _flag_l
            set PIP "| nl -v 1 | sort -nr"
        else
            set -a OPT -lh
            set PIP "| nl -v 0 | sort -nr"
        end
        # list and sort by extension, and directories first
        set -q _flag_e; and eval ls $OPT -X --group-directories-first $ARGV && return
        # sort by size(-s) or sort by last modification time
        set -q _flag_s; and set OPT $OPT -lh --sort=size; or set OPT $OPT --sort=time --time=ctime
        # reverse order(-r) or not
        set -q _flag_r; and set -a OPT -r
        set CMD ls
    end

    # tree
    if set -q _flag_t
        # $_flag_E is something like 'target|.git' if it contains multiple targets
        set -q _flag_E; and set OPT2 -I "$_flag_E"; or set OPT2
        if command -sq exa
            # the single '' around $OPT2 because it needs it in command
            eval $CMD $OPT '$OPT2' --tree $ARGV
        else if test -f /usr/bin/tree
            eval /usr/bin/tree -Cashf '$OPT2' $ARGV
        else
            eval find $ARGV | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"
        end
        return
    end

    # list all(-a) or not
    set -q _flag_a; or set -a PIP "| tail -20"

    eval $CMD $OPT $ARGV $PIP
end

# valgrind
# TODO: pip install colour-valgrind
# abbr va='valgrind -v --track-origins=yes'
abbr va 'colour-valgrind --track-origins=yes --leak-check=full --show-leak-kinds=all -s'
# more detail about time
abbr vad 'colour-valgrind --tool=callgrind --dump-instr=yes --simulate-cache=yes --collect-jumps=yes'

abbr kill9 'killall -9'
# get the pid of a gui program using mouse
abbr pid 'xprop | rg -i pid | rg -oe "[0-9]+"'
function psss -d 'pgrep process, used in script'
    ps -ef | rg -w -v rg | rg -i $argv[1] | nl
end
function pss -d 'pgrep process, used in command line'
    # ps aux | rg -w -v rg | rg -i $argv[1] | nl
    set -g PSS 'ps -e -o "user pid ppid pcpu pmem vsz rssize tty stat start time command" | rg -w -v rg'
    if not set -q argv[1]
        eval $PSS | fzf --preview-window hidden
    else
        eval $PSS | rg -i $argv[1] | nl
        # copy the PID for the only process
        # argv[2] is any valid character/words
        if set -q argv[2]; and test (eval $PSS | rg -i $argv[1] | nl | wc -l) = 1
            set pid (pgrep -if $argv[1])
            echo -e "\nPID: " $pid
            if test $DISPLAY
                echo $pid | xc
                echo ---- PID Copied to Clipboard! ----
            end
        end
    end
end
# pkill will not kill processes matching pattern, you have to kill the PID
function pk --description 'kill processes containing a pattern or PID'
    if not set -q argv[1]
        # this part of using fzf is from
        # https://github.com/SidOfc/dotfiles/blob/e94b96b908479950186e42a3709511a0afe300e4/.config/fish/functions/kp.fish
        set -l __kp__pid (ps -ef | sed 1d | eval "fzf $FZF_DEFAULT_OPTS --preview-window hidden -m --header='[kill:process]'" | awk '{print $2}')
        set -l __kp__kc $argv[1]

        if test "x$__kp__pid" != x
            if test "x$argv[1]" != x
                echo $__kp__pid | xargs kill $argv[1]
            else
                echo $__kp__pid | xargs kill -9
            end
            pk
        end
        return
    end

    set result (psss $argv[1] | wc -l)
    if test $result = 0
        echo "No '$argv[1]' process is running!"
    else if test $result = 1
        set -l pid (psss $argv[1] | awk '{print $3}')
        if not kill -9 $pid # failed to kill, $status != 0
            psss $pid | rg $argv[1] # list the details of the process need to be sudo kill
            read -n 1 -p 'echo "Use sudo to kill it? [Y/n]: "' -l arg
            test "$arg" = "" -o "$arg" = y -o "$arg" = " "; and sudo kill -9 $pid
        end
    else
        while test 1
            psss $argv[1]
            test (psss $argv[1] | wc -l) = 0; and return
            read -p 'echo "Kill all of them or specific PID? [a/y/N/index/pid/m_ouse]: "' -l arg2
            if test $arg2 # it is not Enter directly
                if not string match -q -r '^\d+$' $arg2 # if it is not integer
                    if test "$arg2" = y -o "$arg2" = a -o "$arg2" = " "
                        set -l pids (psss $argv[1] | awk '{print $3}')
                        for i in $pids
                            if not kill -9 $i # failed to kill, $status != 0
                                psss $i | rg $argv[1]
                                read -n 1 -p 'echo "Use sudo to kill it? [Y/n]: "' -l arg3
                                test "$arg3" = "" -o "$arg3" = y -o "$arg3" = " "; and sudo kill -9 $i
                            end
                        end
                        return
                    else if test "$arg2" = m # Use mouse the click the opened window
                        # This may be used for frozen emacs specifically, -usr2 or -SIGUSR2
                        # will turn on `toggle-debug-on-quit`, turn it off once emacs is alive again
                        # Test on next frozen Emacs
                        # kill -usr2 (xprop | rg -i pid | rg -oe "[0-9]+")
                        # kill -SIGUSR2 (xprop | rg -i pid | rg -oe "[0-9]+")
                        set -l pid_m (xprop | rg -i pid | rg -oe "[0-9]+")
                        echo Pid is: $pid_m
                        test (psss $pid_m | rg -i emacs); and kill -SIGUSR2 $pid_m; or kill -9 $pid_m
                        return
                    else if test "$arg2" = n
                        return
                    else
                        echo Wrong Argument!
                    end
                else # if it is digital/integer
                    if test $arg2 -lt 20 # index number, means lines of searching result
                        # The "" around $arg2 is in case of situations like 10 in 1002
                        set -l pid_of_index (psss $argv[1] | awk 'NR == n' n=" $arg2 " | awk '{print $3}')
                        if not test $pid_of_index
                            echo $arg2 is not in the index of the list.
                        else
                            # return
                            if not kill -9 $pid_of_index # kill failed, $status != 0
                                psss $pid_of_index | rg $argv[1] # list the details of the process need to be sudo kill
                                read -n 1 -p 'echo "Use sudo to kill it? [Y/n]: "' -l arg4
                                if test $arg4 = "" -o "$arg4" = y -o "$arg4" = " "
                                    # the first condition is to check Return key
                                    sudo kill -9 $pid_of_index
                                end
                            end
                        end
                    else # pid
                        # The $arg2 here can be part of the real pid, such as typing only 26 means 126
                        if test (psss $argv[1] | awk '{print $3}' | rg -i $arg2)
                            set -l pid_part (psss $argv[1] | awk '{print $3}' | rg -i $arg2)
                            if not kill -9 $pid_part # kill failed, $status != 0
                                psss $pid_part | rg $argv[1] # list the details of the process need to be sudo kill
                                read -n 1 -p 'echo "Use sudo to kill it? [Y/n]: "' -l arg5
                                if test $arg5 = "" -o "$arg5" = y -o "$arg5" = " "
                                    sudo kill -9 $pid_part
                                end
                            end
                        else
                            echo "PID '$arg2' is not in the pid of the list!"
                            echo
                        end
                    end
                end
            else # Return goes here, means `quit` like C-c or no nothing
                return
            end
            sleep 1
        end
    end
end

function vars -d "list item in var line by line, all envs(by default), -m(MANPATH), -c(clean duplicated var), -p(PATH), var name(print value or var)"
    set -l options m c p
    argparse -n vars $options -- $argv
    or return

    if set -q _flag_m
        echo $MANPATH | tr " " "\n" | nl
    else if set -q _flag_c
        for var in PATH MANPATH
            echo "$var Before:"
            echo $$var | tr " " "\n" | nl
            set -l newvar
            set -l count 0
            for v in $$var
                contains -- $v $newvar; and set count (math $count+1); or set newvar $newvar $v
            end
            set $var $newvar
            test $count -gt 0
            echo "After:"
            echo $$var | tr " " "\n" | nl
            echo
        end
    else if set -q _flag_p
        echo $PATH | tr " " "\n" | nl
    else if set -q argv[1] # given any argv
        echo $$var | tr " " "\n" | nl
    else
        env
    end
end
# alias rm 'rm -vi'
# alias cp 'cp -vi'
# alias mv 'mv -vi'
abbr rcp 'rsync --stats --info=progress2 -rh -avz'
abbr rmv 'rsync --stats --info=progress2 -rh -avz --remove-source-files' # this will not delte the src dir, only the contents
# clear the content in the terminal, unlike C-l
# alias clr 'clear; tmux clear-history'
function cll -d "clear the terminal history buffer and repeat the last command or argv"
    echo -en "\e[3J" # clean the terminal history buffer for real
    clear
    if test "$history[1]" != cll
        set -g lastcommand $history[1]
    end
    # the x is to prevent exiting fish to bash for new fish session
    if not set -q argv[1]; and test "$lastcommand" != cll; and test "$lastcommand" != x
        eval $lastcommand
    else
        eval $argv
    end
end

function abbrc -d 'clean abbrs in `abbr --show` but not in $FISHRC'
    set abbr_show "abbr -a -U --"

    for abr in (abbr --show)
        set abr_def (echo $abr | sed "s/$abbr_show//g" | awk '{print $1}')
        # echo abr_def: $abr_def
        set def_file $FISHRC
        set num_line (rg -n "^abbr $abr_def " $def_file | cut -d: -f1)
        if not test $num_line # empty
            echo "$abr_def is an abbr in `abbr --show` but not defined in $FISHRC, may be defined temporally or in other file!"
            abbr -e $abr_def
            echo "$abr_def is erased!"
        end
    end
end

abbr wh which
function fu -d 'fu command and prompt to ask to open it or not'
    # $argv could be builtin keyword, function, alias, file(bin/script) in $PATH, abbr
    # And they all could be defined in script or temporally (could be found in any file)
    set found 0
    set abbr_show "abbr -a -U --"

    # Case1: abbr
    if abbr --show | rg "$abbr_show $argv " 2>/dev/null # Space to avoid the extra abbr starting with $ARGV
        set found 1
        set result (abbr --show | rg "$abbr_show $argv ")
    end

    # Case2: alias or function, or executable file
    if type $argv 2>/dev/null # omit the result once error(abbr or not-a-thing) returned, $status = 0
        if test $found = 1 -a (echo (rg -e "^alias $argv |^function $argv |^function $argv\$" $FISHRC))
            # Case3: both abbr and alias/function, duplicated definitions
            # function may be `function func` and `function func -d ...`
            abbrc
            # return
        end
        # only alias or function
        set found 1
        set result (type $argv)
    end

    if test $found = 0
        echo "$argv is not a thing!"
        return
    end

    set result_1 (printf '%s\n' $result | head -1)
    if test (echo $result_1 | rg -e "$abbr_show $argv |is a function with definition") # defined in fish script
        # Case2
        if test (echo $result_1 | rg "is a function with definition") # alias/function
            # function or alias -- second line of output of fu ends with "$path @ line $num_line"
            if test (printf '%s\n' $result | sed -n "2p" | rg -e "\# Defined in")
                set -l result_2 (printf '%s\n' $result | sed -n "2p")
                set def_file (echo $result_2 | awk -v x=4 '{print $x}')
            else # alias in $FISHRC
                set num_line (rg -n -e "^alias $argv " $FISHRC | cut -d: -f1)
                if test "$num_line"
                    set def_file $FISHRC
                end
            end
            not test $def_file; and echo "NOTE: definition file is not found, erased!" && functions -e $argv && return

            set num_line (rg -n -e "^alias $argv |^function $argv |^function $argv\$" $def_file | cut -d: -f1)
            # NOTE: $num_line may contain more than one number, use "$num_line", or test will fail
            if not test "$num_line" # empty, defined but removed, not cleaned
                echo "$argv is an alias/function defined in $def_file!"
                if test (readlink -f $def_file) = $FISHRC
                    functions -e $argv
                    echo "$argv is not defined inside $FISHRC anymore, erased!"
                    return
                else
                    set num_line 1
                end
            else if test (echo "$num_line" | rg " ") # $num_line contains more than one value
                echo "$argv has multiple definitions(alias and function) in $FISHRC: $num_line, please clean them!"
                return
            end
        else # Case1, only handle abbr defined in $FISHRC
            # abbrc
            set num_line (rg -n -e "^abbr $argv " $FISHRC | cut -d: -f1)
            not test "$num_line"; and return; or set def_file $FISHRC
        end

        echo
        read -n 1 -p 'echo "Open the file containing the definition? [y/N]: "' -l answer
        if test "$answer" = y -o "$answer" = " "
            $EDITOR $def_file +$num_line
        end
    else if test (echo $result_1 | rg -i "is a builtin")
        # Case3: $argv in builtin like if
        return
    else # Case4: $argv is a file in $PATH
        set -l file_path (echo $result_1 | awk 'NF>1{print $NF}')
        file $file_path | rg "symbolic link" # print only $argv is symbolic link
        file (readlink -f $file_path) | rg -e "ELF|script|executable" # highlight
        if test (file (readlink -f $file_path) | rg "script") # script can be open
            echo
            read -n 1 -p 'echo "Open the file for editing?[y/N]: "' -l answer
            test "$answer" = y -o "$answer" = " "; and $EDITOR $file_path
        end
    end
end

zoxide init fish | source
alias zz zi
function zzz -d 'use ranger with zoxide'
    not set -q argv[1]; and ranger; or z (zoxide query -i $argv; or test -d $argv && echo $argv) && ranger
end
set -gx _ZO_FZF_OPTS "-1 -0 --reverse"
# -m to mult-select using Tab/S-Tab
set -gx FZF_DEFAULT_OPTS "-e -m -0 --reverse --preview 'fish -c \"fzf_previewer {}\"' --preview-window=bottom:wrap"
set -gx FZF_TMUX_HEIGHT 100%

# C-o -- find file in ~/, C-r -- history, C-w -- cd dir
# C-s -- open with EDITOR, M-o -- open with open
source $HOME/.config/fish/functions/myfzf.fish

# based on '__fzf_complete_preview' function and '~/.config/ranger/scope.sh' file
function fzf_previewer -d 'generate preview for completion widget.
    argv[1] is the currently selected candidate in fzf
    argv[2] is a string containing the rest of the output produced by `complete -Ccmd`
    '

    if test "$argv[2]" = "Redefine variable"
        # show environment variables current value
        set -l evar (echo $argv[1] | cut -d= -f1)
        # echo $argv[1]$$evar
    else
        # echo $argv[1]
    end

    set -l path (string replace "~" $HOME -- $argv[1])

    # previwer for different file/dir types
    # check ~/.config/ranger/scope.sh for more types
    set -l MIMETYPE (file --dereference --brief --mime-type -- $path)
    switch $MIMETYPE
        case "text*" application/json
            bat --style=rule --color=always --line-range :500 $path
        case "video*" "audio*" "image*"
            mediainfo $path
        case inode/directory
            ls -lhA $path
        case application/x-alpa-package "application/x-*compressed-tar" application/zstd application/zip
            bsdtar --list --file $path
        case application/x-rar
            unrar l -p- -- $path
        case "*"
            ls -lh $path
    end

    # if fish knows about it, let it show info
    type -q "$path" 2>/dev/null; and type -a "$path"

    # show aditional data
    echo $argv[2]
end

# touch temporary files
abbr tout 'touch ab~ .ab~ .\#ab .\#ab\# \#ab\# .ab.swp ab.swp'
# find
# alias find 'find -L' # make find follow symlink dir/file by default
function finds -d 'find a file/folder and view/edit using less/vim/emacs/emx/cd/readlink with fzf, find longest path(-L)'
    set -l options l v e x c p g d L
    argparse -n finds $options -- $argv
    or return

    if not set -q argv[2] # no argv[2]
        set ARGV1 .
        set ARGV2 $argv[1]
    else
        set ARGV1 $argv[1]
        set ARGV2 $argv[2]
    end

    if set -q _flag_l # find a file and view it using less
        if test (find $ARGV1 -iname "*$ARGV2*" | wc -l) = 1
            find $ARGV1 -iname "*$ARGV2*" | xargs less
        else
            # fzf part cannot handle when result is only one file
            find $ARGV1 -iname "*$ARGV2*" | fzf --bind 'enter:execute:command less {} < /dev/tty'
        end
    else if set -q _flag_v # find a file and view it using vim
        if test (find $ARGV1 -iname "*$ARGV2*" | wc -l) = 1
            find $ARGV1 -iname "*$ARGV2*" | xargs vim
        else
            # fzf part cannot handle when result is only one file
            find $ARGV1 -iname "*$ARGV2*" | fzf --bind 'enter:execute:vim {} < /dev/tty'
        end
    else if set -q _flag_e # find a file and view it using emm
        emm (find $ARGV1 -iname "*$ARGV2*" | fzf)
    else if set -q _flag_x # find a file and view it using emx
        emx (find $ARGV1 -iname "*$argv[2]*" | fzf)
    else if set -q _flag_c # find a folder and try cd into it
        cd (find $ARGV1 -type d -iname "*$ARGV2*" | fzf)
    else if set -q _flag_p # find a file/folder and copy/echo its path
        if not test $DISPLAY
            readlink -f (find $ARGV1 -iname "*$ARGV2*" | fzf)
        else
            find $ARGV1 -iname "*$ARGV2*" | fzf | xc
        end
    else if set -q _flag_g # find all the .git directory
        find $ARGV1 -type d -iname .git | sort
    else if set -q _flag_d # find directory
        find $ARGV1 -type d -iname "*$ARGV2*"
    else if set -q _flag_L # find the longest path of file/dir
        # ARGV2 is the the type such as d or f
        find $ARGV1 -type $ARGV2 -print | awk '{print length($0), $0}' | sort -n | tail
    else # find file/directory
        find $ARGV1 -iname "*$ARGV2*"
    end
end
function fts -d 'find the temporary files such as a~ or #a or .a~, and files for latex, if no argv is passed, use the current dir'
    set -l options c C r R l
    argparse -n fts $options -- $argv
    or return

    # no dir is given, assign it to .
    set -q argv[1]; and set ARGV $argv; or set ARGV .

    if set -q _flag_c # one level, not recursive, print
        find $ARGV -maxdepth 1 \( -iname "*~" -o -iname "#?*#" -o -iname ".#?*" -o -iname "*.swp*" \) | xargs -r ls -lhd | nl
    else if set -q _flag_C # one level, not recursive, remove
        find $ARGV -maxdepth 1 \( -iname "*~" -o -iname "#?*#" -o -iname ".#?*" -o -iname "*.swp*" \) | xargs rm -rfv
    else if set -q _flag_r # recursive, print, default action without option
        find $ARGV \( -iname "*~" -o -iname "#?*#" -o -iname ".#?*" -o -iname "*.swp*" \) | xargs -r ls -lhd | nl
    else if set -q _flag_R # recursive, remove
        find $ARGV \( -iname "*~" -o -iname "#?*#" -o -iname ".#?*" -o -iname "*.swp*" \) | xargs rm -rfv
    else if set -q _flag_l # remove temporary files for latex
        if not find $ARGV -maxdepth 1 -iname "*.tex" | rg '.*' # normal find returns 0 no matter what
            echo "$ARGV is not a LaTeX directory!"
            return
        end
        for EXT in ind ilg toc out idx aux fls log fdb_latexmk nav snm
            # ind ilg toc out idx aux fls log fdb_latexmk faq blg bbl brf nlo dvi ps lof pdfsync synctex.gz
            find $ARGV -maxdepth 1 \( -iname "*.$EXT" -o -iname auto \) | xargs -r rm -rv
        end
        fts -C
    else
        find $ARGV \( -iname "*~" -o -iname "#?*#" -o -iname ".#?*" -o -iname "*.swp*" \) | xargs -r ls -lhd | nl
    end

end

function fdd -d 'fd to replace mlocate/plocate'
    set -l options a v m d o O x r e w p "E=" H "t="
    argparse -n fdd $options -- $argv
    or return

    set OPT
    set -q _flag_a; or set -a OPT --exclude Steam
    # NOTE: -H here means exclude hidden files/dirs
    set -q _flag_H; or set -a OPT -HI
    # NOTE: -d and -w don't work well with -p, so do not use -p if using -d or -w
    if not set -q _flag_d; and not set -q _flag_w
        set -a OPT -p
    end
    set -q _flag_d; and set -a OPT -td
    set -q _flag_w; and set -a OPT -g
    # NOTE: $_flag_E must be the whole name of file/dir
    set -q _flag_E; and set -a OPT "-E $_flag_E"

    if set -q _flag_v
        set EXT -e mp4 -e mkv -e avi -e webm -e mov -e rmvb -e flv
    else if set -q _flag_m
        set EXT -e mp3 -e flac -e ape -e wav -e w4a -e dsf -e dff
    else if set -q _flag_p
        set EXT -e pdf
    else if set -q _flag_t
        set EXT "-e $_flag_t"
    end

    set ARGV . && set DIR .
    if set -q argv[2] # two args
        set ARGV $argv[-2] && set DIR $argv[-1]
    else if set -q argv[1] # only one argv
        # if the only argv is a path, make it DIR, otherwise make it ARGV
        # NOTE: if argv[-1] is the path, it is better to use ./dir, or dir/ or /path/to/dir
        if test -d $argv[-1]
            set ARGV . && set DIR $argv[-1]
        else
            set ARGV $argv[-1] && set DIR .
        end
    else # no argv
        set ARGV . && set DIR .
    end

    test $DIR = /; and set -a OPT -E /sys -E /proc -E /run/user

    # NOTE: use double quote for CMD to successfully parse the variables
    # single quote to handle space in ARGV/DIR(file/dir name)
    set CMD "fd $OPT $EXT '$ARGV' '$DIR'"
    # NOTE: dua will think the fd returns . if fd fails to find nothing
    # so this step is needed, otherwise it affects the rest operations
    if test (eval $CMD -1 | wc -l) = 0
        echo "Not found!!!"; and return
    end
    set CMD "$CMD | sort"

    # NOTE: the -0 + --print0 in fzf to be able to work with file/dir with spaces
    # NOTE: DO NOT add --print0 it into FZF_DEFAULT_OPTS
    # -r in xargs is --no-run-if-empty
    if set -q _flag_o
        if set -q _flag_O
            eval $CMD >/tmp/fdd-list
            echo "Ouput list into /tmp/fdd-list"
        else
            # 2>/dev/null is for Ctrl-c to cancel in fzf, otherwise it will print error for o
            o (eval $CMD | fzf -1) 2>/dev/null
        end
    else if set -q _flag_x
        eval $CMD | fzf -1 | xc && xc -o
    else if set -q _flag_r
        eval $CMD | fzf --print0 | xargs -0 -r rm -rfv
    else if set -q _flag_e
        eval $CMD | fzf -1 --print0 | xargs -0 -r vim --
    else
        set CMD2 "dua -f binary a --no-sort ($CMD)"
        # may fail: dua: "the size of argument and environment lists xMB exceeds the OS limit of 2MB."
        # may fail2: dua: "IO Errors" (dua-cli/issues/124)
        # if failed, use CMD: fd without dua
        eval $CMD2 >/dev/null; or set CMD2 $CMD
        if test "$ARGV" = "."
            # just print it, otherwise the list will all be highlighted
            eval $CMD2 | fzf --no-sort --print0 --preview-window hidden
        else
            # --passthru for rg is to highlight the word but also print non-highlighted lines
            eval $CMD2 | rg -i -p --passthru $ARGV
        end
    end
end

# df+du+gdu/dua
function dfs -d 'df(-l, -L for full list), gua(-i), dua(-I), du(by default), cache/config dir of Firefox/Chrome/paru/pacman'
    set -l options i I l L c t m s
    argparse -n dfs $options -- $argv
    or return

    if set -q _flag_i
        if command -sq dua
            dua -f binary i $argv # NOTE: even if argv is empty, this works too
        else if command -sq gdu
            gdu $argv
        end
    else if set -q _flag_I
        dua -f binary i $argv/* # NOTE: even if argv is empty, this works too
    else if set -q _flag_l
        df -Th | rg -v -e "rg|tmpfs|boot|var|snap|opt|tmp|srv|usr|user"
    else if set -q _flag_L
        df -Th
    else if set -q _flag_t
        set -q argv[1]; and set ARGV $argv[1]; or set ARGV 20G
        # if /tmp is out of space, temporally resize /tmp, use 20G if argv is not provided
        sudo mount -o remount,size=$ARGV,noatime /tmp
    else if set -q _flag_m
        # if "/tmp/.mount_xxx Transport endpoint is not connected", argv is /tmp/.mount_xxx
        fusermount -zu $argv && rm -rfv $argv
    else if set -q _flag_c
        set dirs ~/.cache/google-chrome ~/.config/google-chrome \
            ~/.cache/mozilla ~/.mozilla \
            ~/.cache/paru/clone ~/.cache/calibre \
            ~/.local/share/Trash \
            /var/cache/pacman/pkg /tmp
        set dirs_e
        for i in $dirs
            test -d $i; and set dirs_e $dirs_e $i
        end
        dua -f binary a --no-sort $dirs_e
    else if set -q _flag_s # get the largest files list
        if not set -q argv[1] # no given argv, argv is the number of GB
            sudo find / -xdev -type f -size +5G -print0 | xargs -0 ls -1hsS | sort -nk 1 | nl -v 1
        else
            sudo find / -xdev -type f -size +{$argv}G -print0 | xargs -0 ls -1hsS | sort -nk 1 | nl -v 1
        end
    else
        # argv contains /* at the end of path or multiple argv
        test (count $argv) -gt 0; and dua -f binary $argv; or dua -f binary .
    end
end

function wee -d 'wrap watch and watchexec'
    set -l options x n "e=" "i="
    # -w can be used multiple times with values
    set -a options (fish_opt -s w --multiple-vals)
    argparse $options -- $argv
    or return

    if set -q _flag_x # to use watchexec
        set OPT --shell=fish
        set -q _flag_n; and set -a OPT -N
        # if -w or -e is not specified, watch everything in the current dir
        # -w is to specify the file/dir path (can be used multiple times)
        # -e is to specify the extension, comma-separated list if multiple
        # -i to ignore paths, useful for dir like build, NOTE: ignore build using -i "build/**"
        if set -q _flag_w
            for i in $_flag_w
                set -a OPT -w $i
            end
        end
        set -q _flag_e; and set -a OPT -e $_flag_e
        set -q _flag_i; and set -a OPT -i $_flag_i
        watchexec $OPT -- "echo -e \n'==================================================> $argv' ; eval $argv"
    else
        while test 1
            date
            eval $argv
            sleep 1
            echo
        end
    end
end
# stop less save search history into ~/.lesshst
# or LESSHISTFILE=-
# set -gx LESSHISTFILE /dev/null $LESSHISTFILE
function m
    # check if argv[1] is a number
    # `m 100 filename` (not +100)
    # BUG: after viewing the right line, any navigation will make point back to the beginning of the file
    echo $argv[1] | awk '$0 != $0 + 0 { exit 1 }'; and less -RM -s +G$argv[1]g $argv[2]; or less -RM -s +Gg $argv
end
#more
abbr me 'm $EMACS_EL'
abbr mh 'm /etc/hosts'
abbr m2 'm ~/Recentchange/TODO'
abbr mf 'm $FISHRC'
#
alias less 'less -iXFR -x4 -M' # -x4 to set the tabwidth to 4 instead default 8
# NOTE: there is a package called mdv, don't use it
function mdv -d 'markdown viewer in terminal'
    if command -sq glow
        glow $argv
    else if command -sq mdcat
        mdcat -p $argv
    else if command -sq pandoc; and command -sq lynx
        pandoc $argv | lynx --stdin
    else
        echo "Please make sure pandoc+lynx or mdcat are installed!"
    end
end

# TODO: pip install cppman; cppman -c # it will take a while
abbr manp cppman

# color in man page
# K jump link inside vim man page
set -gx MANPAGER 'vim +Man! -c "set signcolumn=no"'
set -gx PAGER 'less -iXFR -x4 -M'

abbr ifw 'ifconfig wlp5s0'
abbr mpp "ip route get 1.2.3.4 | cut -d' ' -f8 | head -1"
abbr mppa "ifconfig | sed -En 's/127.0.0.1//;s/.inet (addr:)?(([0-9].){3}[0-9])./\2/p'"
# abbr nl 'nload -u H p4p1'
abbr nll 'nload -u H wlp8s0'
abbr nh 'sudo nethogs wlp5s0'
# =ifconfig= is obsolete! For replacement check =ip addr= and =ip link=. For statistics use =ip -s link=.
# abbr ipp 'ip -4 -o address'
abbr ipp 'ip addr'
abbr m-c 'minicom --color=on'

function tars -d 'tar extract(x)/list(l, by default)/create(c, add extra arg to exclude .git dir), fastest(C, add extra arg to exclude .git), -o(open it using gui client)'
    set -l options x l c C o X z g
    argparse -n tars $options -- $argv
    or return

    # remove the end slash in argv[1] if it is a directory
    test -d $argv[1]; and set ARGV (echo $argv[1] | sed 's:/*$::'); or set ARGV $argv[1]

    # create zip
    set -q _flag_z; and zip -r $ARGV.zip $ARGV && return

    # get extension of the archive
    set -l EXT (string lower (echo $ARGV | sed 's/^.*\.//'))
    if test "$EXT" = zip -o "$EXT" = rar -o "$EXT" = 7z
        # NOTE: the following line doesn't work for file like dir.tar.xz
        set -l FILE (string split -m1 -r '.' $ARGV)[1]
        # using unar -- https://unarchiver.c3.cx/unarchiver is available
        # if the code is not working, try GBK or GB18030
        # unzip zip if it is archived in Windows and messed up characters with normal unzip
        # `unzip -O CP936`
        if set -q _flag_l # list
            command -sq lsar; and lsar $ARGV; or unzip -l $ARGV
        else if set -q _flag_c # list Chinese characters
            zips.py -l $ARGV
        else if set -q _flag_x
            if set -q _flag_o # extract contents into $argv[2] directory, no new dir
                command -sq unar; and unar $ARGV -D -o $argv[2]; or unzip $ARGV -d $argv[2]
            else
                command -sq unar; and unar $ARGV; or unzip $ARGV -d $FILE
            end
            return
        else if set -q _flag_X # extract Chinese characters
            zips.py -x $ARGV
        else if not set -q _flag_o
            unzip -l $ARGV # -l
        end
    else # j for .bz2, z for .gz, J for xz, a for auto determine
        if set -q _flag_x # extract
            if set -q _flag_o
                tar xvfa $argv[1] -C $argv[2]
            else
                # extract into dir based on the tar file
                tar xvfa $argv --one-top-level
            end
            return
        else if set -q _flag_l # list contents
            tar tvfa $argv
        else if set -q _flag_c # create archive, smaller size, extremely slow for big dir
            # create a multiple-part archive:
            # tar cvfJ - target-dir/ | split --bytes=100M - target.tar.xz.
            # open it using:
            # cat target.tar.xz.* | tar xvfa -
            if set -q _flag_g
                tar cvfa $ARGV.tar.xz $ARGV --exclude-vcs
                echo -e "\nNOTE: tar.xz excluding .git directory!"
            else
                tar cvfa $ARGV.tar.xz $ARGV
            end
        else if set -q _flag_C # create archive, faster speed
            if set -q _flag_g
                tar cvf - $ARGV --exclude-vcs | zstd -c -T0 --fast >$ARGV.tar.zst
                echo -e "\nNOTE: tar.xz excluding .git directory!"
            else
                tar cvf - $ARGV | zstd -c -T0 --fast >$ARGV.tar.zst
            end
        else
            tar tvfa $argv
        end
    end

    if set -q _flag_o # open it using file-roller
        command -sq file-roller; and file-roller $ARGV
    end
end

function deb -d 'deb package, list(default)/extract(x)'
    set -l options x
    argparse -n deb $options -- $argv
    or return

    if set -q _flag_x # extract
        set pkgname (basename $argv[1] .deb)
        mkdir -v $pkgname
        if command -sq dpkg # check if dpkg command exists, replace which
            dpkg -x $argv[1] $pkgname
        else
            set dataname (ar t $argv[1] | rg data)
            if not ar p $argv[1] $dataname | tar Jxv -C $pkgname 2>/dev/null # failed, $status != 0
                if not ar p $argv[1] $dataname | tar zxv -C $pkgname 2>/dev/null # failed, $status != 0
                    rm -rfv $pkgname
                    return
                end
            end
        end
        echo ----in $pkgname ----
    else # default, list
        dpkg -c $argv
    end
end
function rpms -d 'rpm file, install(i)/extract(x)/list(default)'
    set -l options i x
    argparse -n rpms $options -- $argv
    or return

    if set -q _flag_i # install
        sudo rpm -Uvh $argv
    else if set -q _flag_x # extract
        for i in $argv
            echo \<$i\>
            echo -------------------
            rpm2cpio $i | cpio -idmv
        end
    else # default list
        for i in $argv
            rpm -qlpv $i
        end
    end
end

# yum for fedora/redhat/centos/...
abbr yum 'sudo yum -C --noplugins' # not update cache
abbr yumi 'sudo yum install'
abbr yumiy 'sudo yum install -y'
abbr yumr 'sudo yum remove'
abbr yumri 'sudo yum reinstall -y'
abbr yumca 'sudo yum clean all -v'
abbr yumu 'sudo yum --exclude=kernel\* upgrade' # this line will be '=kernel*' in bash
abbr yumuk 'sudo yum upgrade kernel\*'
abbr yumue 'sudo yum update --exclude=kernel\*'
abbr yumul 'sudo yum history undo last'
abbr yumhl 'sudo yum history list'
abbr yumun 'sudo yum history undo'
abbr yums 'sudo yum search'
abbr yumsa 'sudo yum search all'
# dnf for fedora/redhat/centos/...
abbr dnfu 'sudo dnf update -v'
abbr dnfU 'sudo dnf update --setopt exclude=kernel\* -v'
abbr dnfu2 'sudo dnf update -y --disablerepo="*" --enablerepo="updates"'
abbr dnfc 'sudo dnf clean all'
abbr dnfi 'sudo dnf install -v'
abbr dnfr 'sudo dnf remove -v'
abbr dnfl 'dnf list installed| less'
abbr dnfs 'sudo dnf search'
abbr dnfsa 'sudo dnf search all'
abbr dnful 'sudo dnf history undo last'

# zypper for openSUSE/...
abbr zppi 'sudo zypper install --details'
abbr zppiy 'sudo zypper install -y -v --details'
abbr zppif 'sudo zypper info'
abbr zppwp 'sudo zypper search --provides --match-exact' # dependencies
abbr zppr 'sudo zypper remove --details'
abbr zppld 'zypper lr -d' # list repo
abbr zpprr 'sudo zypper rr' # +repo_num in zppld to remove a repo
abbr zpplr 'sudo zypper lr -u --details'
abbr zpps 'sudo zypper search -v'
abbr zppsi 'sudo zypper search -i -v'
abbr zppsd 'sudo zypper search -d -C -i -v' # also search description and summaries
abbr zppu 'sudo zypper update --details'
abbr zppud 'sudo zypper dist-upgrade -l --details'
abbr zppdup 'sudo zypper dist-upgrade -l --details --no-recommends'
abbr zppca 'sudo zypper clean --all'

# apt for ubuntu/debian/kali...
abbr appi 'sudo apt install -V'
abbr appu 'sudo apt update'
abbr appuu 'sudo apt update; sudo apt full-upgrade -V'
abbr appr 'sudo apt remove -V'
abbr appc 'sudo apt clean'
abbr appar 'sudo apt autoremove -Vy'
abbr apps 'apt-cache search' # apt will search in a lof of extra info which is not useful
abbr appsh 'apt show'
abbr appl 'apt list --installed | rg'
abbr applu 'apt list --upgradable'
abbr appd 'apt depends'

# TODO
function repo_extra -d "add 3party repoes for Manjaro/ArchLinux"
    if not rg -q archlinuxcn /etc/pacman.conf
        # use single quote instead of double quote to avoid parsing $varable
        echo -e '
# https://github.com/archlinuxcn/repo
# https://repo.archlinuxcn.org/x86_64/
# install archlinuxcn-keyring
# from archlinuxcn-mirrorlist package
[archlinuxcn]
SigLevel = Optional TrustedOnly
Server = https://repo.archlinuxcn.org/$arch
Server = https://mirrors.sjtug.sjtu.edu.cn/archlinux-cn/$arch
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch

# https://www.blackarch.org/downloads.html#mirror-list
# https://philosophos.github.io/articles/20170305~Installing-BlackArch-on-top-of-ArchLinux/
# NOTE: Disabled by default since when you try to `pacs -cp xxx`/`paru -F`/`pacman -F`:
# "error: blackarch database is inconsistent: version mismatch on package xxx"
#[blackarch]
#SigLevel = Optional TrustAll
#Server = https://mirrors.tuna.tsinghua.edu.cn/blackarch/blackarch/os/$arch
#Server = https://mirrors.ustc.edu.cn/blackarch/blackarch/os/$arch
#Server = https://mirrors.nju.edu.cn/blackarch/blackarch/os/$arch
#Server = https://mirror.sjtu.edu.cn/blackarch/blackarch/os/$arch
#Server = https://mirrors.aliyun.com/blackarch/blackarch/os/$arch

# https://aur.chaotic.cx/
# https://archlinux.pkgs.org/rolling/chaotic-aur-x86_64/
# install chaotic-keyring
# from package chaotic-mirrorlist package
[chaotic-aur]
# Singapore
Server = https://sg-mirror.chaotic.cx/$repo/$arch
# Seoul, Korea
Server = https://kr-mirror.chaotic.cx/$repo/$arch
# India
Server = https://in-mirror.chaotic.cx/$repo/$arch
Server = https://in-2-mirror.chaotic.cx/$repo/$arch
# Automatic per-country routing of the mirrors below.
Server = https://geo-mirror.chaotic.cx/$repo/$arch
# CDN (delayed syncing)
Server = https://cdn-mirror.chaotic.cx/$repo/$arch
# USA
Server = https://us-ut-mirror.chaotic.cx/$repo/$arch
# Spain
Server = https://es-mirror.chaotic.cx/$repo/$arch
Server = https://es-1-mirror.chaotic.cx/$repo/$arch
# Germany
Server = https://de-mirror.chaotic.cx/$repo/$arch
Server = https://de-1-mirror.chaotic.cx/$repo/$arch
Server = https://de-2-mirror.chaotic.cx/$repo/$arch
Server = https://de-3-mirror.chaotic.cx/$repo/$arch
# France
Server = https://fr-mirror.chaotic.cx/$repo/$arch
# São Carlos, Brazil
Server = https://br-mirror.chaotic.cx/$repo/$arch
# Bulgaria
Server = https://bg-mirror.chaotic.cx/$repo/$arch
# Toronto, Canada
Server = https://ca-mirror.chaotic.cx/$repo/$arch

# https://github.com/arcolinux/arcolinux-mirrorlist
[arcolinux_repo_3party]
SigLevel = Optional TrustAll
# Singapore
Server = https://mirror.jingk.ai/arcolinux/$repo/$arch
# South Korea
Server = https://mirror.funami.tech/arcolinux/$repo/$arch
# Europe Netherlands Amsterdam
Server = https://ant.seedhost.eu/arcolinux/$repo/$arch
# Gitlab United States
Server = https://gitlab.com/arcolinux/$repo/-/raw/master/$arch
# Europe Belgium Brussels
Server = https://ftp.belnet.be/arcolinux/$repo/$arch
# Australia
Server = https://mirror.aarnet.edu.au/pub/arcolinux/$repo/$arch
[arcolinux_repo_xlarge]
SigLevel = Optional TrustAll
# Singapore
Server = https://mirror.jingk.ai/arcolinux/$repo/$arch
# South Korea
Server = https://mirror.funami.tech/arcolinux/$repo/$arch
# Europe Netherlands Amsterdam
Server = https://ant.seedhost.eu/arcolinux/$repo/$arch
# Gitlab United States
Server = https://gitlab.com/arcolinux/$repo/-/raw/master/$arch
# Europe Belgium Brussels
Server = https://ftp.belnet.be/arcolinux/$repo/$arch
# Australia
Server = https://mirror.aarnet.edu.au/pub/arcolinux/$repo/$arch
' | sudo tee -a /etc/pacman.conf
        sudo pacman -Fy && sudo pacman -S --needed --noconfirm archlinuxcn-keyring chaotic-keyring chaotic-mirrorlist paru
    end
end
function pacs -d 'pacman/paru operations'
    set -l options i u y r d l c g m f s L n a h k p
    argparse -n pacs $options -- $argv
    or return

    command -sq paru; or repo_extra

    # lower the argv
    set ARGV (string lower $argv)

    # NOTE do not use -y with -c/-d
    if not set -q _flag_c; and not set -q _flag_d
        set -q _flag_y; and set -a ARGV --noconfirm
    end

    # NOTE: the order of options and sub-options, sub-option in another option may affect
    # the other option, it may cause wrong execution order if you provide option/sub-option
    if set -q _flag_h
        echo "      --> update the system"
        echo "      argv --> search argv"
        echo "      -h --> usage"
        echo "      -y --> pacman/paru with noconfirm"
        echo "      -m --> get fastest mirror from China by default"
        echo "         + argv --> get mirrors from argv country"
        echo "         + -l --> list local mirrors"
        echo "         + -s --> get status of local mirrors(Only Manjaro)"
        echo "         + -i --> interactively choose mirror(Only Manjaro)"
        echo "      -i --> install(need argv, pkg name, pkg file or pkg link)"
        echo "         + -p --> print 20 lines of installed/removed/upgraded packages history"
        echo "           + argv --> print all pacman history of the argv package"
        echo "           + -a --> print all installed/removed/upgraded packages history"
        echo "           + -a argv --> print all installed/removed/upgraded packages history of the argv package"
        echo "         + -u --> update the system and install the argv"
        echo "         + -r --> reinsall argv"
        echo "         + -d --> download argv without installing it"
        echo "         + -a --> specific from AUR"
        echo "      -c --> clean/check"
        echo "         + no argv --> clean packages in /var/cache/pacman/pkg"
        echo "         + -p argv --> check which packages require argv"
        echo "         + argv --> check if argv is owned/provided by a pacakge, otherwise delete it"
        echo "      -u --> update, force refresh database first"
        echo "         + -l --> download files list from database"
        echo "         + -p --> print upgradable packages"
        echo "         + -d --> downgradable update"
        echo "      -d --> delete/uninstall with dependencies(need argv)"
        echo "      -g --> list all local and remote groups"
        echo "         + argv --> list all packages in argv group"
        echo "         + -l --> list only the local groups and packages in the groups"
        echo "           + argv --> list only the local packages in argv group"
        echo "      -s --> show info(need argv)"
        echo "         + -l --> get source link and send it to clipper"
        echo "           + -a --> get source link info and send it to clipper"
        echo "         + -L --> list conetnet of argv package"
        echo "           + -a --> specfic from AUR"
        echo "         + -a --> specfic from AUR"
        echo "      -l --> list local installed packages(name+description)"
        echo "         + -n --> list installed packaegs, names only"
        echo "           + argv --> list installed packages containing argv keyword in name"
        echo "         + -a --> specfic from AUR"
        echo "         + -r argv --> list all packages from argv repo"
        echo "         + -r -L argv --> list installed/local packages from argv repo"
        echo "         + -p --> print installed pacakges stats"
        echo "         + -L --> print explicitly installed packages"
        echo "         + argv --> list installed packages containing argv keyword in name or description"
        echo "      -L --> list content of pacakges, the same as -s -L"
        echo "         + argv --> from a package"
        echo "         + -a argv --> including AUR package that may not be installed"
        echo "      -n --> search argv in only packages name part"
        echo "         + argv --> search argv in only packages(repo) name part"
        echo "         + -a argv --> search argv in only packages(repo+AUR) name part "
        echo "         + --> list all packages in repo"
        echo "         + -a --> list all packages in repo+AUR"
        echo "      -a --> search all using paru, slow since inlcuding AUR"
        echo "      -k --> check for missing files in packages"
    else if set -q _flag_m # mirror
        set -q _flag_l; and cat /etc/pacman.d/mirrorlist && return
        set -q argv[1]; and set ARGV $argv[1]; or set ARGV China
        if not test (cat /etc/*-release | rg "^NAME=" | rg -i -e 'manjaro') # ArchLinux
            not command -sq reflector; and pacs -i reflector
            sudo reflector --verbose --country $ARGV --latest 8 --sort rate --save /etc/pacman.d/mirrorlist
        else # manjaro
            ! command -sq pacman-mirrors; and pacs -i pacman-mirrors
            if set -q _flag_s # get status of local mirrors
                pacman-mirrors --status
            else if set -q _flag_i # insteractive choose mirror
                sudo pacman-mirrors -i -d
            else # change mirror region
                sudo pacman-mirrors -f 5 -c $ARGV
            end
        end
    else if set -q _flag_i # install
        if set -q _flag_p # list pacman log
            set KEYWORDS "--color always -e 'installed|reinstalled|removed|upgraded|warning'"
            # NOTE: need to us eval to use this pipeline variable
            set -q _flag_a; and set MAX; or set MAX "| tail -20"
            if set -q argv[1]
                eval "rg --color always $argv[1] /var/log/pacman.log | rg $KEYWORDS $MAX"
            else
                eval "rg $KEYWORDS /var/log/pacman.log $MAX"
            end
            return
        end

        # -S to install a package, -Syu pkg to ensure the system is update to date then install the package
        set -q _flag_u; and set OPT $OPT -Syy; or set OPT $OPT -S

        # -r to reinstall, no -r to ignore installed
        set -q _flag_r; and set OPT $OPT; or set OPT $OPT --needed

        # jus download the pacakge without installing it, NOTE: not append OPT
        set -q _flag_d; and set OPT -Sw --cachedir ./

        # install package from a local .pkg.tar.xz/link file, NOTE: not append OPT
        echo $ARGV | rg -q pkg.tar; and set OPT -U

        # install directly from AUR since some packages from extra repo have the same name with AUR
        set -q _flag_a; and set -a OPT -a

        # NOTE: if you see "File /var/cache/pacman/pkg/xxx.pkg.tar.xz is corrupted (invalid or corrupted package (PGP signature))"
        # use `sudo pacman-key --refresh-keys`
        # all keyrings are stored in /usr/share/pacman/keyrings/
        eval paru $OPT $ARGV
    else if set -q _flag_c # clean/check
        if not set -q argv[1] # no given argv
            # use `paru -Sc` to clean interactively
            paru -c # clean unneeded dependencies
            # paru -Rsun (paru -Qtdq)
            paccache -rvk2 # clean installed packaegs, keep the last two versions
            paccache -rvuk0 # clean uninstalled packages
        else
            if set -q _flag_p # check which package contains argv file/binary/config
                # -x is to handle situation the file in pacakge is not all lowercase
                paru -Fx $ARGV
            else
                # check if package/bin/conf/file is owned by others, if not, delete it
                # This can also be used when the following errors occur after executing update command:
                # "error: failed to commit transaction (conflicting files) xxx exists in filesystem"
                # After executing this function with xxx one by one, execute the update command again
                # https://wiki.archlinux.org/index.php/Pacman#.22Failed_to_commit_transaction_.28conflicting_files.29.22_error
                # NOTE: this can be also used to check what package provides the file/command/package
                not pacman -Qo $ARGV; and sudo rm -rfv $ARGV
            end
        end
    else if set -q _flag_u # force refresh update/upgrade, NOTE: pacs without anything also update
        # download files list into /var/lib/pacman/sync
        set -q _flag_l; and paru -Fy >/dev/null

        # download db into /var/lib/pacman/sync
        if set -q _flag_d
            # allow downgrade, needed when switch to old branch like testing->stable or
            # you seen local xxx is newer than xxx
            paru -Syuu
        else if set -q _flag_p # print upgradable packages
            paru -Qeu
        else
            # force a full refresh of database and update the sustem
            # must do this after switching branch/mirror
            paru -Syyu
        end
    else if set -q _flag_d # delete/uninstall
        # dry-run first (-p for pacman/paru, no need root permission)
        # if confirmed, delete/uninstall argv including dependencies
        if paru -Rscp $ARGV # in case $ARGV is not found
            read -n 1 -l -p 'echo "Really uninstall? [y/N] "' answer
            test "$answer" = y -o "$answer" = " "; and paru -Rscn --noconfirm $ARGV
        end
    else if set -q _flag_g # group
        # all available groups(not all) and their packages: https://archlinux.org/groups/
        # if given argv, list only the target group
        if set -q _flag_l # list only the local groups and packages in the groups
            paru -Qg $ARGV | sort
        else # list all(local+repo) groups and pacakges in the groups
            paru -Sg $ARGV | sort
        end
    else if set -q _flag_s # show info
        set -q argv[1]; or echo "Need argv" && return
        if set -q _flag_l # get source link and send it to clipper
            if set -q _flag_a # get AUR source link and send it to clipper
                paru -Sia $ARGV | rg "AUR URL" | awk '{print $4}' | xc && xc -o
            else
                if paru -Q $ARGV >/dev/null 2>/dev/null
                    # installed
                    paru -Qi $ARGV | rg "^URL" | awk '{print $3}' | xc && xc -o
                else
                    # not installed, the same pacakge may in multiple repos
                    paru -Si $ARGV | rg -m 1 "^URL" | awk '{print $3}' | xc && xc -o
                end
            end
            open (xc -o) >/dev/null 2>/dev/null
        else if set -q _flag_L # list content in a pacakge
            set -q _flag_a; and set OPT -a
            pacman -Ql $ARGV
            or paru -Fl $OPT $ARGV
        else # just show info
            set -q _flag_a; and set OPT -a
            # show both local and remote info
            paru -Qi $OPT $ARGV
            paru -Si $OPT $ARGV
        end
    else if set -q _flag_l # list installed pcakges containing the keyword(including description)
        if set -q _flag_n
            if not set -q argv[1] # if no argv, list all installed packages names
                paru -Q
            else
                paru -Q | rg $ARGV
            end
        else if set -q _flag_a # list packages installed from AUR
            paru -Qm
        else if set -q _flag_r # list packages from repo
            # and: list installed/local packages from repo
            # or: list all(remote and local) packages from repo
            set -q _flag_L; and paclist $ARGV; or paru -Sl $ARGV
        else if set -q _flag_p # print all stats about packages in system
            paru -Ps
        else if set -q _flag_L # list all explicitly installed packages
            paru -Qet
        else
            paru -Qs $ARGV
        end
    else if set -q _flag_L # list content in a pacakge
        set -q argv[1]; or echo "Need one or more package names!" && return
        set -q _flag_a; and set OPT -a
        paru -Ql $ARGV; or paru -Fl $OPT $ARGV
    else if set -q _flag_n # search only keyword in package names
        if set -q argv[1]
            if set -q _flag_a
                paru -Sl | awk -v PKG=$ARGV '$2~PKG' | rg $ARGV
            else
                # NOTE: PKG cannot be ARGV which is the same name as $ARGV
                # awk part is to search the second column which is the package name only
                pacman -Sl | awk -v PKG=$ARGV '$2~PKG' | rg $ARGV
                or paru -Sl | awk -v PKG=$ARGV '$2~PKG' | rg $ARGV
            end
        else # list all packages, no filter
            set -q _flag_a; and paru -Sl; or pacman -Sl
        end
    else if set -q _flag_a # search all including repo and aur
        paru $ARGV
    else if set -q _flag_k # check for missing files in packages
        # use this when you see something like "warning: xxx path/to/xxx (No such file or directory)"
        # or "warning: could not get file information for path/to/xxx", especially python pacakges
        paru -Qk | rg warning
    else # just search repo, if not found, search it in aur
        if set -q argv[1] # given argv
            # if failed with pacman, using paru directly (paru including aur is slow)
            pacman -Ss $ARGV; or paru $ARGV
        else
            # check if there are updates using checkupdates(non-root), if there are, update using paru(need root)
            # paru = pacman/paru -Syu, update, check -u option for more
            checkupdates
            set return_code $status
            if test $return_code -eq 0
                notify-send "There are updates from pacman/paru!"
                # if three times passed no password is typed, 
                # use `faillock --user chz --reset` to unlock the password attempt for root
                # timeout here in case forget to type password and then 3 attemps passed
                timeout 60 paru -Syu $ARGV
            else if test $return_code -eq 2
                echo "Already Up To Date!"
            end
            # otherwise, return_code=1, such as network issue
        end
    end
end

# donnot show the other info on startup
abbr gdbi 'gdb -q -x ~/Dotfiles.d/misc/gdbinit'
abbr gdbx 'gdb -q -n' # with loading any .gdbinit file
abbr gdbd 'sudo gdb -batch -ex "thread apply all bt" -p' # -p $PID to check the deadlock issue, or `sudo strace -s 99 -ffp $PID`
abbr gdbu 'gdbgui --gdb-args="-q -n"'
# debug the core dump binary and file, by default the core dump file is
# located in /var/lib/systemd/coredump (Arch Linux) or in current running dir
# if it is lz4, decompress it, and `gdb ./file core-file`
# Using the following abbr to debug the latest core dump binary
abbr gdbc 'coredumpctl gdb -1'
function gdbt -d "using gdb with tmux panes"
    set -l id (tmux split-pane -hPF "#D" "tail -f /dev/null")
    tmux last-pane
    set -l tty (tmux display-message -p -t "$id" '#{pane_tty}')
    gdb -q -x ~/Dotfiles.d/misc/gdbinit -ex "dashboard source -output $tty" "$argv"
    tmux kill-pane -t $id
end

# make the make and gcc/g++ color
function gcc-a
    set BIN (echo (string split .c $argv) | awk '{print $1;}')
    /usr/bin/gcc -Wpedantic -fsanitize=address,undefined -Wall -W -g -o $BIN $argv 2>&1 | rg --color always -iP "\^|warning:|error:|undefined|"
end
function g++-a
    set BIN (echo (string split .cpp $argv) | awk '{print $1;}')
    /usr/bin/g++ -Wpedantic -fsanitize=address,undefined -Wall -W -g -o $BIN $argv 2>&1 | rg --color always -iP "\^|warning:|error:|undefined|"
end
abbr gcc-w 'gcc -g -Wall -W -Wsign-conversion'
abbr gcca 'gcc -g -Wpedantic -fsanitize=address,undefined -Wall -W -Wconversion -Wshadow -Wcast-qual -Wwrite-strings -Wmissing-prototypes -Wno-sign-compare -Wno-unused-parameter'
# gcc -Wall -W -Wextra -Wconversion -Wshadow -Wcast-qual -Wwrite-strings -Werror

function mess -d 'meson related functions'
    set -l options r c "C=" t s l i u
    argparse -n mess $options -- $argv
    or return

    if set -q _flag_C # passing build directory
        set BUILDDIR $_flag_C
    else
        set -q argv[1]; and set BUILDDIR $argv[1]; or set BUILDDIR builder
    end

    if set -q _flag_r # release build
        test -d $BUILDDIR; and meson --buildtype=release $BUILDDIR --reconfigure; or meson $BUILDDIR
        mesom compile -C $BUILDDIR
    else if set -q _flag_c # meson compile = ninja
        if test -f build.ninja
            # argv is the target to compile, empty to compile the only target
            meson compile $argv
        else
            meson compile -C $BUILDDIR
        end
    else if set -q _flag_t
        # `meson test` can be used to run the binary, need to set test in meson.build
        if test -f build.ninja
            # arg is the test name to test, empty to test the only test
            meson test $argv
        else
            test -d $BUILDDIR; and meson test -C $BUILDDIR; or echo "`meson test` inside build directory"
        end
    else if set -q _flag_s # subprojects
        test -f subprojects; and mkdir subprojects
        if set -q _flag_l
            not set -q argv[1]; and meson wrap list; or meson wrap list | rg $argv
        else if set -q _flag_i
            meson wrap status
        else if set -q _flag_u
            meson wrap update
        else
            meson wrap install $argv
        end
    else # build by default
        if test -f meson.build # inside root
            # by default, setup debug build, use mess -r to setup release build
            test -d $BUILDDIR; and meson $BUILDDIR --reconfigure; or meson $BUILDDIR
        else if test -f build.ninja # inside build
            meson compile $argv
        else if test -d $BUILDDIR
            meson compile -C $BUILDDIR
        else
            echo "meson.build doesn't exist, create it..."
            # argv is the project name, build is the build directory
            meson init --name (basename $PWD) --build
        end
    end
end

# static code analyzer, another tool is from clang-analyzer which is scan-build
# https://clang-analyzer.llvm.org/scan-build.html
# https://clang.llvm.org/extra/clang-tidy/
# scan-build make or scan-build gcc file.c or clang --analyze file.c or clang-tidy file.c
abbr cppc 'cppcheck --enable=all --inconclusive'

function o -d "open, xdg-open, xdg-utils"
    set -l options u "p="
    argparse -n xdgs $options -- $argv
    or return

    if set -q _flag_u # update mimeapps.list for this $argv file
        # $argv[1] is the desktop file for the program to open the file
        # $argv[2] is the file to be opened
        xdg-mime default $argv[1] (xdg-mime query filetype $argv[2])
    else if set -q _flag_p # show the mimetype and the default program for opening the $argv file
        echo (xdg-mime query filetype $_flag_p) = (xdg-mime query default (xdg-mime query filetype $_flag_p))
    else
        # https://github.com/chmln/handlr
        # Simple xdg-open or open will not handle . and file propertly
        handlr open $argv
    end
end

function fmts -d "compile_commands.json(-l), clang-format(-f), cmake-format(-m)"
    set -l options f l m
    argparse -n fmts $options -- $argv
    or return

    if set -q _flag_l
        # Read https://github.com/MaskRay/ccls/wiki/Project-Setup for compile_commands.json
        # test -f build/compile_commands.json; and command rm -rf build
        # test -f compile_commands.json; and command rm -rf compile_commands.json

        # generate compile_commands.json file for C/C++ files used by ccls/lsp
        if test -f CMakeLists.txt
            cmake -H. -B build -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
            test -f build/compile_commands.json; and ln -nsfv build/compile_commands.json .
        else if test -f meson.build
            if test -d build
                # compile_commands.json is only updated by meson compile(ninja) if no --reconfigure
                meson build --reconfigure
            else
                meson build
            end
            test -f build/compile_commands.json; and ln -nsfv build/compile_commands.json .
        else if test -f scripts/gen_compile_commands.py # available for Linux kernel v5+
            make defconfig
            if test $status = 0; and make
                scripts/gen_compile_commands.py
            end
        else if test -f Makefile -o -f makefile # NOTE: some old linux kernel src contains the Makefile/makefile, this will fail
            # NOTE: If inside old linux kernel, check https://github.com/gniuk/linux-compile-commands for more info
            # make clean # without this line, the compile_commands.json generated may be empty

            # NOTE: pip install scan-build to get intercept-build
            if command -q intercept-build; and command intercept-build --append -v make
            else if command -q compiledb; and command compiledb -f -v -n make
            else if command -q bear; and command bear --append -- make
            else
                echo "None of scan-build/compiledb/bear is not installed or all failed to generate compile_commands.json!"
            end
        end
        find . -name "compile_commands.json" -exec ls -lh {} +
    end

    if set -q _flag_f # .clang-format file for C/Cpp projects used by clang-format
        ln -nsfv ~/Dotfiles.d/misc/clang-format-c-cpp .clang-format
        or cp -v ~/Dotfiles.d/misc/clang-format-c-cpp .clang-format
    end

    if set -q _flag_m # .cmake-format.json file for CMakeLists.txt used by cmake-format
        if test -f CMakeLists.txt # TODO: combine the two conditions
            ln -nsfv ~/Dotfiles.d/misc/cmake-format.json .cmake-format.json
            or cp -v ~/Dotfiles.d/misc/cmake-format.json .cmake-format.json
        end
    end
end

function syss -d 'systemctl related functions'
    set -l options u
    argparse -n syss $options -- $argv
    or return

    # current user or using default sudo
    set -q _flag_u; and set PRI systemctl --user; or set PRI systemctl

    set -q argv[1]; and eval $PRI status $argv && return

    set keys (seq 1 20)
    set values \
        list-unit-files \
        status \
        enable \
        disable \
        reenable \
        mask \
        unmask \
        restart \
        start \
        stop \
        daemon-reload \
        --failed \
        suspend \
        hibernate \
        hybrid-sleep \
        reboot \
        poweroff \
        "journalctl -xe" \
        "systemd-analyze blame && systemd-analyze time && return" \
        "systemd-analyze blame > ./boottime && \
        systemd-analyze time >> ./boottime && \
        systemd-analyze plot > ./boottime.svg && \
        echo 'file: ./boottime+./boottime.svg' && \
        display ./boottime.svg"

    echo -e "Usage: syss \n \
      Check all the services of the user if no argv, argv for the argv.service \n\n \
   argv --> status of service \
     -u --> current user or using default sudo \n \
      1 --> systemctl: list-unit-files, list all services status \n \
      2 -->            status name.service \n \
      3 -->            enable name.service \n \
      4 -->            disable name.service \n \
      5 -->            reenable name.service \n \
      6 -->            mask name.service \n \
      7 -->            unmask name.service \n \
      8 -->            restart name.service \n \
      9 -->            start name.service \n \
      10 -->            stop name.service \n \
     11 -->            daemon-reload \n \
     12 -->            --failed \n \
     13 --> power: suspend \n \
     14 -->        hibernate \n \
     15 -->        hibernate-sleep \n \
     16 -->        reboot \n \
     17 -->        poweroff/shutdown \n \
     18 --> journalctrl -xe, the log \n \
     19 --> systemd-analyze: for boot time analyze to the output \n \
     20 -->                  to a file \n"

    read -l -p 'echo "Which one? [index/Enter] "' answer
    if contains $answer $keys
        if contains $answer (seq 2 9)
            read -l -p 'echo "service target: [service]: "' ARG
            test $answer != ""; and eval $PRI $values[$answer] $ARG
        else if test $answer = 1
            read -l -p 'echo "service str: "' ARG
            if test $ARG != ""
                eval $PRI $values[$answer] | rg -i $ARG
                or eval $PRI $$values[$answer] --user | rg -i $ARG
            else
                eval $PRI $values[$answer]
            end
        else if contains $answer 17 18 19 # journalctrl -xe + systemd-analyze
            eval $values[$answer]
        else
            eval $PRI $values[$answer]
        end
    else if test $answer = "" # "" == Enter
        read -l -p 'echo "service target: [service/Enter]: "' ARG
        # if ARG is Enter/empty, list tree structure of all loaded status
        eval $PRI status $ARG
    else
        echo "Wrong answer: $answer"
    end
end

function diffs -d "all kinds of diff features"
    if test (count $argv) = 1
        vim -c "Gvdiffsplit!" $argv
        return
    end
    if command -sq ydiff
        diff -u $argv | ydiff -s -w 0 --wrap
    else
        set -l options f w l L W h
        argparse -n diffs $options -- $argv
        or return

        if set -q _flag_h
            echo "diffs [-f/-w/-l/-L/-W/-h]"
            echo "      no option --> side by side, only diffs"
            echo "      -f --> like no argument, but print whole files"
            echo "      -w --> like no argument, but ignore all white spaces"
            echo "      -l --> line by line, only diffs"
            echo "      -L --> like -l, but print whole files"
            echo "      -W --> like -l, but ignore all white spaces"
            echo "      -h --> usage"
        else if set -q _flag_f
            diff -r -y -s -W $COLUMNS $argv | less
        else if set -q _flag_w
            diff -r -y -s --suppress-common-line -W $COLUMNS -w $argv | less
        else if set -q _flag_l
            diff -r -s --suppress-common-line -W $COLUMNS $argv | less
        else if set -q _flag_L
            diff -r -s -W $COLUMNS $argv | less
        else if set -q _flag_W
            diff -r -s --suppress-common-line -W $COLUMNS -w $argv | less
        else # no option
            diff -r -y -s --suppress-common-line -W $COLUMNS $argv | less
        end
    end
end

function mkcd --description 'mkdir dir then cd dir'
    mkdir -p $argv
    cd $argv
end

# xclip, get content into clipboard, echo file | xclip
alias xc 'xclip -r -selection c'
abbr xp xclip

# emacs
# -Q = -q --no-site-file --no-splash, which will not load something like emacs-googies
alias emx 'emacs -nw -q --no-splash --eval "(setq find-file-visit-truename t)"'
abbr emq 'emacs -q --no-splash'
abbr emd 'emacs --debug-init'
abbr eml 'emacs -q --no-splash --load' # load specific init.el
abbr emn 'emacs --no-desktop'
abbr emtime "time emacs --debug-init -eval '(kill-emacs)'" # time emacs startup time

# the gpl.txt can be gpl-2.0.txt or gpl-3.0.txt
abbr lic 'wget -q http://www.gnu.org/licenses/gpl.txt -O LICENSE'

function usernew -d 'useradd related functions'
    set -l options "d=" t a "g="
    argparse -n usertest $options -- $argv
    or return

    set -q argv[1]; and set ARGV $argv; or set ARGV test

    if set -q _flag_d # delete user and home directory
        if test -d /home/$_flag_d
            sudo userdel -rfRZ $_flag_d
            ll /home/
        end
        return
    end

    if set -q _flag_g
        set -q _flag_d; and sudo groupdel $_flag_d; or sudo usermod -aG $_flag_g $ARGV
        return
    end

    if test -d /home/$ARGV # directory exists
        sudo su -s /bin/bash - $ARGV
    else
        if set -q _flag_t # user test, no password, expire in one day
            sudo useradd -m -e (date -d "1 days" +"%Y-%m-%d") $ARGV -s /sbin/nologin
        else
            if set -q _flag_a # autologin
                sudo useradd -m $ARGV -s /sbin/nologin
            else
                sudo useradd -m $ARGV -s /bin/bash
                sudo passwd $ARGV
            end
        end
        sudo su -s /bin/bash - $ARGV
    end
end

function gits -d 'git related commands'
    set -l options a B c C d D f h H i l m L n o s S t T p P x X R W u
    argparse -n gits $options -- $argv
    or return

    if set -q _flag_h
        echo "      --> git status"
        echo "      -h --> usage"
        echo "      -B --> git branch"
        echo "         -c --> compare branches/commits of diff"
        echo "            -l --> compare branchs/commits of log"
        echo "               -d --> compare branchs/commits or log, save and open diff"
        echo "            -d --> compare branchs/commits of diff, save and open diff"
        echo "         -d --> delete branch"
        echo "            no argv --> delete branch using fzf"
        echo "            argv --> delete branch argv"
        echo "         -f --> switch branch using fzf"
        echo "         -l --> list branches"
        echo "            argv --> search argv branch"
        echo "         no argv --> list local branches"
        echo "         argv --> checkout argv branch if exists, otherwise create new argv branch"
        echo "      -T --> git tag"
        echo "         -f --> switch tag using fzf"
        echo "         no argv --> list all and current tags"
        echo "         argv --> checkout the argv tag"
        echo "      -W --> git worktree"
        echo "         -d argv --> delete argv worktree"
        echo "         no argv --> list all worktrees"
        echo "         argv --> if argv worktree does not exist, create it"
        echo "      -D --> git diff"
        echo "         -u --> show staged but unpushed local diff"
        echo "         -d --> open difftool"
        echo "         -c --> clean untracked files/dirs"
        echo "            argvs --> clean untracked files/dirs argvs"
        echo "            no argv --> clean all untracked files/dirs"
        echo "      -C --> git checkout/commit"
        echo "         -p --> git checkout previous/old commit"
        echo "         -n --> git checkout next/new commit"
        echo "         -l --> git clone"
        echo "            + -s --> git clone shallow"
        echo "            + -x --> set proxy"
        echo "            + -a --> git clone -unshallow"
        echo "            argv --> one argv, clone and cd"
        echo "            argv1 argv2 --> two args, one repo and one target dir and cd"
        echo "         -m --> git commit"
        echo "            -a --> git commit --amend"
        echo "            argv --> git commit -m argv message"
        echo "         no argv --> git checkout the unstaged files/dirs"
        echo "         argvs --> git checkout the unstaged files/dirs of argvs"
        echo "         - --> git checkout the previous branch/commit"
        echo "         argvID --> git checkout the Hash ID"
        echo "      -L --> git log"
        echo "         -f --> git log history of argv file"
        echo "            argv --> git log a history of argv file"
        echo "            no argv --> git log diff of all history"
        echo "         -o --> git log, all in oneline"
        echo "         -s --> list staged files to be commits"
        echo "         -u --> list unpushed commits"
        echo "      -S --> misc, show, stage, sync forked"
        echo "         -u --> show url of a repo"
        echo "            argv --> show url of a git repo argv"
        echo "            no argv --> show url of the current git repo"
        echo "         -s --> stage files/dirs"
        echo "            no argv --> stage all files/dirs"
        echo "            argvs --> stage argvs files/dirs"
        echo "         -f --> sync forked repo with upstream code"
        echo "         -t argv --> check if a argv file/dir is under track by git"
        echo "         no argv --> git show the latest commited commit details"
        echo "         argvID --> git show the argv ID commit details"
        echo "      -P --> git pull --rebase"
        echo "         -u --> git push -v"
        echo "            -n --> git push dry"
        echo "         -i --> git pull --rebase=interactive"
        echo "         -p --> locate the current commit id before pull"
        echo "      -X --> set proxy for git"
        echo "         -u --> undo set proxy for git"
        echo "      -R --> git reset"
        echo "         -s --> git reset soft, undo last unpushed/pushed(unpulled) committed, keep changes"
        echo "         -H --> git reset hard, undo last unpushed/pushed(unpulled) committed, delete changes"
        echo "         no argv --> git reset all staged files"
        echo "         argvs --> git reset all argvs files"
    else if set -q _flag_B # branches
        if set -q _flag_c # compare
            if set -q _flag_l # compare two branches or commits of log
                # NOTE: .. and ... are different
                # and are opposite meanings in diff and log
                # https://stackoverflow.com/questions/7251477
                # https://stackoverflow.com/questions/462974
                # $argv[1]/$argv[2] can branch names or commit ids
                if set -q _flag_d # saved in diff file and open it
                    echo git log $argv[1]...$argv[2] >branches.log
                    git log $argv[1]...$argv[2] >>branches.log
                    vim branches.log
                else
                    git log $argv[1]...$argv[2]
                end
            else # compare two branches of commits of diff
                if set -q _flag_d # save in diff filea and open it
                    echo git diff $argv[1]..$argv[2] >branches.diff
                    git diff $argv[1]..$argv[2] >>branches.diff
                    vim branches.diff
                else # compare two branches or two commit of diff
                    set -q _flag_v; and git diff --name-status $argv[1]..$argv[2]; or git diff $argv[1]..$argv[2]
                end
            end
        else if set -q _flag_d # delete branch
            if not set -q argv[1] # no argv, use fzf to choose the branch
                git branch -a | fzf | xargs git branch -d
            else
                git branch -d $argv
            end
        else if set -q _flag_f # use fzf to switch branch
            # NOTE: if the branch is not in `git branch -a`, try `git ls-remote`
            git fetch
            git branch -a | fzf | awk '{print $1}' | sed 's#^remotes/[^/]*/##' | xargs git checkout
        else if set -q _flag_l # list branches, use argv to search it if given
            not set -q argv[1]; and git ls-remote --heads; or git ls-remote --heads | rg -i $argv
        else # switch branch
            if not set -q argv[1] # no argument
                git branch -vv # list local branches
            else # checkout $argv branch if exists, else create it
                git checkout $argv 2>/dev/null
                or git checkout -b $argv
            end
        end
    else if set -q _flag_T # tags 
        if set -q _flag_f # switch tag with fzf
            echo tags/(git tag -ln | fzf | awk '{print $1}') | xargs git checkout
        else # list all tags, with arg, switch the the tag
            # use the following command the fetch all remote tags in there is any
            # git fetch --all --tags
            if not set -q argv[1]
                git tag -ln
                echo -e "------------\nCurrent tag:"
                git describe --tags
            else
                git checkout tags/$argv
            end
        end
    else if set -q _flag_W # worktree
        if set -q _flag_d # delete worktree
            git worktree remove $argv
        else
            if not set -q argv[1] # no argument, list worktree
                git worktree list
            else if test -d $argv
                echo "Directory $argv already exists!"
                return
            else
                git worktree add $argv
                and cd $argv
            end
        end
    else if set -q _flag_D # diff
        if set -q _flag_u # show staged but unpushed local modification
            git diff --cached
        else if set -q _flag_d
            git difftool
        else if set -q _flag_c # clean untracked file/dirs(fileA fileB...), all by default without argv
            if not set -q argv[1] # no given argv, clean all untracked
                git clean -f -d
            else
                set files (string split \n -- $argv)
                for i in $files
                    echo "remove untracked file/dir: " $i
                    git clean -f -d -- $i
                end
            end
        else
            # show unstaged modification
            git diff
        end
    else if set -q _flag_C # checkout
        if set -q _flag_p # git checkout previous/old commit
            git checkout HEAD^1
        else if set -q _flag_n # git checkout next/new commit
            git log --reverse --pretty=%H master | rg -A 1 (git rev-parse HEAD) | tail -n1 | xargs git checkout
        else if set -q _flag_l # git clone
            # https://stackoverflow.com/questions/57335936
            set -q _flag_s; and set DEPTH --depth=1 --no-single-branch; or set DEPTH
            set -q _flag_x; and set CMD (PXY); or set CMD

            # after shallow pull
            set -q _flag_a; and eval $CMD git pull --unshallow && return
            eval $CMD git clone -v $argv $DEPTH
            echo ---------------------------
            # NOTE: not handle git clone a branch, use the full command instead
            # this works when $argv contains or not contains .git
            test (count $argv) -eq 2; and set project $argv[2]; or set project (basename $argv .git)
            test -d $project; and cd $project && echo cd ./$project
        else if set -q _flag_m # commit
            if set -q _flag_a
                git commit --amend
            else
                git commit -m $argv
            end
        else # git checkout
            if not set -q argv[1] # no given files, checkout unstaged modifications
                # in case accidentally git checkout all unstaged modifications
                read -n 1 -l -p 'echo "Checkout all unstaged files? [Y/n]"' answer
                test "$answer" = y -o "$answer" = " "; and git checkout .; or echo "Cancel and exit!" && return
            else
                # pass commit id
                if git merge-base --is-ancestor $argv HEAD 2>/dev/null
                    git checkout $argv
                else if test "$argv" = - # git switch to previous branch/commit
                    git checkout -
                else
                    set files (string split \n -- $argv)
                    for i in $files
                        echo 'git checkout -- for file' $i
                        git checkout -- $i
                    end
                end
            end
        end
    else if set -q _flag_L # log
        if set -q _flag_f # git log history of argv file
            git log -p -- $argv | bat
        else if set -q _flag_o # git log, all in one line
            git log --oneline | bat
        else if set -q _flag_s # list staged files to be commits
            # list staged files to be commited
            git diff --name-only --cached
        else if set -q _flag_u # list unpushed commits
            git log origin/master..HEAD
        else
            lazygit log
        end
    else if set -q _flag_S # show something, stage files, sync forked repo
        if set -q _flag_u # get the url of a repo
            set -q argv[1]; and set ARGV $argv; or set ARGV .
            if test -d $ARGV
                cd $ARGV && git config --get remote.origin.url | xc && xc -o
                set -q argv[1]; and cd -
                echo \n---- Path Copied to Clipboard! ----
            else
                echo Error: $ARGV is not valid!
            end
        else if set _flag_s # stage files/dirs
            if not set -q argv[1] # no given files
                git add .
            else
                set -l files (echo $argv | tr ',' '\n')
                for i in $files
                    echo 'git add for file:' $i
                    git add $i
                end
            end
        else if set -q _flag_f # sync forked repo with upstream code
            git checkout master
            git remote -v | rg upstream >/dev/null 2>/dev/null
            set -l upstream_status $status
            if test $upstream_status = 1; and not set -q argv[1]
                echo "Remote upstream is not set, unable to sync!"
                return
            else
                if test $upstream_status != 0
                    # given argument
                    set -q argv[1]; and git remote add upstream $argv
                end
                # the upstream url may be wrong, `git fetch upstream` will prompt for user/psw
                # use `git remote remove upstream` to remove the wrong upstream url
                git fetch upstream
                git rebase upstream/master
            end
        else if set -q _flag_t # check if a file/dir is under track by git
            git ls-files --error-unmatch $argv
        else
            # [+commit] to show the modification in a last/[specific] commit
            git show $argv
        end
    else if set -q _flag_P
        if set -q _flag_u # push
            if set -q _flag_n # dry push
                git push -v -n
            else
                git push -v
            end
        else # pull
            if set -q _flag_i # interactive pull
                git pull --rebase=interactive
            else if set -q _flag_p
                # git pull and locate it to previous commit id before git pull in git log
                set COMMIT_ID (git rev-parse HEAD) # short version: `git rev-parse --short HEAD`
                git log -1 # show the info of the current commit before git pull
                git pull
                git log --stat | command less -p$COMMIT_ID
            else
                git pull --rebase
            end
        end
    else if set -q _flag_X # set proxy
        set -l SSR socks5://127.0.0.1:1080
        if set -q _flag_u
            git config --global --unset http.proxy
            git config --global --unset https.proxy
            git config --global --unset http.https://github.com.proxy
        else
            git config --global http.proxy $SSR
            git config --global https.proxy $SSR
            git config --global http.https://github.com.proxy $SSR
        end
    else if set -q _flag_R # reset 
        # git reset HEAD for multiple files(file1 file2, all without argv), 
        # soft(-s)/hard(-h) reset
        if set -q _flag_s # undo last unpushed/pushed(unpulled) commit, keep changes
            git reset --soft HEAD~1
        else if set -q _flag_H # undo last unpushed/pushed(unpulled) commit, delete changes
            git reset --hard HEAD~1
        else
            if not set -q argv[1] # no given files
                # in case accidentally git reset all staged files
                read -n 1 -l -p 'echo "Reset all staged files? [Y/n]"' answer
                test "$answer" = y -o "$answer" = " "; and git reset; or echo "Cancel and exit!" && return
            else
                set -l files (echo $argv | tr ',' '\n')
                for i in $files
                    echo 'git reset HEAD for file:' $i
                    git reset HEAD $i
                end
            end
        end
    else
        lazygit status
    end
end

abbr gg lazygit
abbr ggl 'lazygit log'
abbr ggs 'lazygit status'

function sss -d 'count lines of code from a local code dir or a github url'
    set -l options "e=" f F
    argparse -n sss $options -- $argv
    or return

    if echo $argv | rg "https://github.com" >/dev/null 2>/dev/null
        # or use website directly: https://codetabs.com/count-loc/count-loc-online.html
        set -l username_repo (echo $argv | cut -c20-)
        curl "https://api.codetabs.com/v1/loc/?github=$username_repo" | jq -r '(["Files", "Lines", "Blanks", "Comments", "LinesOfCode", "Language"] | (., map(length*"-"))), (.[] | [.files, .lines, .blanks, .comments, .linesOfCode, .language]) | @tsv' | column -t
    else
        set OPT -c --no-cocomo
        # using -f to sort by default(file count), otherwise sort by code lines
        set -q _flag_f; or set OPT $OPT -s code
        set -q _flag_F; and set OPT $OPT --by-file
        # exclude dirs $_flag_e should be dirs separated by ,
        set -q _flag_e; and set OPT $OPT --exclude-dir $_flag_e

        eval scc $OPT $argv
    end
end

# create container example:
# docker run -it -v ~/Public/tig:/Public/tig -net host --name new_name ubuntu:xenial /bin/bash
function docks -d 'docker/podman commands'
    set -l options s S p r R l L t q n
    argparse -n docks $options -- $argv
    or return

    command -sq podman; and set BIN podman; or set BIN docker

    if set -q _flag_s # serach image
        # NOTE: if using podman, put the following line into /etc/containers/registries.conf
        # unqualified-search-registries=["registry.access.redhat.com", "registry.fedoraproject.org", "docker.io"]
        set CMD search
    else if set -q _flag_p # pull image(repo:tag as repo)
        # tag is from `docks -t $repo`
        set CMD pull
    else if set -q _flag_r # remove container(CONTAINER ID as argv)
        set CMD rm
    else if set -q _flag_R # remove image(IMAGE ID as argv)
        set CMD rmi
        # docker rmi $argv
    end

    if set -q CMD # CMD is set
        if set -q _flag_r
            # ARGV is CONTAINER ID
            set ARGV (eval $BIN ps -a --noheading | fzf --preview-window hidden | awk '{print $1}')
        else if set -q _flag_R
            # ARGV is IMAGE ID
            set ARGV (eval $BIN image ls --noheading | fzf --preview-window hidden | awk '{print $3}')
        else
            set ARGV $argv
        end
        test $ARGV; and eval $BIN $CMD $ARGV
        return
    end

    if set -q _flag_l # list all created containers and pulled images
        echo "Pulled images:"
        eval $BIN image ls

        echo -e "\nCreated containers:"
        eval $BIN ps -a
    else if set -q _flag_L # list all verbose info(such as size) of the containers/images installed
        eval $BIN system df --verbose
    else if set -q _flag_t # list tags for a docker image(repo as argv)
        # use this for only the top 10 tags:
        # curl https://registry.hub.docker.com/v2/repositories/library/$argv[1]/tags/ | jq '."results"[]["name"]'
        # if using podman, note the argv[1] is the image
        wget -q https://registry.hub.docker.com/v1/repositories/$argv[1]/tags -O - | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n' | awk -F: '{print $3}'
        and echo -e "\nThese are all the tags!\nPlease use `docks -p $argv[1]:tag` to pull the image!"
        return
    else if set -q _flag_q # stop a running container
        set ID (eval $BIN ps --noheading | fzf --preview-window hidden | awk '{print $1}')
        test $ID; and eval $BIN container stop -t 0 $ID --log-level=debug # if ID is not empty
    else if set -q _flag_S # add a shared folder to existed containerd
        set ID (eval $BIN ps -a | fzf --preview-window hidden | awk '{print $1}')
        read -p 'echo "new container name: "' -l new_name
        eval $BIN commit $ID $new_name
        read -p 'echo "The share folder(absolute path) in host: "' -l share_src
        read -p 'echo "The share folder(absolute path) in container: "' -l share_dst
        eval $BIN run -ti -v $share_src:$share_dst $new_name /bin/bash
    else
        if set -q _flag_n # crate a new container from images
            set IMG_ID (eval $BIN image ls --noheading | fzf --preview-window hidden | awk '{print $3}')
            not test $IMG_ID; and return
            read -p 'echo "The name for the new container: "' -l name
            eval $BIN create -ti --name $name $IMG_ID
        end

        # no option, no argv, run an existed container or create a new one if none
        if test (eval $BIN ps -a | wc -l) = 1
            if test (eval $BIN image ls | wc -l) = 1
                echo "No container no image, need to pull an image first..."
                return
            end
            echo "No container, create a basic one from the existing image..."
            set IMG_ID (eval $BIN image ls --noheading | fzf --preview-window hidden | awk '{print $3}')
            not test $IMG_ID; and return

            read -p 'echo "The name for the new container: "' -l name
            eval $BIN create -ti --name $name $IMG_ID
        end
        set CON_ID (eval $BIN ps -a --noheading | fzf --preview-window hidden | awk '{print $1}')
        not test $CON_ID; and return

        eval $BIN inspect --format="{{.State.Running}}" $CON_ID | rg true >/dev/null 2>/dev/null
        if test $status = 0
            # if the ID is already running, exec it,
            # meaning: start another session on the same running container
            echo -e "\nNOTE: the container is already running in another session...\n"
            eval $BIN exec -it $CON_ID bash
        else
            eval $BIN start -a $CON_ID
        end
    end
end

function PXY
    # proxy client is running
    test (pgrep -f 'shadowsocks|v2ray|clash' | wc -l) != 0; and echo proxychains4 -q
end

abbr bb 'bat -p'

# svn
abbr svnp 'svn update; and echo "---status---"; svn status'
abbr svnpn 'svn update ~/NVR.ori/Code'
abbr svns 'svn status'
abbr svnc 'svn commit -m'
abbr svnd 'svn diff | less'
abbr svnll 'svn log -v -l 10 | less'
function svncf -d 'view old version of a file'
    svn cat -r $argv[1] $argv[2] | less
end
function svnl --description 'view the svn log with less, if arg not passed, using current dir'
    svn log -v $argv[1] | /usr/bin/less
end
function svnlh
    svn log -v $argv[1] | head -$argv[2]
end
function svndd --description 'show the svn diff detail'
    # the revision of whole svn project
    # set Revision (svn info | awk '/Revision/ {print $2}')
    # the revision of current directory
    set Revision (svn log | rg "^r[0-9]\+ | " | cut -d' ' -f1 | cut -c2- | sed -n "1p")
    # TODO: check if argv is 1)integer, 2)number between $Revision and 1 if given
    if test (echo $argv[1] | rg ':' -c) -eq 1
        # if argv is like 1000:1010, then svn diff the two revisions
        svn diff -r $argv[1] | less
    else if test (count $argv) -eq 1
        if test $argv[1] -gt 10
            # if the argv is like 1000, then svn diff revision
            svn diff -c $argv[1] | less
        else
            # if the argv is like 3, the svn diff the 3th commit to the last
            # the PREV is 1
            # if the list of revision is continuous
            # set Rev (echo $Revision-$argv[1]+1 | bc)
            # whether the list is continuous or not
            set Rev (svn log | rg "^r[0-9]\+ | " | cut -d' ' -f1 | cut -c2- | sed -n "$argv[1]p")
            svn diff -c $Rev | less
        end
    else if test (count $argv) = 0
        if test (svn status | wc -l) != 0
            # show the diff if local differs from server
            svn status # in case there are new files
            svn diff | less
        else
            # if no argv is given, and status is clean then svn diff the last commit
            # equals to `svndd` == `svndd 1`
            svn diff -r PREV | less
        end
    else
        echo Arguments are wrong!!!
    end
end

abbr hs 'sudo cp -v ~/Public/hosts/hosts /etc/hosts'

# https://stackoverflow.com/questions/10408816/how-do-i-use-the-nohup-command-without-getting-nohup-out
function meld --description 'lanuch meld from terminal without block it'
    if not command -sq meld
        echo "meld is not installed"
        return -1
    end
    # You could just use
    # bash -c "(nohup /usr/bin/meld $argv </dev/null >/dev/null 2>&1 &)"
    # But it will not work if the name of arguments contains space
    # \"$argv\" like in `ok` does not work for multiple arguments even no space
    set -l argc (count $argv)
    switch $argc
        case 0
            /usr/bin/meld
        case 1
            echo "This is version control comparison, use `command meld file/dir`"
        case 2
            bash -c "(nohup /usr/bin/meld \"$argv[1]\" \"$argv[2]\" </dev/null >/dev/null 2>&1 &)"
        case 3
            bash -c "(nohup /usr/bin/meld \"$argv[1]\" \"$argv[2]\" \"$argv[3]\" </dev/null >/dev/null 2>&1 &)"
        case '*'
            echo Wrong arguments!!!
    end
    return
end

function wc
    test (count $argv) -gt 1; and command wc $argv | sort -n; or command wc $argv
end

abbr ipy ipython # other alternatives are btpython, ptpython, ptipython
abbr pdb pudb3
function pips -d 'pip related functions, default(install), -i(sudo install), -c(check outdated), -d(remove/uninstall), -s(search), -u(update all outdated packages), -U(upgrade specific packages)'
    set -l options i c d s u U l
    argparse -n pips $options -- $argv
    or return

    # if using proxy in OS
    test (PXY); and set REPO "-i https://pypi.tuna.tsinghua.edu.cn/simple"; or set REPO

    if set -q _flag_c
        echo "Outdated packages:"
        # echo "pip:"
        pip list --outdated
        # echo "sudo pip:"
        # sudo pip list --outdated
    else if set -q _flag_u
        if set -q argv[1] # if given argv, update the argv packages
            pip install $REPO -U $argv
        else # else updating all pip packages
            # when using default pip install is slow, use repo from the following url to install
            # pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -U (pip list --outdated | awk 'NR>2 {print $1}')
            # echo "Updating sudo pip packages"
            pip install $REPO -U (pip list --outdated | awk 'NR>2 {print $1}')
        end
    else if set -q _flag_d
        pip uninstall $argv
        or sudo pip uninstall $argv
    else if set -q _flag_s
        if set -q _flag_l # check wich pacakge containing $argv file/path
            pip list | tail -n +3 | cut -d" " -f1 | xargs pip show -f | rg -i $argv
        else
            # pip search $argv
            # if `pip search` fails, then `sudo pip install pip_search` first
            pip_search -s name $argv
        end
    else if set -q _flag_i
        if set -q _flag_l # list all installed pip packages
            # `sudo pip list` is another list
            pip list
        else
            sudo pip install $REPO $argv
        end
    else
        pip install $REPO $argv
    end
end

# install pytest and pytest-pep8 first, to check if the code is following pep8 guidelines
abbr pyp8 'py.test --pep8'
function penv -d 'python3 -m venv in fish'
    set -q argv[1]; and set ARGV $argv; or set ARGV venv

    if not test -d $ARGV
        python3 -m venv $ARGV
    else if not test -f $ARGV/bin/activate.fish
        echo "$ARGV exists but it is not python venv"
        return -1
    end
    . $ARGV/bin/activate.fish
end
# abbr x 'exit'
alias q x
function x -d 'exit or deactivate in python env'
    history --merge
    if set -q VIRTUAL_ENV # running in python virtual env
        # TODO: since sth. is wrong with the deactivate function in $argv/bin/activate.fish
        deactivate >/dev/null 2>/dev/null
        source $FISHRC
    else if set -q CONDA_DEFAULT_ENV # running in conda virtual env
        cons -x
    else
        exit
    end
end

abbr epub 'ebook-viewer --detach'
# alias time 'time -p'

function ssh -d 'show ssh info for current tmux window'
    if set -q TMUX
        # you can see this new name in choose-tree list
        set window_name (tmux display -p '#{window_name}')
        tmux rename-window "ssh $argv"
        command ssh "$argv"
        # restore window_name after exiting ssh session
        tmux rename-window $window_name
    else
        command ssh "$argv"
    end
end

# abbr sss 'ps -eo tty,command | rg -v rg | rg "sudo ssh "'
abbr p 'ping -c 5'
function port -d 'list all the ports are used or check the process which are using the port'
    if test (count $argv) = 1
        sudo lsof -i -P -n | grep LISTEN | rg $argv
    else
        sudo lsof -i -P -n | grep LISTEN
    end
end

abbr pxx 'proxychains4 -q'
function ios -d 'disk/network/OS related'
    set -l options "s=" "h=" g a n N b t
    argparse -n ios $options -- $argv
    or return

    if set -q _flag_s # speed of a drive
        # argv is device like /dev/sda1
        sudo hdparm -Tt $_flag_s
    else if set -q _flag_t # set date/time manually
        if set -q _flag_a # sync date/time from internet automatically
            sudo timedatectl set-ntp 0
            sudo timedatectl set-time (date -d (curl -I 'https://baidu.com/' 2>/dev/null | grep -i '^date:' | sed 's/^[Dd]ate: //g') '+%Y-%m-%d %T')
            sudo hwclock --systohc
            sudo timedatectl set-ntp 1
        else if set -q argv[1] # given argv, temporally
            sudo timedatectl set-ntp 0
            # argv is string like "2022-01-01 01:01:01" or "01:01:01"
            sudo timedatectl set-time "$argv"
            # sudo hwclock --systohc
            # NOTE: if enabling the following line, the time after is always -2 mins to real time (not argv)
            # sudo timedatectl set-ntp 1
        end
        timedatectl status
    else if set -q _flag_h # health of a drive
        # Check the health issue of disk using smartmontools
        # the argv is device like /dev/nvme0n1
        sudo smartctl -a $_flag_h | rg "Percentage Used"
    else if set -q _flag_b # burn ISO file to drive(such as USB as LIVE USB)
        # usage: iso -b ./path/file.iso /dev/sda1
        if file $argv[1] | rg -i ISO >/dev/null 2>/dev/null
            if echo $argv[2] | rg -i dev >/dev/null 2>/dev/null
                set FILE (readlink -f $argv[1])
                set DEV $argv[2]
                lsblk -l
                echo
                # the argv[1] is the iso file, relative path is OK
                # the argv[2] is the dev like /dev/sda
                set CMD "sudo dd if=\"$FILE\" of=$DEV bs=4M status=progress oflag=sync"
                echo $CMD
                read -n 1 -l -p 'echo "Really run above command? [Y/n] "' answer
                if test "$answer" = y -o "$answer" = " " -o "$answer" = ""
                    eval $CMD
                end
            else
                echo $argv[2] is not a /dev/sxx
                return
            end
        else
            echo $argv[1] is not an ISO file!
        end
    else if set -q _flag_g
        gpustat -cp
    else if set -q _flag_n
        if set -q _flag_N # notify is network traffic is lower than argv(5)MB/s
            set -q argv[1]; and set ARGV $argv; or set ARGV 5

            set INTERFACE (ip route get 8.8.8.8 | awk -- '{printf $5}')
            # motified from speed_net bash script
            while true
                set FILE "/sys/class/net/$INTERFACE/statistics"
                set RX (cat $FILE/rx_bytes)
                set TX (cat $FILE/tx_bytes)

                sleep 1

                set RXN (cat $FILE/rx_bytes)
                set TXN (cat $FILE/tx_bytes)

                set RXDIF (math $RXN - $RX)
                set TXDIF (math $TXN - $TX)

                if test "$RXDIF" -lt $(expr $ARGV \* 1024 \* 1024)
                    notify-send -u critical "NOTE: Network speed becomes lower than $ARGV MB/s"
                end
                sleep 30
            end
        else if set -q _flag_a
            while true
                wget -q --show-progress -T 5 -O /dev/null https://downpack.baidu.com/Baidunetdisk_AndroidPhone_1026962m.apk
            end
        else
            wget -q --show-progress -T 5 -O /dev/null https://downpack.baidu.com/Baidunetdisk_AndroidPhone_1026962m.apk
        end
    else if set -q _flag_a # all current speed
        dstat -d -n -m -s -c --nocolor
    else
        if command -sq fastfetch
            fastfetch
        else
            command -sq screenfetch; and screenfetch; or echo "fastfetch/screenfetch are neither installed!"
        end
    end
end

function pxs -d 'multiple commands using proxychains4'
    set -l options w W c p "o="
    argparse -n pxs $options -- $argv
    or return

    # two conditions, one or another
    if test (echo $argv | rg github); or set -q _flag_p
        set CMD (PXY)
    else
        set CMD
    end

    if set -q _flag_w
        # wget -c --mirror -p --html-extension --convert-links
        eval $CMD wget -c --no-check-certificate $argv
    else if set -q _flag_W # for wget that get stuck in middle of downloads
        while true
            eval $CMD wget -c --no-check-certificate -T 5 -c $argv; and break
        end
    else if set -q _flag_c
        eval $CMD curl -L -O -C - $argv
    else # default using aria2
        # the \"\" is to handle magnet link correctly, other links are not affected
        eval $CMD aria2c -c -x 5 --check-certificate=false --file-allocation=none \"$argv\"
    end

    # get the lastest file in current dir and mv/rename it
    set -q _flag_o; and mv -v (ls -Art | tail -n 1) $_flag_o
end

alias dic 'trans :zh -d -show-dictionary Y -v -theme ~/Dotfiles.d/misc/trans-theme-matrix.trans'

# count chars of lines of a file
# awk '{ print length }' | sort -n | uniq -c

function wtp --description 'show the real definition of a type or struct in C code, you can find which file it is defined in around the result'
    gcc -E ~/Dotfiles.d/misc/type.c -I$argv[1] >/tmp/result
    if test (count $argv) -eq 2
        test (echo $argv[1] | rg struct); and rg -A $argv[2] "^$argv[1]" /tmp/result; or rg -B $argv[2] $argv[1] /tmp/result
    else
        rg $argv[1] /tmp/result
    end
end

# interactively(choose format and resolution) stream video using mpv+yt-dlp+fzf
# https://github.com/seanbreckenridge/mpvf/
alias mpvs 'proxychains4 -q mpvf'
function yous -d 'yt-dlp functions'
    set -l options l a f F p P
    argparse -n yous -N 1 $options -- $argv
    or return

    if set -q _flag_l # list all formats
        eval (PXY) yt-dlp -F \"$argv\"
    else if set -q _flag_f # choose the num from the list
        eval (PXY) yt-dlp -ciw -f $argv[1]+bestaudio \"$argv[2]\"
    else if set -q _flag_F
        # sometimes no-option or -f doesn't download the `best` video
        # since the bitrate info in the list for the lower resolution is higher
        eval (PXY) yt-dlp -ciw -f $argv[1] \"$argv[2]\"
    else if set -q _flag_a # only download best audio into mp3
        eval (PXY) yt-dlp -ciw --extract-audio --audio-format mp3 --audio-quality 0 \"$argv\"
    else if set -q _flag_p # download playlist
        eval (PXY) yt-dlp -ciw --download-archive downloaded.txt --no-overwrites -ict --yes-playlist --socket-timeout 5 \"$argv\"
    else if set -q _flag_P # download playlist into audio
        eval (PXY) yt-dlp -ciw --download-archive downloaded.txt --no-overwrites -ict --yes-playlist --extract-audio --audio-format mp3 --audio-quality 0 --socket-timeout 5 \"$argv\"
    else # download video
        eval (PXY) yt-dlp -ciw \"$argv\"
    end
end

function ffms -d 'ffmpeg related functions'
    set -l options c "f=" i "s=" "b="
    argparse -n ffms $options -- $argv
    or return

    if set -q _flag_c # convert to h265
        for videofile in $argv
            # get the extension and filename without extension
            set FILE (string split -r -m1 . $videofile)[1]
            set EXT (string lower (echo $videofile | sed 's/^.*\.//'))
            if set -q _flag_b
                set bitrate $_flag_b # $_flag_b is string like 2000k
            else
                mediainfo --Inform="Video;BitRate=%BitRate/String%" $videofile
                read -p 'echo "What BitRate would be? (2000k) "' bitrate
                test "$bitrate" = " " -o "$bitrate" = ""; and set bitrate 2000k
            end
            if set -q _flag_s # cut slice, argument for -s is like 00:10:00-00:20:00
                set START (string split "-" $_flag_s)[1]
                set END (string split "-" $_flag_s)[2]
                ffmpeg -hide_banner -ss $START -to $END -i $videofile -c:v hevc_nvenc -c:a copy -b:v $bitrate {$FILE}-converted-cut_{$bitrate}.{$EXT}
            else
                ffmpeg -hide_banner -i $videofile -c:v hevc_nvenc -c:a copy -b:v $bitrate {$FILE}-converted_{$bitrate}.{$EXT}
                if set -q _flag_f
                    for file in $videofile {$FILE}-converted_{$bitrate}.{$EXT}
                        ffmpeg -hide_banner -ss $_flag_f -i $file -t $_flag_f {$file}.bmp
                    end
                    open {$videofile}.bmp
                end
            end
        end
    else if set -q _flag_s # only cut slice based on time, argument for -s is like 00:10:00-00:20:00
        set START (string split "-" $_flag_s)[1]
        set END (string split "-" $_flag_s)[2]
        for videofile in $argv
            set FILE (string split -r -m1 . $videofile)[1]
            set EXT (string lower (echo $videofile | sed 's/^.*\.//'))
            ffmpeg -hide_banner -ss $START -to $END -i $videofile -c:v copy -c:a copy {$FILE}-cut.{$EXT}
        end
    else if set -q _flag_f # get a frame losslessly at specific timestamp
        # useful to compare the qualities of two files after using ffms -c
        for file in $argv
            # png in ffmpeg is not lossless, use bmp instead
            # $flag_f is timestamp like 05:00 or 01:01:01
            ffmpeg -hide_banner -ss $_flag_f -i $file -t $_flag_f {$file}.bmp
        end
        test -f $argv[1].bmp; and open $argv[1].bmp; or echo "==Error!=="
    else if set -q _flag_i # info
        for file in $argv
            # `mediainfo --info-parameters` to get all the variables
            mediainfo --Inform="General;%CompleteName%\n%Duration/String2%, %FileSize/String4%" $file
            mediainfo --Inform="Video;%Format%, %Width%x%Height%, %BitRate/String%" $file
            mediainfo --Inform="Audio;%Format%, %Compression_Mode/String%, %BitRate/String%, %SamplingRate/String%" $file
            echo
        end
    end
end

function rgs -d 'rg sth in -e(init.el)/-E(errno)/-f(config.fish)/-i(i3/config)-t(tmux.conf)/-v(vimrc), or use -F(fzf) to open the file, -g(git repo), -w(whole word), -V(exclude pattern), -l(list files), -s(sort), -n(no ignore), -S(smart case, otherwise ignore case), -2(todo.org)'
    # NOTE -V require an argument, so put "V=" line for argparse
    set -l options e E f i t v F g n w 'V=' l s S 2 c
    argparse -n rgs -N 1 $options -- $argv
    or return

    set OPT --hidden -g !.git
    set -q _flag_w; and set OPT $OPT -w
    set -q _flag_l; and set OPT $OPT -l
    set -q _flag_L; and set OPT $OPT -L
    # and $_flag_V is the argument for for -V
    set -q _flag_V; and set OPT $OPT -g !$_flag_V
    set -q _flag_s; and set OPT $OPT --sort path
    set -q _flag_n; and set OPT $OPT --no-ignore
    set -q _flag_S; and set OPT $OPT -s; or set OPT $OPT -i
    set -q _flag_c; and set OPT $OPT -C 3

    if set -q _flag_e
        set FILE $EMACS_EL
    else if set -q _flag_E
        # errno command can be used instead
        for file in /usr/include/asm-generic/errno-base.h /usr/include/asm-generic/errno.h
            rg -i $argv[1] $file
        end
        return
    else if set -q _flag_f
        set FILE $FISHRC
    else if set -q _flag_i
        set FILE ~/.config/i3/config
    else if set -q _flag_t
        set FILE ~/.config/tmux/tmux.conf
    else if set -q _flag_v
        set FILE $VIMRC
    else if set -q _flag_g
        git grep "$argv" (git rev-list --all)
    else if set -q _flag_2
        set FILE ~/Dotfiles.d/todo.org
    else # without options
        if not set -q argv[2] # no $argv[2]
            set FILE .
        else
            # NOTE: take all but the first argv since it may contain wildcard
            set FILE $argv[2..]
        end
    end

    echo "\"$argv[1]" >>~/.lesshst
    rg $OPT -p $argv[1] $FILE | less -i -RM -FX -s

    if set -q _flag_F # search pattern(s) in dir/file, open if using vim
        rg $OPT $argv[1] $FILE -l | fzf --bind 'enter:execute:vim {} < /dev/tty'
    end
end

# ls; and ll -- if ls succeed then ll, if failed then don't ll
# ls; or ll -- if ls succeed then don't ll, if failed then ll

# such as:
# abbr sp 'svn update; and echo "---status---"; svn status'

# if test $status -eq 0; ... else ... # success
# to
# and begin ... end; or ...

# if test $status -eq 1; ... else ... # failure
# to
# or begin ... end; or ...

function cpb -d 'backups manager: rename files/dirs from name to name.bak or backwards(-b) using cp/mv(-m)'
    # set optional options
    set -l options b m
    argparse -n cpb -N 1 $options -- $argv
    or return

    set -q _flag_b; and set backward 1; or set backward 0 # 0(name->name.bak), 1(backward, name.bak->name)
    set -q _flag_m; and set CMD mv -v; or set CMD cp -vr

    for name in $argv # support multiple arguments
        if test $backward = 1
            set -l result (echo (string split -r -m1 .bak $name)[1])
            test -e $result; and echo $result alread exists.; or eval $CMD $name $result
        else
            set old $name
            if test / = (echo (string sub --start=-1 $name)) # for dir ending with "/"
                set old (echo (string split -r -m1 / $name)[1])
            end
            if test -e $old.bak
                echo $old.bak already exists.
                read -n 1 -l -p 'echo "Remove $old.bak first? [y/N]"' answer
                test "$answer" = y -o "$answer" = " "; and rm -rfv $old.bak; or continue
            end
            eval $CMD $old{,.bak}
        end
    end
end

# upx get smaller size than strip
abbr upxx 'upx --best --lzma'
# for all the Rust developement setup:
# https://fasterthanli.me/articles/my-ideal-rust-workflow
function cars -d "cargo commands, -c(clean target), -d(remove/uninstall), -i(install), -r(release build), -S(reduce size)"
    set -l options c C d i n r s S R u p t T m "b=" B w
    argparse -n cars $options -- $argv
    or return

    set CMD (PXY) cargo

    if set -q _flag_n
        if set -q _flag_i
            # crate a new project based on current directory; or create a new project based on argv
            not set -q argv[1]; and cargo init; or cargo init $argv && cd $argv
        else
            eval $CMD new $argv; and cd $argv
        end
    else if set -q _flag_w # NOTE: cargo install cargo-watch
        set -q argv[1]; and eval $CMD watch -x \"$argv\"; or eval $CMD watch -x run
    else if set -q _flag_d
        set -q _flag_m; and eval $CMD doc --no-deps --open; or eval $CMD uninstall $argv
    else if set -q _flag_B # NOTE: cargo install cargo-bloat
        if set -q _flag_t
            echo "list of crates that took longest to compile, it will clean target dir and takes a while"
            eval $CMD bloat --time -j 1
        else
            if set -q _flag_r
                echo "====the biggest dependencies in the release build"
                eval $CMD bloat --release --crates
                echo "====the biggest functions in the release build"
                eval $CMD bloat --release -n 10
            else
                echo "====the biggest dependencies in the release build"
                eval $CMD bloat --crates
                echo "====the biggest functions in the release build"
                eval $CMD bloat -n 10
            end
        end
    else if set -q _flag_c
        if test -d ./target
            # only remove target/release; or remove the whole target
            set -q _flag_r; and eval $CMD clean --release -v; or eval $CMD clean -v
            echo "target cleaned..."
        end
    else if set -q _flag_C
        # clean whole cache in ~/.cargo
        eval $CMD cache -a
    else if set -q _flag_p
        # https://fasterthanli.me/articles/my-ideal-rust-workflow
        eval $CMD clippy --locked -- -D warnings
    else if set -q _flag_R
        set -q _flag_u; and eval env RUST_BACKTRACE=1 $CMD run $argv; or eval $CMD run $argv
    else if set -q _flag_m # view the structure in tree/graph
        if set -q _flag_T # generate and open the build timing graph
            # https://fasterthanli.me/articles/why-is-my-rust-build-so-slow
            cargo clean
            if set -q _flag_r
                env RUSTC_BOOTSTRAP=1 $CMD build --release --quiet -Z timings
            else
                env RUSTC_BOOTSTRAP=1 $CMD build --quiet -Z timings
            end
            test -f ./cargo-timing.html; and o ./cargo-timing.html
        else # NOTE: cargo install cargo-modules
            set -q _flag_b; and set TARGET "--bin $_flag_b"; or set TARGET --lib
            if set -q _flag_t
                eval $CMD modules generate tree --all-features $TARGET
            else
                eval $CMD modules generate graph --all-features $TARGET | xdot -
            end
        end
    else if set -q _flag_t
        if command -sq cargo-nextest # NOTE: cargo install cargo-watch
            eval $CMD nextest run --tests $argv
        else
            # NOTE: do not combine the following if-else into one line and-or
            # since if the -u cargo test line test fail, the other eval will run
            # there are many options for test, try `cargo test --help` and `cargo test -- --help`
            if set -q _flag_u
                eval env RUST_BACKTRACE=1 $CMD test $argv
            else
                eval $CMD test $argv
            end
        end
    else if set -q _flag_s
        eval $CMD search $argv
    else if set -q _flag_u
        rustup update
    else
        if set -q _flag_i; or ! test -f ./Cargo.toml
            # install release version, reduce size by default
            # NOTE: there is --debug(dev) version, huge size difference
            set -l RUSTFLAGS '-C link-arg=-s'
            if echo $argv | rg "https://github.com" >/dev/null 2>/dev/null
                # you can install directly from github repo URL like "cargo install --git https://github.com/user/repo"
                eval $CMD install --git $argv
            else
                eval $CMD install $argv
            end
            and echo -e "\nuse `upx --best --lzma the-bin` to reduce more binary size, better than strip"
        else if test -f ./Cargo.toml # build it
            if set -q _flag_r # build release version
                echo -e "Building release version...\n"
                if set -q _flag_S
                    set -l RUSTFLAGS '-C link-arg=-s'; and eval $CMD build --release $argv
                    echo -e "\nuse `upx --best --lzma the-bin` to reduce more binary size, better than strip \n \
                    NOTE: upx is not working for debug+-s build version"
                else
                    eval $CMD build --release $argv
                end
            else
                echo -e "Building debug version...\n"
                if set -q _flag_S
                    set -l RUSTFLAGS '-C link-arg=-s'; and eval $CMD build --$argv
                else
                    eval $CMD build $argv
                end
            end
        end
    end
end

# Download anaconda from https://mirrors.cloud.tencent.com/anaconda/archive/
# Check ~/.condarc for configuration
# https://www.piqizhu.com/tools/anaconda
# ~/anaconda3/bin/conda install -c binstar binstar # renamed to anaconda-client, so `conda install anaconda-client`
# ~/anaconda3/bin/binstar search -t conda packgename # get the channel(user) name
# ~/anaconda3/bin/conda install -c channel packagename
# After install package using `conda install -c CHANNEL PKG`, you have to manually
# ~/anaconda3/bin/conda config --add channels your_new_channel, or these packages won't be updateed when `condau`
#
# The packages needed to be installed using conda are(only if you have no sudo permission or the offcial is old)
# ~/anaconda3/bin/conda install -c conda-forge ncurses emacs w3m fish the_silver_searcher source-highlight tmux ripgrep
test -f $HOME/anaconda3/etc/fish/conf.d/conda.fish; and source $HOME/anaconda3/etc/fish/conf.d/conda.fish
abbr condas '~/anaconda3/bin/binstar search -t conda' # [packagename]
abbr condai '~/anaconda3/bin/conda install' # [packagename]
abbr condaic '~/anaconda3/bin/conda install -c' # [channel] [packagename]
abbr condau '~/anaconda3/bin/conda upgrade --all -vy; and ~/anaconda3/bin/conda clean -avy'
abbr condac '~/anaconda3/bin/conda clean -avy'
abbr condaS '~/anaconda3/bin/anaconda show' # [channel/packagename]

function cons -d 'conda virtual environments related functions -i(install package in env, -x(exit the env), -l(list envs), -L(list pkgs in env), -r(remove env and its pkgs)), default(switch or pip install argv based on base env), -n(new env with python/pip installed, -b to create new one based on base env)'
    set -l options b i n x l L r
    argparse -n cons $options -- $argv
    or return

    if set -q _flag_x
        if not set -q $CONDA_DEFAULT_ENV # running in conda env
            conda deactivate
            echo "Exit conda env"
        else
            echo "Not in conda env"
        end
    else if set -q _flag_i
        conda install -n $CONDA_DEFAULT_ENV $argv
    else if set -q _flag_l
        conda env list
    else if set -q _flag_L
        if not set -q $CONDA_DEFAULT_ENV; and not set -q argv[1] # running in conda env and no argv, too conditions
            conda list
        else if set -q $CONDA_DEFAULT_ENV; and not set -q argv[1]
            conda list
        else if test "$CONDA_DEFAULT_ENV" != "$argv"
            conda list -n $argv
        end
    else if set -q _flag_r
        # 1. not in env, remove argv
        # 2. in env, another env given as argv, remove the argv
        # 3. in env and (no argv, or argv=current env), deactivate and remove current env
        if set -q $CONDA_DEFAULT_ENV # not in conda env
            if test $argv = base
                echo "!!!Donnot remove base env!!!"
                return -1
            end
            conda remove -n $argv --all
        else if not set -q $CONDA_DEFAULT_ENV # in env
            if test $CONDA_DEFAULT_ENV = base
                echo "!!!base env here, do not remove it!!!"
                return -1
            end
            if set -q argv[1]; and test "$CONDA_DEFAULT_ENV" != "$argv" # given another argv
                conda remove -n $argv --all
            else # no argv or argv=current env
                set argv $CONDA_DEFAULT_ENV
                conda deactivate
                echo "Exit the conda env..."
                conda remove -n $argv --all
            end
        end
    else if set -q _flag_n # new env, at least one argv
        if not set -q argv[1] # no argv
            echo "argv is needed!"
            return -1
        else
            if conda env list | awk '{ print $1 }' | rg -w $argv[1] >/dev/null 2>/dev/null
                # already in conda env list
                echo "env $arv[1] already exists!!!"
                return -1
            else
                if set -q _flag_b
                    # "--clone base" will include all packages in base including ipython
                    conda create -y -n $argv[1] --clone base
                else
                    # only pip/python included
                    conda create -y -n $argv[1] python
                end
                conda activate $argv[1] >/dev/null 2>/dev/null; and echo "conda env switched to $argv[1]"
                if test (count $argv) -gt 1
                    pip install $argv[2..(count $argv)] # array slice in fish shell
                end
            end
        end
    else # no option, switch env or pip install based on base env
        not set -q argv[1]; and conda env list && read -p 'echo "Which conda env switching to: [base?] "' argv
        if conda env list | awk '{ print $1 }' | rg -w $argv[1] >/dev/null 2>/dev/null
            # just enter when `read`, these three are unnecessary
            test "$argv" = ""; and set argv base
            conda activate $argv[1] # if $argv[1] is null, it will be base automatically
            echo "Switched to $argv[1] env..."
            # $argv may contain the env name and extra packages
            test (count $argv) -gt 1; and pip install $argv[2..(count $argv)]
        else
            echo "No such env exists, use `cons -n env_name [pkg_name]` to create new!"
            conda activate base
            echo "Switched to base env..."
            pip install $argv
        end
    end
end
