### you can use `fish_config` to config a lot of things in WYSIWYG way in browser

set -gx TERM screen-256color
set -gx EDITOR vim
set -gx GOPATH $GOPATH ~/.go
set -gx GO111MODULE on
set -gx GOPROXY https://goproxy.cn
# electron/node, for `npm install -g xxx`, default place is /usr
set -gx NPMS $HOME/.npms
set -gx NODE_PATH $NPMS/lib/node_modules

# fix the error: "manpath: can't set the locale; make sure $LC_* and $LANG are correct"
set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8
set -gx LANGUAGE en_US.UTF-8

# NOTE: no color of ninja output by default
command -sq ninja; and set -gx CMAKE_GENERATOR Ninja

# By default, MANPATH variable is unset, so set MANPATH to the result of `manpath` according to
# /etc/man.config and add the customized man path to MANPATH
if test "$MANPATH" = ""
    set -gx MANPATH (manpath | string split ":")
end

set -gx LBIN (readlink -f ~/.local/bin)
# set -gx PATH $HOME/anaconda3/bin ~/.local/share/arm-linux/bin $LBIN ~/.linuxbrew/bin $GOPATH/bin $PATH
#set -gx PATH $HOME/anaconda3/bin $LBIN $GOPATH/bin /usr/local/bin /usr/local/liteide/bin /bin /sbin /usr/bin /usr/sbin $PATH
set -gx PATH $GOPATH/bin $NPMS/bin $HOME/.cargo/bin $LBIN /usr/local/bin /bin /sbin /usr/bin /usr/sbin $PATH
# TODO: `pip install cppman ; cppman -c` to get manual for cpp
set -gx MANPATH $NPMS/share/man ~/.local/share/man $MANPATH
# TODO: slow startup, especially when you try to open vim+fish-script
# caused by `system` line in vim-fish/ftplugin/fish.vim
function startup -d "execute it manually only inside fsr fucntion since it is slow"
    # function startup -d "execute it only when FISHRC changes, it is slow"
    # Use different PATH/MANPATH for different distro since anaconda may affect system tools
    # for Windows and Linux compatible
    # Use different PATH/MANPATH for different distro since anaconda may affect system tools
    # for Windows and Linux compatible, check the "manjaro" part in .bash_aliases since that part slows down fish
    if command -sq uname
        if test (uname) = Linux
            if command -sq lsb_release
                if not test (lsb_release -i | rg -i -e 'manjaro|arch|opensuse') # not manjaro/arch/opensuse
                    set -gx PATH $HOME/anaconda3/bin $PATH
                    set -gx MANPATH $HOME/anaconda3/share/man $MANPATH
                    source $HOME/anaconda3/etc/fish/conf.d/conda.fish >/dev/null 2>/dev/null
                end
            end
        else
            # Windows
            set -gx PATH /mingw64/bin /c/Program\ Files/CMake/bin $PATH
        end
    end

    if test $DISPLAY
        # change keyboard auto repeat, this improves keyboard experience, such as the scroll in Emacs
        # Check default value and result using `xset -q`
        # 200=auto repeat delay, given in milliseconds
        # 50=repeat rate, is the number of repeats per second
        # or uncomment the following part and use System Preference
        if command -sq uname; and test (uname) = Linux
            xset r rate 200 100
        end

        # fix the Display :0 can't be opened problem
        if xhost >/dev/null 2>/dev/null
            if not xhost | rg (whoami) >/dev/null 2>/dev/null
                xhost +si:localuser:(whoami) >/dev/null 2>/dev/null
            end
        end
    end
end

set -gx FISHRC (readlink -f ~/.config/fish/config.fish)
test -f ~/.spacemacs.d/init.el; and set -gx EMACS_EL (readlink -f ~/.spacemacs.d/init.el); or set -gx EMACS_EL ~/.spacemacs
test -f ~/.config/nvim/README.md; and set -gx VIMRC (readlink -f ~/.SpaceVim.d/autoload/myspacevim.vim); or set -gx VIMRC (readlink -f ~/.spacevim)
# Please put the following lines into ~/.bashrc, putting them in config.fish won't work
# This fixes a lot problems of displaying unicodes
# https://github.com/syl20bnr/spacemacs/issues/12257
# export LC_ALL=en_US.UTF-8
# export LANG=en_US.UTF-8
# export LANGUAGE=en_US.UTF-8

# show key code and key name using xev used for other programs such as sxhkd
abbr key "xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf \"%-3s %s\n\", \$5, \$8 }'"

bind \cd delete-or-ranger # check the BUG part in the function
bind \cq 'tig status'
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

function auto-source --on-event fish_prompt -d 'auto source config.fish if gets modified!'
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
    if test $MEASURE_TIME = 0
        set -gx MEASURE_TIME 1
    else
        set -gx MEASURE_TIME 0
    end
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
    source $FISHRC # fsr
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
    if set -q $argv[1] # no arguments
        if set -q TMUX_PANE # check if running inside a tmux session
            echo Inside a tmux session!
        end
        read -n 1 -l -p 'echo "Kill all sessions? [y/N]"' answer
        if test "$answer" = y -o "$answer" = " "
            tmux kill-server # kill all sessions
        end
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

# or just use 'M-c r', it is defiend in ~/.tmux.conf
abbr tsr 'tmux source-file ~/.tmux.conf; echo ~/.tmux.conf reloaded!'
# this line will make the indentation of lines below it wrong, TODO: weird
# abbr tt 'tmux switch-client -t'
function twp -d 'tmux swap-pane to current pane to the target pane'
    # tmux display-panes "'%%'"
    # read -n 1 -p 'echo "Target pane number? "' -l num
    tmux swap-pane -s $argv
end

alias check 'checkpatch.pl --ignore SPDX_LICENSE_TAG,CONST_STRUCT,AVOID_EXTERNS,NEW_TYPEDEFS --no-tree -f'

function tag -d 'clean and create(with any arg) tags files for non-linux-kernel projects'
    # delete existed tags files
    rm -rf GPATH GTAGS GSYMS GRTAGS
    rm -rf cscope.files cscope.in.out cscope.out cscope.po.out
    rm -rf include_sys
    echo Old files deleted!!

    if not set -q $argv # given any argv
        # gtags > GPATH, GTAGS, GSYMS, GRTAGS
        ln -nsv /usr/include include_sys
        gtags -v
        echo gtags done!!

        # cscope > cscope.files, cscope.in.out cscope.out, cscope.po.out
        find . -name "*.[ch]" -print >cscope.files
        find /usr/include/* -name "*.[ch]" >>cscope.files
        cscope -b -R -q
        echo cscope done!!
    end
end

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

abbr rgr ranger
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
function lls -d 'ls functions with options'
    set -l options a s r e l A
    argparse -n lls $options -- $argv
    or return

    # no dir is given, assign it to .
    # the single quote in `'$argv'` is for directories with space like `~/VirtualBox VMs/`
    set -q $argv[1]; and set ARGV .; or set ARGV '$argv'
    # using -A to not show hidden files/dirs
    ! set -q _flag_A; and set OPT -A --color=yes $ARGV; or set OPT --color=yes

    if set -q _flag_l
        set OPT $OPT -lh
        set PIP "| nl -v 0 | sort -nr"
    else
        set PIP "| nl -v 1 | sort -nr"
    end
    # reverse order(-r) or not
    set -q _flag_r; and set OPT $OPT -r
    # list and sort by extension, and directories first
    set -q _flag_e; and eval ls $OPT -X --group-directories-first $ARGV && return
    # list all(-a) or not
    set -q _flag_a; or set -a PIP "| tail -20"
    # sort by size(-s) or sort by last modification time
    set -q _flag_s; and set OPT $OPT --sort=size; or set OPT $OPT --sort=time --time=ctime

    eval ls $OPT $PIP
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
    if set -q $argv
        eval $PSS | fzf --preview-window hidden
    else
        eval $PSS | rg -i $argv[1] | nl
        if not set -q $argv[2]; and test (eval $PSS | rg -i $argv[1] | nl | wc -l) = 1
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
    if set -q $argv
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
            if test "$arg" = "" -o "$arg" = y -o "$arg" = " "
                sudo kill -9 $pid
            end
        end
    else
        while test 1
            psss $argv[1]
            if test (psss $argv[1] | wc -l) = 0
                return
            end
            read -p 'echo "Kill all of them or specific PID? [a/y/N/index/pid/m_ouse]: "' -l arg2
            if test $arg2 # it is not Enter directly
                if not string match -q -r '^\d+$' $arg2 # if it is not integer
                    if test "$arg2" = y -o "$arg2" = a -o "$arg2" = " "
                        set -l pids (psss $argv[1] | awk '{print $3}')
                        for i in $pids
                            if not kill -9 $i # failed to kill, $status != 0
                                psss $i | rg $argv[1]
                                read -n 1 -p 'echo "Use sudo to kill it? [Y/n]: "' -l arg3
                                if test "$arg3" = "" -o "$arg3" = y -o "$arg3" = " "
                                    sudo kill -9 $i
                                end
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
                        if test (psss $pid_m | rg -i emacs)
                            kill -SIGUSR2 $pid_m
                        else
                            kill -9 $pid_m
                        end
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
                if contains -- $v $newvar
                    set count (math $count+1)
                else
                    set newvar $newvar $v
                end
            end
            set $var $newvar
            test $count -gt 0
            echo "After:"
            echo $$var | tr " " "\n" | nl
            echo
        end
    else if set -q _flag_p
        echo $PATH | tr " " "\n" | nl
    else if not set -q $argv # given any argv
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
    if set -q $argv; and test "$lastcommand" != cll; and test "$lastcommand" != x
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
            if set -q $def_file # def_file is not set
                echo "NOTE: definition file is not found!"
                return
            end

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
            if not test "$num_line" # empty
                return
            else
                set def_file $FISHRC
            end
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
            if test "$answer" = y -o "$answer" = " "
                $EDITOR $file_path
            end
        end
    end
end

zoxide init fish | source
alias zz zi
# zb go back to the history of current window/tab/pane
function zb -d 'zb go back to the history of current window/tab/pane'
    set dir (string collect $dirprev | fzf --tac)
    if test $dir
        z $dir
    end
end
function zzz
    if set -q $argv
        ranger
    else
        if test -d $argv
            z $argv; and ranger
        else
            zz $argv; and ranger
        end
    end
end
set -gx _ZO_FZF_OPTS "-1 -0 --reverse --print0"
# -m to mult-select using Tab/S-Tab
set -gx FZF_DEFAULT_OPTS "-e -m -0 --reverse --preview 'fish -c \"fzf_previewer {}\"' --preview-window=bottom:wrap"
set -gx FZF_TMUX_HEIGHT 100%

# C-o -- find file in ~/, C-r -- history, C-w -- cd dir
# C-s -- open with EDITOR, M-o -- open with open
source $HOME/.config/fish/functions/fzf.fish

# based on '__fzf_complete_preview' function and '~/.config/ranger/scope.sh' file
function fzf_previewer -d 'generate preview for completion widget.
    argv[1] is the currently selected candidate in fzf
    argv[2] is a string containing the rest of the output produced by `complete -Ccmd`
    '

    if test "$argv[2]" = "Redefine variable"
        # show environment variables current value
        set -l evar (echo $argv[1] | cut -d= -f1)
        echo $argv[1]$$evar
    else
        echo $argv[1]
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
            echo $path
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

    if set -q $argv[2] # no argv[2]
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
    set -q $argv[1]; and set ARGV .; or set ARGV $argv

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

# NOTE: you need to mask updatedb.service and delete /var/lib/mlocate/mlocate.db file first
function loo -d 'locate functions, -u(update db), -a(under /), -v(video), -m(audio), -d(dir), -f(file), -o(open), -x(copy), -r(remove), -e(open it with editor), -w(wholename)'
    set -l options u a v m d f o x r e w p
    argparse -n loo $options -- $argv
    or return

    # list and open only pdf files using rofi
    if set -q _flag_p
        fd --type f -e pdf . $HOME | rofi -keep-right -dmenu -i -p FILES -multi-select | xargs -I {} xdg-open {}
        return
    end

    if set -q _flag_a
        set DB ~/.cache/mlocate.db
        set UPDATEDB_CMD "updatedb --require-visibility 0 -o $DB"
    else
        set DB ~/.cache/mlocate-home.db
        set UPDATEDB_CMD "updatedb --require-visibility 0 -U $HOME -o $DB"
    end

    set UPDATEDB 0
    if not test -f $DB; or set -q _flag_u
        set UPDATEDB 1
    end

    test $UPDATEDB = 1; and eval $UPDATEDB_CMD

    if set -q _flag_u; and set -q $argv
        eval $UPDATEDB_CMD
        return
    end

    if set -q _flag_v # search all video files
        if set -q $argv # no given argv, list all videos
            # get size of all videos, using `xargs -d '\n' dua -f binary` at the end
            set LOCATE 'locate -P -e -i -d $DB "*" | \
                rg -ie "\.mp4\$|\.mkv\$|\.avi\$|\.webm\$|\.mov\$|\.rmvb\$" | rg -v steamapp'
        else
            # NOTE -b option before argv, -b means only search file name,
            # without using -b, it show argv in the whole path, takes more time
            set LOCATE 'locate -P -e -i -d $DB -b $argv | \
                rg -ie "\.mp4\$|\.mkv\$|\.avi\$|\.webm\$|\.mov\$|\.rmvb\$" | rg -v steamapp'
        end
    else if set -q _flag_m # serach all audio files
        set LOCATE 'locate -P -e -i -d $DB $argv | \
            rg -ie "\.mp3\$|\.flac\$|\.ape\$|\.wav\$|\.w4a\$|\.dsf\$|\.dff\$"'
    else if set -q _flag_d
        set LOCATE 'locate -P -e -i -d $DB --null -b $argv | \
            xargs -r0 sh -c \'for i do [ -d "$i" ] && printf "%s\n" "$i"; done\' sh {} + '
    else if set -q _flag_f
        set LOCATE 'locate -P -e -i -d $DB --null -b $argv | \
            xargs -r0 sh -c \'for i do [ -f "$i" ] && printf "%s\n" "$i"; done\' sh {} + '
    else if set -q _flag_w
        set LOCATE "locate -P -e -i -d $DB -b '\\$argv'"
    else # search file/dir
        if set -q $argv
            set LOCATE 'locate -P -e -i -d $DB "*"'
        else
            set LOCATE 'locate -P -e -i -d $DB $argv'
        end
    end

    # if not found at the first time, maybe the db is not updated, update the db once
    if test (eval $LOCATE | wc -l) = 0
        eval $UPDATEDB_CMD
    end

    if set -q _flag_o # open it using  fzf
        # NOTE: the -0 + --print0 in fzf to be able to work with file/dir with spaces
        # NOTE: DO NOT add --print0 it into FZF_DEFAULT_OPTS
        # -r in xargs is --no-run-if-empty
        eval $LOCATE | fzf -1 --print0 | xargs -0 -r xdg-open
    else if set -q _flag_x # copy the result using fzf
        eval $LOCATE | fzf -1 --print0 | xc && xc -o
    else if set -q _flag_r # remove it using fzf
        eval $LOCATE | fzf --print0 | xargs -0 -r rm -rfv
    else if set -q _flag_e # open it with editor
        eval $LOCATE | fzf --print0 | xargs -0 -r vim --
    else
        if set -q _flag_v
            # NOTE :the xargs `-d '\n'` part is for dealing space in file name
            if set -q $argv
                eval $LOCATE | xargs -r -d '\n' dua -f binary

            else
                eval $LOCATE | rg -i $argv | xargs -r -d '\n' dua -f binary
            end
        else
            if set -q $argv
                eval $LOCATE | fzf --print0
            else
                eval $LOCATE | rg -i $argv
            end
        end
    end
end

# df+du+gdu/dua
function dfs -d 'df(-l, -L for full list), gua(-i), dua(-I), du(by default), cache/config dir of Firefox/Chrome/Vivaldi/paru/pacman'
    set -l options i I l L c t m
    argparse -n dfs $options -- $argv
    or return

    if set -q _flag_i
        gdu $argv
    else if set -q _flag_I
        dua -f binary i $argv/* # NOTE: even if argv is empty, this works too
    else if set -q _flag_l
        df -Th | rg -v -e "rg|tmpfs|boot|var|snap|opt|tmp|srv|usr|user"
    else if set -q _flag_L
        df -Th
    else if set -q _flag_t
        # if /tmp is out of space, temporally resize /tmp, argv is size like 20G
        sudo mount -o remount,size=$argv,noatime /tmp
    else if set -q _flag_m
        # if "/tmp/.mount_xxx Transport endpoint is not connected", argv is /tmp/.mount_xxx
        fusermount -zu $argv && rm -rfv $argv
    else if set -q _flag_c
        set dirs ~/.cache/google-chrome ~/.config/google-chrome \
            ~/.cache/vivaldi ~/.config/vivaldi \
            ~/.cache/mozilla ~/.mozilla \
            ~/.cache/paru ~/.cache/calibre \
            ~/.local/share/Trash \
            /var/cache/pacman/pkg /tmp
        set dirs_e
        for i in $dirs
            test -d $i; and set dirs_e $dirs_e $i
        end
        dua -f binary a --no-sort $dirs_e
    else
        if test (count $argv) -gt 0 # argv contains /* at the end of path or multiple argv
            dua -f binary $argv
        else
            dua -f binary .
        end
    end
end

function watch -d 'wrap default watch to support aliases and functions'
    while test 1
        date
        eval $argv
        sleep 1
        echo
    end
end
# stop less save search history into ~/.lesshst
# or LESSHISTFILE=-
# set -gx LESSHISTFILE /dev/null $LESSHISTFILE
function m
    # check if argv[1] is a number
    # `m 100 filename` (not +100)
    # BUG: after viewing the right line, any navigation will make point back to the beginning of the file
    if echo $argv[1] | awk '$0 != $0 + 0 { exit 1 }'
        less -RM -s +G$argv[1]g $argv[2]
    else
        less -RM -s +Gg $argv
    end
end
#more
abbr me 'm $EMACS_EL'
abbr mh 'm /etc/hosts'
abbr m2 'm ~/Recentchange/TODO'
abbr mf 'm $FISHRC'
#
alias less 'less -iXFR -x4 -M' # -x4 to set the tabwidth to 4 instead default 8
abbr lesst 'less ~/.tmux.conf'
abbr lessf 'less $FISHRC'
abbr lesse 'less $EMACS_EL'
abbr lessv 'less $VIMRC'
abbr lessem 'less $LBIN/emm'
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
set -gx MANPAGER 'vim +Man! --cmd "let g:spacevim_enable_startify = 0" -c "set signcolumn=no"'
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
function tree
    if test -f /usr/bin/tree
        command tree -Cashf $argv
    else
        find $argv | sed -e "s/[^-][^\/]*\//  |/g" -e "s/|\([^ ]\)/|-\1/"
        echo -e "\n...tree is not installed, use find instead..."
    end
end

function tars -d 'tar extract(x)/list(l, by default)/create(c, add extra arg to exclude .git dir), fastest(C, add extra arg to exclude .git), -o(open it using gui client)'
    set -l options x l c C o X
    argparse -n tars $options -- $argv
    or return

    # remove the end slash in argv[1] if it is a directory
    test -d $argv[1]; and set ARGV (echo $argv[1] | sed 's:/*$::'); or set ARGV $argv

    set -l EXT (string lower (echo $ARGV | sed 's/^.*\.//'))
    if test "$EXT" = zip -o "$EXT" = rar # zip or rar
        # using unar -- https://unarchiver.c3.cx/unarchiver is available
        # if the code is not working, try GBK or GB18030
        # unzip zip if it is archived in Windows and messed up characters with normal unzip
        # `unzip -O CP936`
        if set -q _flag_l # list
            if command -sq lsar
                lsar $ARGV
            else
                unzip -l $ARGV
            end
        else if set -q _flag_c # create zip
            zip -r $ARGV.zip $ARGV
        else if set -q _flag_C # list Chinese characters
            zips.py -l $ARGV
        else if set -q _flag_x
            if command -sq unar
                unar $ARGV
            else
                unzip $ARGV
            end
        else if set -q _flag_X # extract Chinese characters
            zips.py -x $ARGV
        else if not set -q _flag_o
            unzip -l $ARGV # -l
        end
    else # j for .bz2, z for .gz, J for xz, a for auto determine
        if set -q _flag_x # extract
            # extract into dir based on the tar file
            tar xvfa $argv --one-top-level
        else if set -q _flag_l # list contents
            tar tvfa $argv
        else if set -q _flag_c # create archive, smaller size, extremely slow for big dir
            if test (count $argv) = 1
                tar cvfa $ARGV.tar.xz $ARGV
            else
                tar cvfa $ARGV.tar.xz $ARGV --exclude-vcs
                echo -e "\nUse `tars -c $ARGV g` to include .git directory!"
            end
        else if set -q _flag_C # create archive, faster speed
            if test (count $argv) = 1
                tar cvf - $ARGV | zstd -c -T0 --fast >$ARGV.tar.zst
            else
                tar cvf - $ARGV --exclude-vcs | zstd -c -T0 --fast >$ARGV.tar.zst
                echo -e "\nUse `tars -C $ARGV g` to include .git directory!"
            end
        else
            tar tvfa $argv
        end
    end

    if set -q _flag_o # open it using file-roller
        if command -sq xarchiver
            xarchiver $ARGV
        else if command -sq file-roller
            file-roller $ARGV
        end
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

# TODO: archlinuxcn repo
# append the follwing lines into /etc/pacman.conf and install "archlinuxcn-keyring"
# [archlinuxcn]
# SigLevel = Optional TrustedOnly
# Server = https://mirrors.sjtug.sjtu.edu.cn/archlinux-cn/$arch
# Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
# Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch
#
function pacs -d 'pacman/paru operations'
    set -l options i u y r d l c g m f s L n a h k
    argparse -n pacs $options -- $argv
    or return

    # NOTE: the order of options and sub-options, sub-option in another option may affect
    # the other option, it may cause wrong execution order if you provide option/sub-option
    if set -q _flag_h
        echo "      --> update the system"
        echo "      argv --> search argv"
        echo "      -m --> get mirror from China by default"
        echo "         + argv --> get mirror from argv country"
        echo "         + -f --> fastest top 3 mirrors"
        echo "           + argv --> fastest top argv mirrors"
        echo "         + -s --> get status of local mirrors"
        echo "         + -i --> interactively choose mirror"
        echo "         + -r --> reflector choose mirror(ArchLinux)"
        echo "         + -l --> list local mirrors"
        echo "      -i --> install(need argv)"
        echo "         + -u --> update the system and install the argv"
        echo "         + -y --> install the argv without confirm"
        echo "         + -r --> reinsall argv"
        echo "         + -d --> download argv without installing it"
        echo "         + -l --> install the local .pkg.tar.xz/link-file argv"
        echo "      -c --> clean/check"
        echo "         + no argv --> clean packages in /var/cache/pacman/pkg"
        echo "         + argv --> check if argv is owned by a pacakge, otherwise delete it"
        echo "      -u --> update, force refresh database first"
        echo "         + -d --> downgrade update"
        echo "      -d --> delete/uninstall(need argv)"
        echo "         + -r --> delete/uninstall dependencies as well"
        echo "      -g --> list all local and remote groups"
        echo "         + argv --> list all packages in argv group"
        echo "         + -l --> list only the local groups and packages in the groups"
        echo "           + argv --> list only the local packages in argv group"
        echo "      -s --> show info(need argv)"
        echo "         + -l --> get source link and send it to clipper"
        echo "           + -a --> get source link info and send it to clipper"
        echo "         + -L --> list conetnet of argv package"
        echo "      -l --> list local installed packages(name+description)"
        echo "         + argv --> list installed packages containing argv keyword in name or description"
        echo "         + -n --> list installed packaegs, names only"
        echo "           + argv --> list installed packages containing argv keyword in name"
        echo "      -L --> list content of a argv pacakge, the same as -s -L"
        echo "      -n --> search argv in only packages name part"
        echo "      -a --> search all using paru, slow since inlcuding AUR"
        echo "      -k --> check for missing files in packages"
        echo "      -h --> usage"
    else if set -q _flag_m # mirror
        if set -q _flag_f # fastest top 3/argv mirrors
            if set -q $argv
                sudo pacman-mirrors -f 3
            else
                sudo pacman-mirrors -f $argv
            end
        else if set -q _flag_s # get status of local mirrors
            pacman-mirrors --status
        else if set -q _flag_i # insteractive choose mirror
            sudo pacman-mirrors -i -d
        else if set -q _flag_r # reflector choose mirror
            set -q $argv; and set ARGV China; or set ARGV $argv
            sudo reflector --country $ARGV --verbose --latest 6 --sort rate --save /etc/pacman.d/mirrorlist
        else if set -q _flag_l # list local mirrors
            cat /etc/pacman.d/mirrorlist
        else # change mirrors
            if ! set -q $argv[1] # given arguments
                sudo pacman-mirrors -c $argv
            else # if no given, get the fastest and synced China mirrors
                sudo pacman-mirrors -c China
            end
        end
    else if set -q _flag_i # install
        # -S to install a package, -Syu pkg to ensure the system is update to date then install the package
        set -q _flag_u; and set OPT $OPT -Syu; or set OPT $OPT -S

        # noconfirm, without asking for y/n
        set -q _flag_y; and set OPT $OPT --noconfirm

        # -r to reinstall, no -r to ignore installed
        set -q _flag_r; and set OPT $OPT; or set OPT $OPT --needed

        # jus download the pacakge without installing it, NOTE: not append OPT
        set -q _flag_d; and set OPT -Sw

        # install package from a local .pkg.tar.xz/link file, NOTE: not append OPT
        set -q _flag_l; and set OPT -U

        eval paru $OPT $argv
    else if set -q _flag_c # clean/check
        if set -q $argv # no given argv
            # use `paru -Sc` to clean interactively
            paru -c # clean unneeded dependencies
            paccache -rvk2 # clean installed packaegs, keep the last two versions
            paccache -rvuk0 # clean uninstalled packages
        else
            # check if package is owned by others, if not, delete it
            # This is used when the following errors occur after executing update command:
            # "error: failed to commit transaction (conflicting files) xxx existed in filesystem"
            # After executing this function with xxx one by one, execute the update command again
            # https://wiki.archlinux.org/index.php/Pacman#.22Failed_to_commit_transaction_.28conflicting_files.29.22_error
            # NOTE: this can be also used to check what package provides the file/command/package
            not pacman -Q -o $argv; and sudo rm -rfv $argv
        end
    else if set -q _flag_u # update/upgrade, NOTE: pacs without anything also update
        if set -q _flag_d
            # allow downgrade, needed when switch to old branch like testing->stable or
            # you seen local xxx is newer than xxx
            paru -Syuu
        else
            # force a full refresh of database and update the sustem
            # must do this after switching branch/mirror
            paru -Syyuu
        end
    else if set -q _flag_d # delete/uninstall
        if set -q _flag_r # delete/uninstall dependencies as well
            paru -Rsc $argv
        else
            paru -Rsun $argv
        end
    else if set -q _flag_g # group
        # all available groups(not all) and their packages: https://archlinux.org/groups/
        # if given argv, list only the target group
        if set -q _flag_l # list only the local groups and packages in the groups
            paru -Qg $argv | sort
        else # list all(local+repo) groups and pacakges in the groups
            paru -Sg $argv | sort
        end
    else if set -q _flag_s # show info
        if set -q _flag_l # get source link and send it to clipper
            if set -q _flag_a # get AUR source link and send it to clipper
                paru -Si $argv | rg "AUR URL" | awk '{print $4}' | xc && xc -o
            else
                if paru -Q $argv >/dev/null 2>/dev/null
                    paru -Qi $argv | rg "^URL" | awk '{print $3}' | xc && xc -o
                else
                    paru -Si $argv | rg "^URL" | awk '{print $3}' | xc && xc -o
                end
            end
            open (xc -o) >/dev/null 2>/dev/null
        else if set -q _flag_L # list content in a pacakge
            pacman -Ql $argv
            or pamac list --files $argv
        else # just show info
            # show both local and remote info
            paru -Qi $argv
            paru -Si $argv
        end
    else if set -q _flag_l # list installed pcakges containing the keyword(including description)
        if set -q _flag_n
            if set -q $argv[1] # if no argu, list all installed packages names
                paru -Qs | rg -i local/
            else
                paru -Qs | rg -i local/ | rg -i $argv
            end

        else
            paru -Qs $argv
        end
    else if set -q _flag_L # list content in a pacakge
        # -L can work with -s or be used alone to list the content
        pacman -Ql $argv
        or pamac list --files $argv
    else if set -q _flag_n # search only keyword in package names
        if set -q _flag_a
            pamac search -a -q $argv | rg -i $argv
        else
            pamac search -r -q $argv | rg -i $argv
            # if failed in repos, search in both repo+aur(slow)
            or pamac search -a -q $argv | rg -i $argv
        end
    else if set -q _flag_a # search all including repo and aur
        paru $argv
    else if set -q _flag_k # check for missing files in packages
        # use this when you see something like "warning: xxx path/to/xxx (No such file or directory)"
        # or "warning: could not get file information for path/to/xxx", especially python pacakges
        paru -Qk | rg warning
    else # just search repo, if not found, search it in aur
        if not set -q $argv # given argv
            # if failed with pacman, using paru directly (paru including aur is slow)
            pacman -Ss $argv; or paru $argv
        else
            # check if there are updates using checkupdates(non-root), if there are, update using paru(need root)
            # paru = pacman/paru -Syu, update, check -u option for more
            checkupdates; and paru; or echo "Already Updated!"
        end
    end
end

# donnot show the other info on startup
abbr gdbi 'gdb -q -x ~/Dotfiles.d/bin/.local/bin/gdbinit'
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
    gdb -q -x ~/Dotfiles.d/bin/.local/bin/gdbinit -ex "dashboard source -output $tty" "$argv"
    tmux kill-pane -t $id
end

# make the make and gcc/g++ color
function gcc-a
    set BIN (echo (string split .c $argv) | awk '{print $1;}')
    /usr/bin/gcc -Wall -W -g -o $BIN $argv 2>&1 | rg --color always -iP "\^|warning:|error:|undefined|"
end
function g++-a
    set BIN (echo (string split .c $argv) | awk '{print $1;}')
    /usr/bin/g++ -Wall -W -g -o $BIN $argv 2>&1 | rg --color always -iP "\^|warning:|error:|undefined|"
end
abbr gcc-w 'gcc -g -Wall -W -Wsign-conversion'
abbr gcca 'gcc -g -pedantic -Wall -W -Wconversion -Wshadow -Wcast-qual -Wwrite-strings -Wmissing-prototypes -Wno-sign-compare -Wno-unused-parameter'
# gcc -Wall -W -Wextra -Wconversion -Wshadow -Wcast-qual -Wwrite-strings -Werror

# static code analyzer, another tool is from clang-analyzer which is scan-build
# https://clang-analyzer.llvm.org/scan-build.html
# https://clang.llvm.org/extra/clang-tidy/
# scan-build make or scan-build gcc file.c or clang --analyze file.c or clang-tidy file.c
abbr cppc 'cppcheck --enable=all --inconclusive'

function o -d 'open/xdg-open/xdg-utils, without option(open it), -s(show mimetype), -u(update mimeapps.list), -p(show default program for the file)'
    set -l options s u p c
    argparse -n xdgs $options -- $argv
    or return

    if set -q _flag_s # show the mimetype of the argv file the default program for opening $argv file
        xdg-mime query filetype $argv
    else if set -q _flag_u # update mimeapps.list for this $argv file
        # $argv[1] is the desktop file for the program to open the file
        # $argv[2] is the file to be opened
        xdg-mime default $argv[1] (xdg-mime query filetype $argv[2])
        echo "Need to update mimeapps.list file, check `o -c`"
        # cp ~/.config/mimeapps.list ~/.local/bin/mimeapps.list
    else if set -q _flag_p # show the default program for opening the $argv file
        xdg-mime query default (xdg-mime query filetype $argv)
    else if set -q _flag_c
        if not cmp --silent ~/.local/bin/mimeapps.list ~/.config/mimeapps.list
            diffs ~/.local/bin/mimeapps.list ~/.config/mimeapps.list
            echo
            echo -e "Need to update mimeapps.list like: \n\
            cp ~/.config/mimeapps.list ~/.local/bin/mimeapps.list -rfv"
        end
    else
        set ARGV $argv
        if test -d $ARGV
            ranger $ARGV
        else
            open $ARGV >/dev/null 2>/dev/null
        end
    end
end

function fmts -d "compile_commands.json(-l), clang-format(-f), cmake-format(-m)"
    set -l options f l m
    argparse -n fmts $options -- $argv
    or return

    if set -q _flag_l
        # test -f build/compile_commands.json; and command rm -rf build
        # test -f compile_commands.json; and command rm -rf compile_commands.json

        # generate compile_commands.json file for C/C++ files used by ccls/lsp
        if test -f CMakeLists.txt
            cmake -H. -B build -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
            test -f build/compile_commands.json; and ln -nsfv build/compile_commands.json .
        else if test -f meson.build
            meson build
            test -f build/compile_commands.json; and ln -nsfv build/compile_commands.json .
        else if test -f scripts/gen_compile_commands.py # Linux kernel
            make defconfig
            if test $status = 0; and make
                scripts/gen_compile_commands.py
            end
        else if test -f Makefile -o -f makefile
            make clean
            if command -sq intercept-build # pip install scan-build
                intercept-build make
            else if command -sq compiledb
                # NOTE: don't have to `make clean`, but may be error message
                compiledb -n make
            else if command -sq bear
                bear -- make
            else
                echo "None of scan-build/compiledb/bear is not installed!"
            end
        end
    end

    if set -q _flag_f # .clang-format file for C/Cpp projects used by clang-format
        ln -nsfv ~/Dotfiles.d/spacemacs/.spacemacs.d/lisp/clang-format-c-cpp .clang-format
        or cp -v ~/Dotfiles.d/spacemacs/.spacemacs.d/lisp/clang-format-c-cpp .clang-format
    end

    if set -q _flag_m # .cmake-format.json file for CMakeLists.txt used by cmake-format
        if test -f CMakeLists.txt # TODO: combine the two conditions
            ln -nsfv ~/Dotfiles.d/spacemacs/.spacemacs.d/lisp/cmake-format.json .cmake-format.json
            or cp -v ~/Dotfiles.d/spacemacs/.spacemacs.d/lisp/cmake-format.json .cmake-format.json
        end
    end
end

function ddiso -d 'burn ISO file to drive(such as USB as LIVE USB)'
    if file $argv[1] | rg -i ISO >/dev/null 2>/dev/null
        if echo $argv[2] | rg -i dev >/dev/null 2>/dev/null
            set FILE (readlink -f $argv[1])
            set DEV $argv[2]
            lsblk -l
            echo
            set CMD "sudo dd if=$FILE of=$DEV bs=4M status=progress oflag=sync"
            echo $CMD
            read -n 1 -l -p 'echo "Really run above command? [Y/n]"' answer
            if test "$answer" = y -o "$answer" = "" -o "$answer" = ""
                eval $CMD
            end
        else
            echo $argv[2] is not a /dev/sxx
            return
        end
    else
        echo $argv[1] is not an ISO file!
    end
end

function syss -d 'systemctl related functions'
    set -l options u
    argparse -n syss $options -- $argv
    or return

    # current user or using default sudo
    if set -q _flag_u
        set PRI systemctl --user
    else
        set PRI systemctl
    end

    if ! set -q $argv
        systemctl status $argv
        return
    end

    set keys (seq 1 20)
    set values \
        list-unit-files \
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
        "systemd-analyze blame | head -40 && systemd-analyze blame && return" \
        "systemd-analyze blame > ./boottime && \
        systemd-analyze time >> ./boottime && \
        systemd-analyze plot > ./boottime.svg && \
        echo 'file: ./boottime+./boottime.svg' && \
        display ./boottime.svg"

    echo -e "Usage: syss \n \
      Check all the services of the user if no argv, argv for the argv.service \n\n \
     -u --> current user or using default sudo \n \
      1 --> systemctl: list-unit-files, list all services status \n \
      2 -->            enable name.service \n \
      3 -->            disable name.service \n \
      4 -->            reenable name.service \n \
      5 -->            mask name.service \n \
      6 -->            unmask name.service \n \
      7 -->            restart name.service \n \
      8 -->            start name.service \n \
      9 -->            stop name.service \n \
     10 -->            daemon-reload \n \
     11 -->            --failed \n \
     12 --> power: suspend \n \
     13 -->        hibernate \n \
     14 -->        hibernate-sleep \n \
     15 -->        reboot \n \
     16 -->        poweroff/shutdown \n \
     17 --> journalctrl -xe, the log \n \
     18 --> systemd-analyze: for boot time analyze to the output \n \
     19 -->                  to a file \n"

    read -l -p 'echo "Which one? [index/Enter] "' answer
    if contains $answer $keys
        if contains $answer (seq 2 9)
            read -l -p 'echo "service target: [service]: "' ARG
            if test $answer != ""
                eval $PRI $values[$answer] $ARG # argv can be empty
            end
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
    if command -sq ydiff2
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

function vims -d 'switch between vanilla vim(-v) <-> SpaceVim or space-vim(the default)'
    set -l options v
    argparse -n vims $options -- $argv
    or return

    if set -q _flag_v
        # The plugins are still installed inside ~/.vim/autoload based on the vimrc
        set -q $argv; and set ARGV ~/Dotfiles.d/vim/.vimrc; or set ARGV $argv
        bash -c "vim --cmd \"set runtimepath^=$HOME/.vim\" -u $HOME/Dotfiles.d/vim/.vimrc $ARGV"
    else
        if ! test -d ~/.config/nvim # use neovim instead vim, so ignore vim
            if test -d ~/.SpaceVim; or test -d ~/.space-vim
                echo "Neovim structure is broken, please fix if using command like `ln -s ~/.SpaceVim ~/.config/nvim`"
                return -1
            end

            test -d ~/.vim; and cpb -m ~/.vim
            read -n 1 -l -p 'echo "Neither SpaceVim or space-vim is installed! Which one do you want to install? (SpaceVim/space-vim[1]: "' answer
            if test "$answer" = 1
                curl -fsSL https://git.io/vFUhE | bash
                mkdir ~/.config/nvim
                ln -s ~/.space-vim/init.vim ~/.config/nvim/init.vim
            else
                curl -sLf https://spacevim.org/install.sh | bash
                test (ls -ld ~/.vim | awk '{print $11}') = "$HOME/.SpaceVim"; and rm -rf ~/.vim
                test -d ~/.vim.bak; and cpb -m -b ~/.vim.bak
            end
            pip install neovim clang
        end
        if test (ls -ld ~/.config/nvim | awk '{print $11}') = "$HOME/.SpaceVim"
            read -n 1 -l -p 'echo "Currently running SpaceVim, switch to space-vim? [Y/SPC/n]: "' answer
            if test "$answer" = y -o "$answer" = " "
                if ! test -d ~/.space-vim
                    curl -fsSL https://git.io/vFUhE | bash
                    pip install neovim clang
                end
                if ! test -f ~/.spacevim
                    cd ~/Dotfiles.d/
                    stowsh -v spacevim
                    cd -
                end
                test -d ~/.config/nvim; and rm -rf ~/.config/nvim
                mkdir ~/.config/nvim
                ln -s ~/.space-vim/init.vim ~/.config/nvim/init.vim
                set -gx VIMRC ~/.spacevim
                vim $argv
            else
                echo "Cancel the switch..."
            end
        else if test (ls -ld ~/.config/nvim/init.vim | awk '{print $11}') = "$HOME/.space-vim/init.vim"
            read -n 1 -l -p 'echo "Currently running space-vim, switch to SpaceVim? [Y/SPC/n]: "' answer
            if test "$answer" = y -o "$answer" = " "
                rm -rf ~/.config/nvim
                if ! test -d ~/.SpaceVim.d
                    cd ~/Dotfiles.d/
                    stowsh -v SpaceVim
                end
                if test -d ~/.SpaceVim
                    ln -s ~/.SpaceVim ~/.config/nvim
                else
                    test -d ~/.vim; and cpb -m ~/.vim
                    curl -sLf https://spacevim.org/install.sh | bash
                    test (ls -ld ~/.vim | awk '{print $11}') = "$HOME/.SpaceVim"; and rm -rf ~/.vim
                    test -d ~/.vim.bak; and cpb -m -b ~/.vim.bak
                end
                set -gx VIMRC ~/.SpaceVim.d/autoload/myspacevim.vim
                vim $argv
            else
                echo "Cancel the switch..."
            end
        end
    end
end

# emacs
# -Q = -q --no-site-file --no-splash, which will not load something like emacs-googies
alias emx 'emacs -nw -q --no-splash --eval "(setq find-file-visit-truename t)"'
abbr emq 'emacs -q --no-splash'
abbr emd 'emacs --debug-init'
abbr eml 'emacs -q --no-splash --load' # load specific init.el
abbr emn 'emacs --no-desktop'
abbr eme 'emm $EMACS_EL'
abbr emc 'emm ~/.cgdb/cgdbrc'
abbr emf 'emm $FISHRC'
abbr emt 'emm ~/.tmux.conf'
abbr emv 'emm $VIMRC'
abbr emb 'emm ~/.bashrc'
abbr em2 'emm ~/Recentchange/TODO'
abbr emtime "time emacs --debug-init -eval '(kill-emacs)'" # time emacs startup time

# the gpl.txt can be gpl-2.0.txt or gpl-3.0.txt
abbr lic 'wget -q http://www.gnu.org/licenses/gpl.txt -O LICENSE'

function usertest -d 'add user test temporarily for one day, no passwd, and login into it, delete it(-d), by default add it in smart way'
    set -l options d
    argparse -n usertest $options -- $argv
    or return

    if set -q _flag_d
        sudo userdel -rfRZ test
        ll /home/
        return
    end

    if test -d /home/test # directory exists
        sudo su -s /bin/bash - test
    else
        sudo useradd -m -e (date -d "1 days" +"%Y-%m-%d") test -s /sbin/nologin
        sudo su -s /bin/bash - test
    end
end

# git
abbr lg lazygit
abbr gg tig
abbr ggl 'tig log'
abbr gglp 'tig log -p --'
abbr ggs 'tig status'
abbr ggr 'tig refs'
abbr gits 'git status'
abbr gitl 'tig log'
abbr gitlo 'git log --oneline' # = tig
abbr gitlp 'git log -p --' # [+ file] to how entire all/[file(even renamed)] history
abbr gitls 'git diff --name-only --cached' # list staged files to be commited
abbr gitd 'git diff' # show unstaged modification
abbr ggd 'git diff' # show unstaged modification
abbr ggdd 'git difftool' # show unstaged modification using external tool such as vim
abbr gitdc 'git diff --cached' # show staged but unpushed local modification
abbr gitsh 'git show' # [+ COMMIT] to show the modifications in a last/[specific] commit
abbr gitcm 'git commit -m'
# amend last pushed commit message with gitcma; then `git push --force-with-lease [origin master]` to push it
abbr gitcma 'git commit --amend'
abbr gitcp 'git checkout HEAD^1' # git checkout previous/old commit
abbr gitcn 'git log --reverse --pretty=%H master | rg -A 1 (git rev-parse HEAD) | tail -n1 | xargs git checkout' # git checkout next/new commit
abbr gitt 'git tag --sort=-taggerdate' # sort tag by date, new tag first
abbr gitft 'git ls-files --error-unmatch' # Check if file/dir is git-tracked
abbr gitpu 'git push -v'
abbr gitpun 'git push -v -n' # simulate git push
abbr gitpr 'git pull --rebase=interactive'
abbr gitup 'tig log origin/master..HEAD' # list unpushed commits using tig
set -l SSR socks5://127.0.0.1:1080
abbr gitpx "git config --global http.proxy $SSR; git config --global https.proxy $SSR; git config --global http.https://github.com.proxy $SSR"
abbr gitupx 'git config --global --unset http.proxy; git config --global --unset https.proxy; git config --global --unset http.https://github.com.proxy'
function gitpls -d 'git pull another repo from current dir, ~/.emacs.d(-e), ~/.space-vim(-v), ~/Dotfiles.d(by default), all(-a), or add argument'
    set -l options e v a
    argparse -n gitpls $options -- $argv
    or return

    set dirs ~/.emacs.d ~/.space-vim ~/Dotfiles.d/
    if set -q _flag_a
        for dir in $dirs
            echo "git pull in $dir..."
            git -C $dir pull
            echo -e "===================\n"
        end
    else if set -q _flag_e
        echo "git pull in $dirs[1]..."
        git -C $dirs[1] pull
    else if set -q _flag_s
        echo "git pull in $dirs[2]..."
        git -C $dirs[2] pull
    else
        if set -q $argv
            echo "git pull in $dirs[3]..."
            git -C $dirs[3] pull
        else
            echo "git pull in $argv..."
            git -C $argv pull
        end
    end
end
function gitrm -d 'clean untracked file/dirs(fileA fileB...), all by default)'
    if set -q $argv # no given argv
        git clean -f -d
    else
        set files (string split \n -- $argv)
        for i in $files
            echo "remove untracked file/dir: " $i
            git clean -f -d -- $i
        end
    end
end
abbr gitpl 'git pull'
# https://ask.xiaolee.net/questions/1061863
# fix the merge issue from git pull when pushing to remote
abbr gitplr 'git pull --rebase'
function gitpll -d 'git pull and location it to previous commit id before git pull in git log'
    set COMMIT_ID (git rev-parse HEAD) # short version: `git rev-parse --short HEAD`
    git log -1 # show the info of the current commit before git pull
    git pull
    git log --stat | command less -p$COMMIT_ID
end
function gitcl -d 'git clone and cd into it, full-clone(by default), simple-clone(-s), using proxy(-p)'
    set -l options s p a
    argparse -n gitcl $options -- $argv
    or return

    # https://stackoverflow.com/questions/57335936
    if set -q _flag_s
        set DEPTH --depth=1 --no-single-branch
    else
        set DEPTH
    end
    set -q _flag_p; and set CMD (PXY); or set CMD

    if set -q _flag_a # after shallow pull
        eval $CMD git pull --unshallow
        return
    end
    if set -q $argv # no repo link given
        git pull
    else
        eval $CMD git clone -v $argv $DEPTH
        echo ---------------------------
        if test (count $argv) -eq 2
            set project $argv[2]
        else
            # this works when $argv contains or not contains .git
            set project (basename $argv .git)
        end
        if test -d $project
            cd $project
            echo cd ./$project
        end
    end
end
function gitpa --description 'git pull all in dir using `fing dir`'
    for i in (find $argv[1] -type d -iname .git | sort | xargs realpath)
        cd $i
        cd ../
        pwd
        git pull
        echo -----------------------------
        echo
    end
end
function gitbs -d 'branches, tags and worktrees'
    set -l options c d f l t T w v h
    argparse -n gitbs $options -- $argv
    or return

    if set -q _flag_h
        echo "gitbs [-c/-d/-l/-w/-v/-h]"
        echo "      -c       --> compare two branches or two commit of diff"
        echo "      -c -d    --> compare two branches or two commit of diff, saved in diff file, open the file"
        echo "      -c -v    --> compare two branches or two commit of diff, only list changed files"
        echo "      -c -l    --> compare two branches or two commit of log"
        echo "      -c -l -d --> compare two branches or two commit of log , saved in diff file, open the file"
        echo "      -l       --> list branches using git ls-remote --heads, $argv to search it"
        echo "      -d       --> delete branch"
        echo "      -f       --> switch branch using fzf"
        echo "      -t       --> list all tags, with tag arg, switch to the tag"
        echo "      -T       --> switch tag using fzf"
        echo "      -v       --> show verbose info of branches"
        echo "      no argv  --> list branches"
        echo "      argv     --> if branch $argv exist, switch to it, if not, create and switch to it"
        echo "      -w       --> add worktree if given argv and cd into it, if else list worktree"
        echo "      -w -d    --> delete worktree"
        echo "      -h       --> usage"
        return
    else if set -q _flag_w
        if set -q _flag_d
            git worktree remove $argv
        else
            if set -q $argv[1] # no argument
                git worktree list
            else if test -d $argv
                echo "Directory $argv already exists!"
                return
            else
                git worktree add $argv
                and cd $argv
            end
        end
    else # by default, for branch operations instead of worktree
        if set -q _flag_c
            if set -q _flag_l # git log
                # NOTE: .. and ... are different
                # and are opposite meanings in diff and log
                # https://stackoverflow.com/questions/7251477
                # https://stackoverflow.com/questions/462974
                # $argv[1]/$argv[2] can branch names or commit ids
                if set -q _flag_d
                    echo git log $argv[1]...$argv[2] >branches.log
                    git log $argv[1]...$argv[2] >>branches.log
                    vim branches.log
                else
                    git log $argv[1]...$argv[2]
                end
            else # git diff by default
                if set -q _flag_d
                    echo git diff $argv[1]..$argv[2] >branches.diff
                    git diff $argv[1]..$argv[2] >>branches.diff
                    vim branches.diff
                else
                    if set -q _flag_v
                        git diff --name-status $argv[1]..$argv[2]
                    else
                        git diff $argv[1]..$argv[2]
                    end
                end
            end
        else if set -q _flag_d
            if set -q $argv[1] # no argv
                git branch -a | fzf | xargs git branch -d
            else
                git branch -d $argv
            end
        else if set -q _flag_f # use fzf to switch branch
            # NOTE: if the branch is not in `git branch -a`, try `git ls-remote`
            git fetch
            git branch -a | fzf | awk '{print $1}' | sed 's#^remotes/[^/]*/##' | xargs git checkout
        else if set -q _flag_l
            if set -q $argv
                git ls-remote --heads
            else
                git ls-remote --heads | rg -i $argv
            end
        else if set -q _flag_t # list all tags, with arg, switch the the tag
            # use the following command the fetch all remote tags in there is any
            # git fetch --all --tags
            if set -q $argv
                git tag -ln
                echo -e "------------\nCurrent tag:"
                git describe --tags
            else
                git checkout tags/$argv
            end
        else if set -q _flag_T # switch tag with fzf
            echo tags/(git tag -ln | fzf | awk '{print $1}') | xargs git checkout
        else if set -q _flag_v
            git branch -vv
        else
            if set -q $argv[1] # no argument
                git branch # list local branches
            else # checkout $argv branch if exists, else create it
                git checkout $argv 2>/dev/null
                or git checkout -b $argv
            end
        end
    end
end
function gitco -d 'git checkout -- for multiple files(filA fileB...) at once, all by default'
    if set -q $argv # no given files
        # in case accidentally git checkout all unstaged files
        read -n 1 -l -p 'echo "Checkout all unstaged files? [Y/n]"' answer
        if test "$answer" = y -o "$answer" = " "
            git checkout .
        else
            echo "Cancel and exit!"
            return
        end
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
function sss -d 'count lines of code from a local code dir or a github url'
    set -l options "e=" f F i
    argparse -n sss $options -- $argv
    or return

    if set -q _flag_i
        onefetch
        return
    end

    if echo $argv | rg "https://github.com" >/dev/null 2>/dev/null
        # or use website directly: https://codetabs.com/count-loc/count-loc-online.html
        set -l username_repo (echo $argv | cut -c20-)
        curl "https://api.codetabs.com/v1/loc/?github=$username_repo" | jq -r '(["Files", "Lines", "Blanks", "Comments", "LinesOfCode", "Language"] | (., map(length*"-"))), (.[] | [.files, .lines, .blanks, .comments, .linesOfCode, .language]) | @tsv' | column -t
        return
    end

    set OPT -c --no-cocomo

    # using -f to sort by default(file count), otherwise sort by code lines
    set -q _flag_f; or set OPT $OPT -s code
    set -q _flag_F; and set OPT $OPT --by-file
    # exclude dirs $_flag_e should be dirs separated by ,
    set -q _flag_e; and set OPT $OPT --exclude-dir $_flag_e

    eval scc $OPT $argv
end
abbr gitsc sss
function gitsr -d "get the url of a git repo"
    set -q $argv[1]; and set -l ARGV .; or set -l ARGV $argv
    if test -d $ARGV
        cd $ARGV && git config --get remote.origin.url | xc && xc -o
        ! set -q $argv[1]; and cd -
        echo \n---- Path Copied to Clipboard! ----
    else
        echo Error: $ARGV is not valid!
    end
end
function gita -d 'git add for multiple files at once'
    if set -q $argv # no given files
        git add .
    else
        set -l files (echo $argv | tr ',' '\n')
        for i in $files
            echo 'git add for file:' $i
            git add $i
        end
    end
end
function gitfs -d 'git forked repo sync'
    git checkout master
    git remote -v | rg upstream >/dev/null 2>/dev/null
    set -l upstream_status $status
    if test $upstream_status = 1; and set -q $argv[1]
        echo "Remote upstream is not set, unable to sync!"
        return
    else
        if test $upstream_status != 0
            if set -q $arv[1] # given argument
                git remote add upstream $argv
            end
        end
        # the upstream url may be wrong, `git fetch upstream` will prompt for user/psw
        # use `git remote remove upstream` to remove the wrong upstream url
        git fetch upstream
        git rebase upstream/master
    end
end
function gitrh -d 'git reset HEAD for multiple files(file1 file2, all without argv), soft(-s)/hard(-h) reset'
    set -l options s h
    argparse -n gitrh $options -- $argv
    or return

    if set -q _flag_s # undo last unpushed/pushed(unpulled) commit, keeps changes
        git reset --soft HEAD~1
    else if set -q _flag_h # undo last unpushed/pushed(unpulled) commit, delete changes
        git reset --hard HEAD~1
    else
        if set -q $argv # no given files
            # in case accidentally git reset all staged files
            read -n 1 -l -p 'echo "Reset all staged files? [Y/n]"' answer
            if test "$answer" = y -o "$answer" = " "
                git reset
            else
                echo "Cancel and exit!"
                return
            end
        else
            set -l files (echo $argv | tr ',' '\n')
            for i in $files
                echo 'git reset HEAD for file:' $i
                git reset HEAD $i
            end
        end
    end
end

# create container example:
# docker run -it -v ~/Public/tig:/Public/tig -net host --name new_name ubuntu:xenial /bin/bash
function docks -d 'docker commands'
    set -l options s S p r R l L t q
    argparse -n docks $options -- $argv
    or return

    if set -q _flag_s # serach image
        set CMD search
    else if set -q _flag_p # pull image(repo:tag as repo)
        # tag is from `docks -t $repo`
        set CMD pull
    else if set -q _flag_r # remove container(CONTAINER ID as argv)
        set CMD rm
    else if set -q _flag_R # remove image(IMAGE ID as argv)
        set CMD rmi
        # docker rmi $argv
    else if set -q _flag_l # list all created containers and pulled images
        echo "Pulled images:"
        docker image ls

        echo -e "\nCreated containers:"
        docker ps -a
        return
    else if set -q _flag_t # list tags for a docker image(repo as argv)
        # use this for only the top 10 tags:
        # curl https://registry.hub.docker.com/v2/repositories/library/$argv[1]/tags/ | jq '."results"[]["name"]'
        wget -q https://registry.hub.docker.com/v1/repositories/$argv[1]/tags -O - | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n' | awk -F: '{print $3}'
        and echo -e "\nThese are all the tags!\nPlease use `dockp $argv[1]:tag` to pull the image!"
        return
    else if set -q _flag_q # stop a running container
        set ID (docker ps | fzf --preview-window hidden | awk '{print $1}')
        test $ID; and docker container stop $ID # if ID is not empty
        return
    end

    if not set -q $CMD # CMD is set
        if set -q _flag_r
            # ARGV is CONTAINER ID
            set ARGV (docker ps -a | fzf --preview-window hidden | awk '{print $1}')
        else if set -q _flag_R
            # ARGV is IMAGE ID
            set ARGV (docker image ls | fzf --preview-window hidden | awk '{print $3}')
        else
            set ARGV $argv
        end
        eval docker $CMD $ARGV
    else if set -q _flag_S # add a shared folder to existed containerd
        set ID (docker ps -a | fzf --preview-window hidden | awk '{print $1}')
        read -p 'echo "new container name: "' -l new_name
        docker commit $ID $new_name
        read -p 'echo "The share folder(absolute path) in host: "' -l share_src
        read -p 'echo "The share folder(absolute path) in container: "' -l share_dst
        docker run -ti -v $share_src:$share_dst $new_name /bin/bash
    else # no option, no argv, run an existed container
        set ID (docker ps -a | fzf --preview-window hidden | awk '{print $1}')
        not test $ID; and return # ID is empty

        docker inspect --format="{{.State.Running}}" $ID | rg true >/dev/null 2>/dev/null
        if test $status = 0
            # if the ID is already running, exec it,
            # meaning: start another session on the same running container
            echo -e "\nNOTE: the container is already running in another session...\n"
            docker exec -it $ID bash
        else
            docker start -i $ID
        end
    end
end

function PXY
    if test (pgrep -f 'shadowsocks|v2ray' | wc -l) != 0 # ssr/v2ray is running
        echo proxychains4 -q
    end
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
    if test (count $argv) -gt 1
        command wc $argv | sort -n
    else
        command wc $argv
    end
end

abbr ipy ipython # other alternatives are btpython, ptpython, ptipython
abbr pdb pudb3
function pips -d 'pip related functions, default(install), -i(sudo install), -c(check outdated), -r(remove/uninstall), -s(search), -u(update all outdated packages), -U(upgrade specific packages)'
    set -l options i c r s u U
    argparse -n pips $options -- $argv
    or return

    if set -q _flag_c
        echo "Outdated packages:"
        # echo "pip:"
        pip list --outdated
        # echo "sudo pip:"
        # sudo pip list --outdated
    else if set -q _flag_u
        echo "Updating pip packages"
        # when using default pip install is slow, use repo from the following url to install
        # pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -U (pip list --outdated | awk 'NR>2 {print $1}')
        # echo "Updating sudo pip packages"
        pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -U (pip list --outdated | awk 'NR>2 {print $1}')
    else if set -q _flag_r
        pip uninstall $argv
        or sudo pip uninstall $argv
    else if set -q _flag_s
        # pip search $argv
        # if `pip search` fails, then `sudo pip install pip_search` first
        pip_search search $argv
    else if set -q _flag_U
        pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -U $argv
    else if set -q _flag_i
        sudo pip install -i https://pypi.tuna.tsinghua.edu.cn/simple $argv
    else
        pip install -i https://pypi.tuna.tsinghua.edu.cn/simple $argv
    end
end

# install pytest and pytest-pep8 first, to check if the code is following pep8 guidelines
abbr pyp8 'py.test --pep8'
function penv -d 'python3 -m venv in fish'
    set -q $argv; and set ARGV venv; or set ARGV $argv

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
    if not set -q $VIRTUAL_ENV # running in python virtual env
        # TODO: since sth. is wrong with the deactivate function in $argv/bin/activate.fish
        deactivate >/dev/null 2>/dev/null
        source $FISHRC
    else if not set -q $CONDA_DEFAULT_ENV # running in conda virtual env
        cons -x
    else
        exit
    end
end

# abbr rea 'sudo $LBIN/reaver -i mon0 -b $argv[1] -vv'
# function rea
# sudo $LBIN/reaver -i mon0 -b $argv
# end

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
abbr sky 'curl wttr.in'
abbr wt 'bash -c \'rm -rf /tmp/Baidu* 2>/dev/null\'; wget -c -P /tmp/ https://speedxbu.baidu.com/shurufa/ime/setup/BaiduWubiSetup_1.2.0.67.exe'
abbr wtt 'bash -c \'rm -rf /tmp/Baidu* 2>/dev/null\'; wget --connect-timeout=5 -c -P /tmp/ https://speedxbu.baidu.com/shurufa/ime/setup/BaiduPinyinSetup_5.5.5063.0.exe'
function ios -d 'io stat'
    # check the current io speed, using command like
    # `dstat -d -n`
    # Check the health issue of disk using smartmontools
    # `sudo smartctl --all /dev/nvme0n1`
    # `gpustat -cp` to check gpu usage
    if set -q argv[1]
        sudo hdparm -Tt $argv # $argv is device like /dev/sda1
    else
        dstat -d -n -m -s -c --nocolor
    end
end
function pxs -d 'multiple commands using proxychains4'
    set -l options w W c p
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
end

# bc -- calculator
function bc --description 'calculate in command line using bc non-interactive mode if needed, even convert binary/octual/hex'
    if test (count $argv) -eq 0
        /usr/bin/bc -ql
    else
        # TODO: fish won't recognize command like `bc 2*3`, you have to quote it or use `bc 2\*3`
        for i in $argv
            echo $i:
            echo -ne "\t"
            echo -e $i | /usr/bin/bc -l
        end
    end
end
# more examples using bc
# http://www.basicallytech.com/blog/archive/23/command-line-calculations-using-bc/
#1 convert 255 from base 10 to base 16
# echo 'obase=16; 255' | bc
# use `bcc 'obase=16; 255'` directly
#2 convert hex FF (not ff) from base 16 to binary
# echo 'obase=2; FF' | bc
#3 convert binary 110 from binary to hex
# echo 'ibase=2;obase=A;110' | bc
# not 16 or a but A means hex
#4 convert from hexadecimal to decimal ; 3 and 4 are weird
# echo 'ibase=16;obase=A;FF' | bc
#5 convert hex to octual
# echo 'F' | bc

function catt
    if test (count $argv) -gt 1
        for i in $argv
            echo -e "\\033[0;31m"\<$i\>
            echo -e ------------------------------------------------- "\\033[0;39m"
            /bin/cat $i
            echo
        end
    else
        /bin/cat $argv
    end
end

alias dic 'trans :zh+en -d -show-dictionary Y -v -theme ~/.local/bin/trans-theme-matrix.trans'

# count chars of lines of a file
# awk '{ print length }' | sort -n | uniq -c

function wtp --description 'show the real definition of a type or struct in C code, you can find which file it is defined in around the result'
    gcc -E $LBIN/type.c -I$argv[1] >/tmp/result
    if test (count $argv) -eq 2
        if test (echo $argv[1] | rg struct)
            rg -A $argv[2] "^$argv[1]" /tmp/result
        else
            rg -B $argv[2] $argv[1] /tmp/result
        end
    else
        rg $argv[1] /tmp/result
    end
end

# interactively(choose format and resolution) stream video using mpv+youtube-dl+fzf
# https://github.com/seanbreckenridge/mpvf/
alias mpvs 'proxychains4 -q mpvf'
function yous -d 'youtube-dl functions'
    set -l options l a f p P
    argparse -n yous -N 1 $options -- $argv
    or return

    if set -q _flag_l # list all formats
        eval (PXY) youtube-dl -F \"$argv\"
    else if set -q _flag_f # choose the num from the list
        eval (PXY) youtube-dl -ciw -f $argv[1]+bestaudio \"$argv[2]\"
    else if set -q _flag_a # only download best audio into mp3
        eval (PXY) youtube-dl -ciw --extract-audio --audio-format mp3 --audio-quality 0 \"$argv\"
    else if set -q _flag_p # download playlist
        eval (PXY) youtube-dl -ciw --download-archive downloaded.txt --no-overwrites -ict --yes-playlist --socket-timeout 5 \"$argv\"
    else if set -q _flag_P # download playlist into audio
        eval (PXY) youtube-dl -ciw --download-archive downloaded.txt --no-overwrites -ict --yes-playlist --extract-audio --audio-format mp3 --audio-quality 0 --socket-timeout 5 \"$argv\"
    else # download video
        eval (PXY) youtube-dl -ciw \"$argv\"
    end
end

function rgs -d 'rg sth in -e(init.el)/-E(errno)/-f(config.fish)/-t(.tmux.conf)/-v(vimrc), or use -F(fzf) to open the file, -g(git repo), -w(whole word), -V(exclude pattern), -l(list files), -s(sort), -n(no ignore), -S(smart case, otherwise ignore case), -2(todo.org)'
    # NOTE -V require an argument, so put "V=" line for argparse
    set -l options e E f t v F g n w 'V=' l s S 2 c
    argparse -n rgs -N 1 $options -- $argv
    or return

    set OPT --hidden -g !.git
    set -q _flag_w; and set OPT $OPT -w
    set -q _flag_l; and set OPT $OPT -l
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
    else if set -q _flag_t
        set FILE ~/.tmux.conf
    else if set -q _flag_v
        set FILE $VIMRC
    else if set -q _flag_g
        git grep "$argv" (git rev-list --all)
    else if set -q _flag_2
        set FILE ~/Dotfiles.d/todo.org
    else # without options
        if set -q $argv[2] # no $argv[2]
            set FILE .
        else
            set FILE $argv[2]
        end
    end

    echo "\"$argv[1]" >>~/.lesshst
    rg $OPT -p $argv[1] $FILE | less -i -RM -FX -s

    if set -q _flag_F # search pattern(s) in dir/file, open if using vim
        read -n 1 -p 'echo "Open it with vim? [Y/n]: "' -l answer
        if test "$answer" = y -o "$answer" = " "
            rg $OPT --color never $argv[1] $FILE -l | fzf --bind 'enter:execute:vim {} < /dev/tty'
        else
            echo "Canceled!"
        end
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
            if test -e $result
                echo $result alread exists.
            else
                eval $CMD $name $result
            end
        else
            set old $name
            if test / = (echo (string sub --start=-1 $name)) # for dir ending with "/"
                set old (echo (string split -r -m1 / $name)[1])
            end
            if test -e $old.bak
                echo $old.bak already exists.
                read -n 1 -l -p 'echo "Remove $old.bak first? [y/N]"' answer
                if test "$answer" = y -o "$answer" = " "
                    rm -rfv $old.bak
                else
                    continue
                end
            end
            eval $CMD $old{,.bak}
        end
    end
end

# upx get smaller size than strip
abbr upxx 'upx --best --lzma'
# cargo
function cars -d "cargo commands, -b(build), -c(clean target), -d(remove/uninstall), -i(install), -r(release build), -S(reduce size)"
    set -l options b c d i r s S
    argparse -n cars $options -- $argv
    or return

    set CMD (PXY) cargo

    if set -q _flag_d
        eval $CMD uninstall $argv
    else if set -q _flag_c
        if test -d ./target
            if set -q _flag_r
                # only remove target/release
                eval $CMD clean --release -v
            else
                # remove the whole target
                eval $CMD clean -v
            end
            echo "target cleaned..."
        end
    else if set -q _flag_n
        eval $CMD new $argv
    else if set -q _flag_R
        if test -d ./target
            eval $CMD run
        end
    else if set -q _flag_s
        eval $CMD search $argv
    else
        if set -q _flag_i; or ! test -f ./Cargo.toml
            # install release version, reduce size by default
            # NOTE: there is --debug(dev) version, huge size difference
            set -l RUSTFLAGS '-C link-arg=-s'; and eval $CMD install $argv
            echo -e "\nuse `upx --best --lzma the-bin` to reduce more binary size, better than strip"
        else if test -f ./Cargo.toml
            if set -q _flag_r # build release if -q is given
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
        if not set -q $CONDA_DEFAULT_ENV; and set -q $argv # running in conda env and no argv, too conditions
            conda list
        else if set -q $CONDA_DEFAULT_ENV; and set -q $argv
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
            if not set -q $argv; and test "$CONDA_DEFAULT_ENV" != "$argv" # given another argv
                conda remove -n $argv --all
            else # no argv or argv=current env
                set argv $CONDA_DEFAULT_ENV
                conda deactivate
                echo "Exit the conda env..."
                conda remove -n $argv --all
            end
        end
    else if set -q _flag_n # new env, at least one argv
        if set -q $argv # no argv
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
        if set -q $argv # no argv
            conda env list
            read -p 'echo "Which conda env switching to: [base?] "' argv
        end
        if conda env list | awk '{ print $1 }' | rg -w $argv[1] >/dev/null 2>/dev/null
            if test "$argv" = "" # just enter when `read`, these three are unnecessary
                set argv base
            end
            conda activate $argv[1] # if $argv[1] is null, it will be base automatically
            echo "Switched to $argv[1] env..."
            # $argv may contain the env name and extra packages
            if test (count $argv) -gt 1
                pip install $argv[2..(count $argv)]
            end
        else
            echo "No such env exists, use `cons -n env_name [pkg_name]` to create new!"
            conda activate base
            echo "Switched to base env..."
            pip install $argv
        end
    end
end
