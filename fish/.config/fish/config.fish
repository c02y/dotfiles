### you can use `fish_config` to config a lot of things in WYSIWYG way in browser

set -gx TERM screen-256color
set -gx GOPATH $GOPATH ~/go
set -gx GOPROXY https://goproxy.cn
# electron/node, for `npm install -g xxx`, default place is /usr
set -gx NPMS $HOME/.npms
set -gx NODE_PATH $NPMS/lib/node_modules

# By default, MANPATH variable is unset, so set MANPATH to the result of `manpath` according to
# /etc/man.config and add the customized man path to MANPATH
if test "$MANPATH" = ""
    set -gx MANPATH (manpath | string split ":")
end

# Use different PATH/MANPATH for different distro since anaconda may affect system tools
if test (lsb_release -i | rg -i -e 'manjaro|opensuse') # not manjaro/opensuse
    # set -gx PATH $HOME/anaconda3/bin ~/.local/share/arm-linux/bin ~/.local/bin ~/.linuxbrew/bin $GOPATH/bin ~/bin $PATH
    #set -gx PATH $HOME/anaconda3/bin $HOME/.local/bin $GOPATH/bin /usr/local/bin /usr/local/liteide/bin /bin /sbin /usr/bin /usr/sbin $PATH
    set -gx PATH  $HOME/.local/bin $GOPATH/bin $NPMS/bin ~/.cargo/bin /usr/local/bin /bin /sbin /usr/bin /usr/sbin $PATH

    # TODO: `pip install cppman ; cppman -c` to get manual for cpp
    set -gx MANPATH $NPMS/share/man $MANPATH
else
    set -gx PATH $HOME/anaconda3/bin $HOME/.local/bin $GOPATH/bin $NPMS/bin /usr/local/bin /bin /sbin /usr/bin /usr/sbin $PATH
    set -gx MANPATH $HOME/anaconda3/share/man $NPMS/share/man $MANPATH
end

set -gx FISHRC (readlink -f ~/.config/fish/config.fish)
set -gx EMACS_EL (readlink -f ~/.spacemacs.d/init.el)
test -f ~/.config/nvim/README.md; and set -gx VIMRC (readlink -f ~/.SpaceVim.d/autoload/myspacevim.vim); or set -gx VIMRC (readlink -f ~/.spacevim)
# Please put the following lines into ~/.bashrc, putting them in config.fish won't work
# This fixes a lot problems of displaying unicodes
# https://github.com/syl20bnr/spacemacs/issues/12257
# export LC_ALL=en_US.UTF-8
# export LANG=en_US.UTF-8
# export LANGUAGE=en_US.UTF-8

# fix the Display :0 can't be opened problem
if test $DISPLAY
    if xhost ^/dev/null >/dev/null
        if not xhost | rg (whoami) ^/dev/null >/dev/null
            xhost +si:localuser:(whoami) ^/dev/null >/dev/null
        end
    end
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

function path_prompt
    # check if tmux is running in current terminal/tty
    if test $TMUX
        return
    else
        set_color -ru
        # User
        set_color $fish_color_user
        echo -n $USER
        # set_color normal

        echo -n '@'

        # Host
        set_color $fish_color_host
        echo -n (hostname -s)
        # set_color normal

        echo -n ':'

        # PWD
        #set_color $fish_color_cwd
        set_color -o yellow
        echo -n (prompt_pwd)
        set_color normal

        echo
    end
end
function fish_prompt --description 'Write out the prompt'
    set -l last_status $status

    path_prompt

    if test $last_status != 0
        set_color $fish_color_error
    end
    # http://unicode-table.com/en/sets/arrows-symbols/
    # http://en.wikipedia.org/wiki/Arrow_(symbol)
    set_color -o yellow
    set_color -u
    echo -n '>>' # '➤➤ '  # ➢ ➣, ↩ ↪ ➥ ➦, ▶ ▷ ◀ ◁, ❥
    #echo -n '➤➤ '  # ➢ ➣, ↩ ↪ ➥ ➦, ▶ ▷ ◀ ◁, ❥
    set_color normal
    measure_time
    echo ' '
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
    echo $FISHRC is reloaded!
    vars -c ^/dev/null >/dev/null
end

# tmux related
abbr tls 'tmux list-panes -s'
function tk -d 'tmux kill-session all(default)/single(id)/multiple(id1 id2)/except(-e)/list(-l) sessions'
    if test (ps -ef | rg -v rg | rg -i tmux | wc -l ) = 0
        echo "No tmux server is running!!!"
        return
    end
    set -l options 'e' 'l'
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
        if test "$answer" = "y" -o "$answer" = " "
            tmux kill-server        # kill all sessions
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

    if not set -q $argv             # given any argv
        # gtags > GPATH, GTAGS, GSYMS, GRTAGS
        ln -s /usr/include include_sys
        gtags -v
        echo gtags done!!

        # cscope > cscope.files, cscope.in.out cscope.out, cscope.po.out
        find . -name "*.[ch]" -print > cscope.files
        find /usr/include/* -name "*.[ch]" >> cscope.files
        cscope -b -R -q
        echo cscope done!!
    end
end

function utf8 -d 'convert encoding(argv[1]) file(argv[2]) to UTF-8 file'
    iconv -f $argv[1] -t UTF-8 $argv[2] > "$argv[2]".tmp
    rm -fv $argv[2]
    mv -v $argv[2]{.tmp,}
end
# TODO: the following part will make fish print "No protocol specified" error line
source $HOME/.config/fish/functions/done.fish
# the following script will make fish v3.0.0 prompt hang
# source $HOME/.config/fish/functions/__async_prompt.fish

# LS_COLORS, color for ls command
# http://linux-sxs.org/housekeeping/lscolors.html
# http://www.bigsoft.co.uk/blog/index.php/2008/04/11/configuring-ls_colors
set -gx LS_COLORS 'ex=01;33:ln=96:*~=90:*.swp=90:*.bak=90:*.o=90:*#=90'

# fix the `^[]0;fish  /home/chz^G` message in shell of Emacs
if test "$TERM" = "dumb"
    function fish_title
    end
end

function delete-or-ranger -d 'modified from delete-or-exit, delete one char if in command, execute ranger instead exiting the current terminal otherwise'
    set -l cmd (commandline)

    switch "$cmd"
        case ''
            ranger

        case '*'
            commandline -f delete-char
    end
end
# all bindings should be put inside the single one fish_user_key_bindings
function fish_user_key_bindings
    # without this line, C-l will not print the path at top of the screen
    #bind \cl 'clear; commandline -f repaint; path_prompt'
    #bind \cl ""
    #bind \cl "tput reset; commandline -f repaint; path_prompt"
    bind \cd delete-or-ranger
    # if Alt-backword doesn't work, use this
    # TODO: delete it if fish-shell itself fix it
    bind \e\b backward-kill-word
    # TODO: delete it if fish-shell itself fix it
    # Ctrl-c/v is bound to fish_clipboard_copy/paste which is not working in non-X
    if not test $DISPLAY
        bind --erase \cx # or bind \cx ""
        bind --erase \cv # or bind \cv ""
    end
    fzf_key_bindings            # C-s for file/dir, C-r for history, Tab for complete
    bind --erase \cb
    bind \cb broot
end
set -gx FZF_TMUX_HEIGHT 100%

abbr pm-sl 'sudo pm-suspend'   # 'Suspend to ram' in GUI buttom, power button to wake up
abbr pm-hb 'sudo pm-hibernate' # not work in old CentOS6

abbr rrr 'ranger'
abbr fpp '~/Public/PathPicker/fpp'
abbr ga 'glances -t 1 --hide-kernel-threads -b --disable-irq --enable-process-extended'
abbr dst 'dstat -d -n'
function ml -d 'mutt/neomutt'
    if command -sq neomutt
        set MUTT neomutt
    else if command -sq mutt
        set MUTT mutt
    else
        echo "mutt/neomutt is not installed!"
        return -1
    end
    eval $PXY $MUTT
end

# make the make and gcc/g++ color
# function make
#     /usr/bin/make -B $argv 2>&1 | rg --color -iP "\^|warning:|error:|undefined|"
# end
# function gcc
#     /usr/bin/gcc $argv 2>&1 | rg --color -iP "\^|warning:|error:|undefined|"
# end
function gcc-a
    set BIN (echo (string split .c $argv) | awk '{print $1;}')
    /usr/bin/gcc -Wall -W -g -o $BIN $argv 2>&1 | rg --color -iP "\^|warning:|error:|undefined|"
end
# function g++
#     /usr/bin/g++ $argv 2>&1 | rg --color -iP "\^|warning:|error:|Undefined|"
# end
#
function g++-a
    set BIN (echo (string split .c $argv) | awk '{print $1;}')
    /usr/bin/g++ -Wall -W -g -o $BIN $argv 2>&1 | rg --color -iP "\^|warning:|error:|undefined|"
end
abbr gcc-w 'gcc -g -Wall -W -Wsign-conversion'
abbr gcca 'gcc -g -pedantic -Wall -W -Wconversion -Wshadow -Wcast-qual -Wwrite-strings -Wmissing-prototypes  -Wno-sign-compare -Wno-unused-parameter'
# gcc -Wall -W -Wextra -Wconversion -Wshadow -Wcast-qual -Wwrite-strings -Werror

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
    set -l options 't' 'T' 's' 'S' 'r'
    argparse -n lls $options -- $argv
    or return

    # no dir is given, assign it to .
    set -q $argv[1]; and set ARGV .; or set ARGV $argv

    if set -q _flag_t           # sort by last modification time, only show tail
        if set -q _flag_r       # reverse
            ls -lhA --color=yes $ARGV --sort=time -r --time=ctime | nl -v 0 | sort -nr | tail -20
        else
            ls -lhA --color=yes $ARGV --sort=time --time=ctime | nl -v 0 | sort -nr | tail -20
        end
    else if set -q _flag_T      # like -t, but show all
        if set -q _flag_r       # reverse
            ls -lhA --color=yes $ARGV --sort=time -r --time=ctime | nl -v 0 | sort -nr
        else
            ls -lhA --color=yes $ARGV --sort=time --time=ctime | nl -v 0 | sort -nr
        end
    else if set -q _flag_s      # sort by size, only show tail
        if set -q _flag_r       # reverse
            ls -lhA --color=yes $ARGV --sort=size -r | nl -v 0 | sort -nr | tail -20
        else
            ls -lhA --color=yes $ARGV --sort=size | nl -v 0 | sort -nr | tail -20
        end
    else if set -q _flag_S      # like -s, but show all
        if set -q _flag_r       # reverse
            ls -lhA --color=yes $ARGV --sort=size -r | nl -v 0 | sort -nr
        else
            ls -lhA --color=yes $ARGV --sort=size | nl -v 0 | sort -nr
        end
    else                        # otherwise without option, working like -t
        if set -q _flag_r       # reverse
            ls -lhA --color=yes $ARGV --sort=time -r --time=ctime | nl -v 0 | sort -nr | tail -20
        else
            ls -lhA --color=yes $ARGV --sort=time --time=ctime | nl -v 0 | sort -nr | tail -20
        end
    end
end
# valgrind
# TODO: pip install colour-valgrind
# abbr va='valgrind -v --track-origins=yes'
abbr va 'colour-valgrind --track-origins=yes --leak-check=full'
# more detail about time
abbr vad 'colour-valgrind --tool=callgrind --dump-instr=yes --simulate-cache=yes --collect-jumps=yes'

abbr kill9 'killall -9'
# If Emacs hangs and won't response to C-g, use this to force it to stop whatever it's doing
# Note that do not use this if you got more than one instances of Emacs running
# Use `pkill -SIGUSR2 PID` to kill the PID, send SIGUSR2 to emacs will turn on `toggle-debug-on-quit`, turn it off once emacs is alive again
abbr kille 'pkill -SIGUSR2 emacs'
# get the pid of a gui program using mouse
abbr pid 'xprop | rg -i pid | rg -Po "[0-9]+"'
function psgs -d 'pgrep process, used in script'
    ps -ef | rg -v rg | rg -i $argv[1] | nl
end
function psg -d 'pgrep process, used in command line'
    ps -ef | rg -v rg | rg -i $argv[1] | nl
    if test (ps -ef | rg -v rg | rg -i $argv[1] | nl | wc -l) = 1
        set pid (pgrep -if $argv[1])
        echo -e "\nPID: " $pid
        if test $DISPLAY
            echo $pid | xc
            echo ---- PID Copied to Clipboard! ----
        end
    end
end
# pkill will not kill processes matching pattern, you have to kill the PID
function pk --description 'kill processes containing a pattern or PID'
    set result (psgs $argv[1] | wc -l)
    if test $result = 0
        echo "No '$argv[1]' process is running!"
    else if test $result = 1
        set -l pid (psgs $argv[1] | awk '{print $3}')
        if not kill -9 $pid # failed to kill, $status != 0
            psgs $pid | rg $argv[1] # list the details of the process need to be sudo kill
            read -n 1 -p 'echo "Use sudo to kill it? [Y/n]: "' -l arg
            if test "$arg" = "" -o "$arg" = "y" -o "$arg" = " "
                sudo kill -9 $pid
            end
        end
    else
        while test 1
            psgs $argv[1]
            if test (psgs $argv[1] | wc -l) = 0
                return
            end
            read -p 'echo "Kill all of them or specific PID? [y/N/index/pid/m_ouse]: "' -l arg2
            if test $arg2       # it is not Enter directly
                if not string match -q -r '^\d+$' $arg2 # if it is not integer
                    if test "$arg2" = "y" -o "$arg2" = " "
                        set -l pids (psgs $argv[1] | awk '{print $3}')
                        for i in $pids
                            if not kill -9 $i # failed to kill, $status != 0
                                psgs $i | rg $argv[1]
                                read -n 1 -p 'echo "Use sudo to kill it? [Y/n]: "' -l arg3
                                if test "$arg3" = "" -o "$arg3" = "y" -o "$arg3" = " "
                                    sudo kill -9 $i
                                end
                            end
                        end
                        return
                    else if test "$arg2" = "m" # Use mouse the click the opened window
                        # This may be used for frozen emacs specifically, -usr2 or -SIGUSR2
                        # will turn on `toggle-debug-on-quit`, turn it off once emacs is alive again
                        # Test on next frozen Emacs
                        # kill -usr2 (xprop | rg -i pid | rg -Po "[0-9]+")
                        # kill -SIGUSR2 (xprop | rg -i pid | rg -Po "[0-9]+")
                        set -l pid_m (xprop | rg -i pid | rg -Po "[0-9]+")
                        echo Pid is: $pid_m
                        if test (psgs $pid_m | rg -i emacs)
                            kill -SIGUSR2 $pid_m
                        else
                            kill -9 $pid_m
                        end
                        return
                    else if test "$arg2" = "n"
                        return
                    else
                        echo Wrong Argument!
                    end
                else  # if it is digital/integer
                    if test $arg2 -lt 20 # index number, means lines of searching result
                        # The "" around $arg2 is in case of situations like 10 in 1002
                        set -l pid_of_index (psgs $argv[1] | awk 'NR == n' n=" $arg2 " | awk '{print $3}')
                        if not test $pid_of_index
                            echo $arg2 is not in the index of the list.
                        else
                            # return
                            if not kill -9 $pid_of_index # kill failed, $status != 0
                                psgs $pid_of_index | rg $argv[1] # list the details of the process need to be sudo kill
                                read -n 1 -p 'echo "Use sudo to kill it? [Y/n]: "' -l arg4
                                if test $arg4 = "" -o "$arg4" = "y" -o "$arg4" = " "
                                    # the first condition is to check Return key
                                    sudo kill -9 $pid_of_index
                                end
                            end
                        end
                    else        # pid
                        # The $arg2 here can be part of the real pid, such as typing only 26 means 126
                        if test (psgs $argv[1] | awk '{print $3}' | rg -i $arg2)
                            set -l pid_part (psgs $argv[1] | awk '{print $3}' | rg -i $arg2)
                            if not kill -9 $pid_part # kill failed, $status != 0
                                psgs $pid_part | rg $argv[1] # list the details of the process need to be sudo kill
                                read -n 1 -p 'echo "Use sudo to kill it? [Y/n]: "' -l arg5
                                if test $arg5 = "" -o "$arg5" = "y" -o "$arg5" = " "
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

function vars -d "list item in var line by line, PATH(by default), -m(MANPATH), -c(clean duplicated var)"
    set -l options 'm' 'c'
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
    else
        echo $PATH | tr " " "\n" | nl
    end
end
alias rm 'rm -vi'
alias cp 'cp -vi'
alias mv 'mv -vi'
abbr rcp 'rsync --stats --info=progress2 -rh -avz'
abbr rmv 'rsync --stats --info=progress2 -rh -avz --remove-source-files' # this will not delte the src dir, only the contents
alias clr 'clear; tmux clear-history'

function abbrc -d 'clean abbrs in `abbr --show` but not in $FISHRC'
    if abbr --show | head -n1 | rg "abbr -a -U" ^/dev/null >/dev/null
        set abbr_show "abbr -a -U --"
    else
        set abbr_show "abbr"
    end

    for abr in (abbr --show)
        set abr_def (echo $abr | sed "s/$abbr_show//g" | awk '{print $1}')
        # echo abr_def: $abr_def
        set def_file $FISHRC
        set num_line (rg -n "^abbr $abr_def " $def_file | cut -d: -f1)
        if not test $num_line # empty
            echo "$abr_def is an abbr in `abbr --show` but not defined in $FISHRC, may be defined temporally or in other file!"
            abbr -e $abr_def
            echo "$abr_def is erased!"
            # return
        end
    end
end

abbr wh 'which'
function fu -d 'fu command and prompt to ask to open it or not'
    # $argv could be builtin keyword, function, alias, file(bin/script) in $PATH, abbr
    # And they all could be defined in script or temporally (could be found in any file)
    set found 0
    # Check `type` output, NOTE: `type` doesn't support abbr
    if type $argv ^/dev/null # omit the result once error(abbr or not-a-thing) returned, $status = 0
        set found 1 # for not-a-thing
        set result (type $argv)
    end

    if abbr --show | head -n1 | rg "abbr -a -U" ^/dev/null >/dev/null
        set abbr_show "abbr -a -U --"
    else
        set abbr_show "abbr"
    end
    # NOTE: $argv may also be defined as an abbr like rm command
    abbr --show | rg "$abbr_show $argv " # Space to avoid the extra abbr starting with $ARGV
    if test $status = 0
        # in case $argv existes in both `type` and `abbr --show`
        # function may be `function func` and `function func -d ...`
        if test $found = 1 -a (echo (rg -w -e "^alias $argv |^function $argv |^function $argv\$" $FISHRC))
            echo "$argv is in both `type` and `abbr --list`, found definition in $FISHRC"
            echo "Please clean the multiple definitions!"
            abbrc
            # return
        else # only exists in `abbr --show`
            set found 1
            set result (abbr --show | rg "$abbr_show $argv ")
        end
    else if test $status != 0 -a $found != 1
        echo "$argv is not a thing!"
        return
    end

    set result_1 (printf '%s\n' $result | head -1)
    set def_file $FISHRC
    if test (echo $result_1 | rg -e "$abbr_show $argv |is a function with definition") # defined in fish script
        if test (echo $result_1 | rg -e "is a function with definition")
            # 1. function or alias -- second line of output of fu ends with "$path @ line $num_line"
            if test (printf '%s\n' $result | sed -n "2p" | rg -e "\# Defined in")
                set -l result_2 (printf '%s\n' $result | sed -n "2p")
                set def_file (echo $result_2 | awk -v x=4 '{print $x}')
            else
                echo "NOTE: Temporally definition from nowhere!"
                return
            end
            if test "$def_file" = "-" # alias, no definition file is printed
                set def_file $FISHRC
            end

            set num_line (rg -n -w -e "^alias $argv |^function $argv |^function $argv\$" $def_file | cut -d: -f1)
            # NOTE: $num_line may contain more than one number, use "$num_line", or test will fail
            if not test "$num_line" # empty
                echo "$argv is an alias/function defined in $def_file!"
                if test $def_file = $FISHRC
                    functions -e $argv
                    echo "$argv is erased!"
                    return
                else
                    set num_line 1
                end
            else if test (echo "$num_line" | rg " ") # $num_line contains more than one value
                echo "$argv has multiple definitions(alias and function) in $FISHRC, please clean them!"
                return
            end
        else # 2. abbr, only handle abbr defined in $FISHRC
            abbrc
            set num_line (rg -n -w -e "^abbr $argv " $def_file | cut -d: -f1)
            if not test "$num_line" # empty
                return
            end
        end

        echo
        read -n 1 -p 'echo "Open the file containing the definition? [y/N]: "' -l answer
        if test "$answer" = "y" -o "$answer" = " "
            $EDITOR $def_file +$num_line
        end
    else if test (echo $result_1 | rg -i "is a builtin")
        # 3. $argv in builtin like if
        return
    else # 4. $argv is a file in $PATH
        set -l file_path (echo $result_1 | awk 'NF>1{print $NF}')
        file $file_path | rg "symbolic link" # print only $argv is symbolic link
        file (readlink -f $file_path) | rg -e "ELF|script|executable" # highlight
        if test (file (readlink -f $file_path) | rg "script") # script can be open
            echo
            read -n 1 -p 'echo "Open the file for editing?[y/N]: "' -l answer
            if test "$answer" = "y" -o "$answer" = " "
                $EDITOR $file_path
            end
        end
    end
end

abbr fzfb "fzf --bind 'enter:execute:vim {} < /dev/tty'"
function fzfp -d 'check if fzf is existed, with any argument, fzf binary file will be upgraded'
    if command -sq fzf; and set -q $argv[1] # fzf is in $PATH, and no any argv is given, two conditions
        # echo "fzf is installed, use any extra to upgrade it!"
        return 0
    else
        # check internet connection
        if not wget -q --spider http://www.baidu.com # failed, $status != 0
            echo "fzf doesn't exist and error occurs when downloading it!"
            return 1
        end
        set tag_name (eval $PXY curl -s "https://api.github.com/repos/junegunn/fzf-bin/releases/latest" | rg "tag_name" | cut -d : -f 2 | awk -F[\"\"] '{print $2}')
        if not test $tag_name
            echo "API rate limit exceeded, please input your password for your username!"
            set tag_name (eval $PXY curl -u c02y -s "https://api.github.com/repos/junegunn/fzf-bin/releases/latest" | rg "tag_name" | cut -d : -f 2 | awk -F[\"\"] '{print $2}')
        end
        set file_name (echo fzf-$tag_name-linux_amd64.tgz)
        set file_link (echo https://github.com/junegunn/fzf-bin/releases/download/$tag_name/$file_name)
        eval $PXY wget $file_link -O /tmp/$file_name
        if test -s /tmp/$file_name
            tar -xvzf /tmp/$file_name -C ~/.local/bin
            echo -e "\n====fzf installed...====\n"
            return 0
        else
            echo "fzf doesn't exist and error occurs when downloading it!"
            return 1
        end
    end
end

set -gx Z_PATH ~/.config/fish/functions
if test -e $Z_PATH/z.lua
    source (lua5.3 $Z_PATH/z.lua --init fish once echo | psub)
    # z.lua using built-in cd which won't affect the cd stack of fish shell, use fish's cd so you can use `cd -`
    set -gx _ZL_CD cd
    set -gx _ZL_INT_SORT 1
    set -gx _ZL_FZF_HEIGHT 0 # 0 means fullscreen
    set -gx FZF_DEFAULT_OPTS '-1 -0 --reverse' # auto select the only match, auto exit if no match
end
function zlp -d 'check exists of z.lua, with any given argument, update z.lua'
    if test -e $Z_PATH/z.lua; and set -q $argv[1] # z.lua file exists and no any argv is given, two conditions
        # echo "z.lua is installed, use any extra to upgrade it!"
        return 0
    else
        eval $PXY curl -L -C - https://raw.githubusercontent.com/skywind3000/z.lua/master/z.lua -o /tmp/z.lua
        if test -s /tmp/z.lua
            mv -f /tmp/z.lua $Z_PATH/z.lua
            echo -e "\n====z.lua installed...====\n"
        else
            echo "Failed to download z.lua!!!"
            return 1
        end
        return 0
    end
end
abbr zb 'z -b' # Bonus: zb .. equals to cd .., zb ... equals to cd ../.. and
# zb .... equals to cd ../../.., and so on. Finally, zb ..20 equals to cd (..)x20.
function zz -d 'z interactive selection mode'
    if not zlp
        echo "Failed to install z.lua!"
        return
    end
    if fzfp # fzf exists, $status = 0
        set z_cmd z -I
    else
        set z_cmd z -i
    end
    if test (count $argv) = 0
        eval $z_cmd .
    else
        eval $z_cmd  $argv
    end
end
function zh -d 'z\'s cd into the cd history'
    if not zlp
        echo "Failed to install z.lua!"
        return
    end
    if fzfp # fzf exists, $status = 0
        set z_cmd z -I -t
    else
        set z_cmd z -i -t
    end
    if test (count $argv) -eq 0
        eval $z_cmd .
    else
        eval $z_cmd $argv
    end
end

# touch temporary files
abbr tout 'touch ab~ .ab~ .\#ab .\#ab\# \#ab\# .ab.swp ab.swp'
# find
# alias find 'find -L' # make find follow symlink dir/file by default
function finds -d 'find a file/folder and view/edit using less/vim/emacs/emx/cd/readlink with fzf, find longest path(-L), find new file(-n, $argv1 is last $argv1 minutes, $argv2 is filename)'
    set -l options 'l' 'v' 'e' 'x' 'c' 'p' 'g' 'd' 'L' 'n'
    argparse -n finds $options -- $argv
    or return

    if not fzfp # fzf doesn't exist, $status != 0
        find $argv[1] -iname "*$argv[2]*"
        return
    end

    if set -q $argv[2]      # no argv[2]
        set ARGV1 .
        set ARGV2 $argv[1]
    else
        set ARGV1 $argv[1]
        set ARGV2 $argv[2]
    end

    if set -q _flag_l           # find a file and view it using less
        if test (find $ARGV1 -iname "*$ARGV2*" | wc -l) = 1
            find $ARGV1 -iname "*$ARGV2*" | xargs less
        else
            # fzf part cannot handle when result is only one file
            find $ARGV1 -iname "*$ARGV2*" | fzf --bind 'enter:execute:command less {} < /dev/tty'
        end
    else if set -q _flag_v      # find a file and view it using vim
        if test (find $ARGV1 -iname "*$ARGV2*" | wc -l) = 1
            find $ARGV1 -iname "*$ARGV2*" | xargs vim
        else
            # fzf part cannot handle when result is only one file
            find $ARGV1 -iname "*$ARGV2*" | fzf --bind 'enter:execute:vim {} < /dev/tty'
        end
    else if set -q _flag_e      # find a file and view it using emm
        emm (find $ARGV1 -iname "*$ARGV2*" | fzf)
    else if set -q _flag_x      # find a file and view it using emx
        emx (find $ARGV1 -iname "*$argv[2]*" | fzf)
    else if set -q _flag_c      # find a folder and try cd into it
        cd (find $ARGV1 -type d -iname "*$ARGV2*" | fzf)
    else if set -q _flag_p      # find a file/folder and copy/echo its path
        if not test $DISPLAY
            readlink -f (find $ARGV1 -iname "*$ARGV2*" | fzf)
        else
            find $ARGV1 -iname "*$ARGV2*" | fzf | xc
        end
    else if set -q _flag_g      # find all the .git directory
        find $ARGV1 -type d -iname .git | sort
    else if set -q _flag_d      # find directory
        find $ARGV1 -type d -iname "*$ARGV2*"
    else if set -q _flag_L  # find the longest path of file/dir
        # ARGV2 is the the type such as d or f
        find $ARGV1 -type $ARGV2 -print | awk '{print length($0), $0}' | sort -n | tail
    else if set -q _flag_n      # finds new files in whole system, $argv1 is the last mins, $argv2 is the file name to search
        sudo find / -type f -mmin -$argv[1] | sudo rg $argv[2]
    else                        # find file/directory
        find $ARGV1 -iname "*$ARGV2*"
    end
end
function fts -d 'find the temporary files such as a~ or #a or .a~, and files for latex, if no argv is passed, use the current dir'
    set -l options 'c' 'C' 'r' 'R' 'l'
    argparse -n fts $options -- $argv
    or return

    # no dir is given, assign it to .
    set -q $argv[1]; and set ARGV .; or set ARGV $argv

    if set -q _flag_c           # one level, not recursive, print
        find $ARGV -maxdepth 1 \( -iname "*~" -o -iname "#?*#" -o -iname ".#?*" -o -iname "*.swp*" \) | xargs -r ls -lhd | nl
    else if set -q _flag_C      # one level, not recursive, remove
        find $ARGV -maxdepth 1 \( -iname "*~" -o -iname "#?*#" -o -iname ".#?*" -o -iname "*.swp*" \) | xargs rm -rfv
    else if set -q _flag_r      # recursive, print
        find $ARGV \( -iname "*~" -o -iname "#?*#" -o -iname ".#?*" -o -iname "*.swp*" \) | xargs -r ls -lhd | nl
    else if set -q _flag_R      # recursive, remove
        find $ARGV \( -iname "*~" -o -iname "#?*#" -o -iname ".#?*" -o -iname "*.swp*" \) | xargs rm -rfv
    else if set -q _flag_l      # remove temporary files for latex
        if not find $ARGV -maxdepth 1 -iname "*.tex" | egrep '.*' # normal find returns 0 no matter what
            echo "$ARGV is not a LaTeX directory!"
            return
        end
        for EXT in ind ilg toc out idx aux fls log fdb_latexmk nav snm
            # ind ilg toc out idx aux fls log fdb_latexmk faq blg bbl brf nlo dvi ps lof pdfsync synctex.gz
            find $ARGV -maxdepth 1 \( -iname "*.$EXT"  -o -iname "auto" \) | xargs -r rm -rv
        end
        fts -C
    end
end
abbr lo 'locate -e'
function lop --description 'locate the full/exact file'
    locate -e -r "/$argv[1]\$"
end

# df+du+ncdu
alias du 'du -h --apparent-size'
function dfs -d 'df(-l), ncdu(-i), du(by default), cache dir of Firefox/Chrome'
    set -l options 'i' 'l' 'c'
    argparse -n dfs $options -- $argv
    or return

    if set -q _flag_i
        if command -sq ncdu
            ncdu --color dark $argv
        else
            echo "ncdu is not installed!"
        end
    else if set -q _flag_l
        df -Th | rg -v -e -- 'rg|tmpfs|boot|var|snap|opt|tmp|srv|usr|user'
    else if set -q _flag_c
        du -cs ~/.mozilla ~/.cache/mozilla ~/.config/google-chrome ~/.cache/google-chrome
    else
        if test (count $argv) -gt 1 # $argv contains /* at the end of path
            du -cs $argv | sort -h
        else
            du -cs $argv
        end
    end
end

abbr watd 'watch -d du --summarize'
function watch -d 'wrap default watch to support aliases and functions'
    while test 1
        date; eval $argv
        sleep 1; echo
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
abbr lessem 'less ~/.local/bin/emm'
# NOTE: there is a package called mdv, don't use it
function mdv -d 'markdown viewer in terminal'
    if command -sq mdcat
        mdcat $argv | less
    else if command -sq pandoc; and command -sq lynx
        pandoc $argv | lynx --stdin
    else
        echo "Please make sure pandoc+lynx or mdcat are installed!"
    end
end

# # color in less a code file
# if command -sq pygmentize # check if command pygmentize exists
#     set -gx LESSOPEN '| pygmentize -g %s'
# else if test -e /usr/bin/src-hilite-lesspipe
#     # if pygmentize not working, use source-highlight instead
#     # if less gets stuck when opening a file, comment out this LESSOPEN line
#     set -gx LESSOPEN '| /usr/bin/src-hilite-lesspipe.sh %s'
# else if test -e /usr/share/source-highlight/src-hilite-lesspipe.sh
#     set -gx LESSOPEN '| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'
# else if test -e $HOME/anaconda3/bin/src-hilite-lesspipe.sh
#     set -gx LESSOPEN '| eval $HOME/anaconda3/bin/src-hilite-lesspipe.sh %s'
# end
# nums are explained at
# http://www.tuxarena.com/2012/04/tutorial-colored-man-pages-how-it-works/
# https://unix.stackexchange.com/questions/108699/documentation-on-less-termcap-variables
set -gx LESS_TERMCAP_me \e'[0m' # turn off all appearance modes (mb, md, so, us)
set -gx LESS_TERMCAP_se \e'[0m' # leave standout mode
set -gx LESS_TERMCAP_ue \e'[0m' # leave underline mode
set -gx LESS_TERMCAP_so \e'[30;44m' # standout-mode – info
set -gx LESS_TERMCAP_mb \e'[01;31m' # enter blinking mode
set -gx LESS_TERMCAP_md \e'[01;38;5;75m' # enter double-bright mode
set -gx LESS_TERMCAP_us \e'[04;38;5;200m' # enter underline mode
#########################################
# Colorcodes:
# Black           0;30     Dark Gray     1;30
# Red         0;31     Light Red     1;31
# Green           0;32     Light Green   1;32
# Brown           0;33     Yellow        1;33
# Blue        0;34     Light Blue    1;34
# Purple      0;35     Light Purple      1;35
# Cyan        0;36     Light Cyan    1;36
# Light Gray  0;37     White         1;37
#########################################

# TODO: pip install cppman; cppman -c # it will take a while
abbr manp 'cppman'
# color in man page
set -gx MANPAGER 'less -s -M +Gg -i'
set -gx PAGER 'less -iXFR -x4 -M'
# color in man page and less
# without this line, the LESS_TERMCAP_xxx won't work in Fedora
set -gx GROFF_NO_SGR yes
# other major details goto the end of the this file

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
        command tree -Cshf $argv
    else
        find $argv
        echo -e "\n...tree is not installed, use find instead..."
    end
end

# j for .bz2, z for .gz, J for xz, a for auto determine
function tars -d 'tar extract(x)/list(l, by default)/create(c, add extra arg to include .git dir), or others using extr(o)'
    set -l options 'x' 'l' 'c' 'o'
    argparse -n tars $options -- $argv
    or return

    if set -q _flag_x           # extract
        tar xvfa $argv
    else if set -q _flag_l      # list contents
        tar tvfa $argv
    else if set -q _flag_c      # create archive
        # remove the end slash in argv
        set ARGV (echo $argv[1] | sed 's:/*$::')
        if test (count $argv) = 1 -a -d $ARGV/.git
            tar cvfa $ARGV.tar.zst --exclude-vcs $ARGV
            echo -e "\nUse `tars -c $ARGV g` to include .git directory!"
        else
            tar cvfa $ARGV.tar.zst $ARGV
        end
    else if set -q _flag_o
        if command -sq extr
            extr $argv
        end
    else
        tar tvfa $argv
    end
end
# using unar -- https://unarchiver.c3.cx/unarchiver is available
# if the code is not working, try GBK or GB18030
# unzip zip if it is archived in Windows and messed up characters with normal unzip
abbr unzipc 'unzip -O CP936'
function zips -d 'zip to list(l, default)/extract(x)/create(c)'
    # NOTE: if unarchiver is installed(lsar+unar), the $argv can be zip/rar/tar.xxx
    set -l options 'l' 'L' 'c' 'x' 'X'
    argparse -n zips $options -- $argv
    or return

    for a in $argv
        if set -q _flag_l           # list
            if command -sq lsar
                lsar $a
            else
                unzip -l $a
            end
        else if set -q _flag_L      # list Chinese characters
            zips.py -l $a
        else if set -q _flag_x
            if command -sq unar
                unar $a
            else
                unzip $a
            end
        else if set -q _flag_X      # extract Chinese characters
            zips.py -x $a
        else if set -q _flag_c
            # remove the end slash in argv
            set ARGV (echo $a | sed 's:/*$::')
            zip -r $ARGV.zip $ARGV
        else
            unzip -l $a
        end
    end
end
function deb -d 'deb package, list(default)/extract(x)'
    set -l options 'x'
    argparse -n deb $options -- $argv
    or return

    if set -q _flag_x           # extract
        set pkgname (basename $argv[1] .deb)
        mkdir -v $pkgname
        if command -sq dpkg # check if dpkg command exists, replace which
            dpkg -x $argv[1] $pkgname
        else
            set dataname (ar t $argv[1] | rg data)
            if not ar p $argv[1] $dataname | tar Jxv -C $pkgname ^/dev/null # failed, $status != 0
                if not ar p $argv[1] $dataname | tar zxv -C $pkgname ^/dev/null # failed, $status != 0
                    rm -rfv $pkgname
                    return
                end
            end
        end
        echo ----in $pkgname ----
    else                        # default, list
        dpkg -c $argv
    end
end

# rpm
function rpms -d 'rpm file, install(i)/extract(x)/list(default)'
    set -l options 'i' 'x'
    argparse -n rpms $options -- $argv
    or return

    if set -q _flag_i           # install
        sudo rpm -Uvh $argv
    else if set -q _flag_x      # extract
        for i in $argv
            echo \<$i\>
            echo -------------------
            rpm2cpio $i | cpio -idmv
        end
    else                        # default list
        for i in $argv
            rpm -qlpv $i
        end
    end
end

# yum for fedora/redhat/centos/...
abbr yum   'sudo yum -C --noplugins' # not update cache
abbr yumi  'sudo yum install'
abbr yumiy 'sudo yum install -y'
abbr yumr  'sudo yum remove'
abbr yumri 'sudo yum reinstall -y'
abbr yumca 'sudo yum clean all -v'
abbr yumu  'sudo yum --exclude=kernel\* upgrade' # this line will be '=kernel*' in bash
abbr yumuk 'sudo yum upgrade kernel\*'
abbr yumue 'sudo yum update --exclude=kernel\*'
abbr yumul 'sudo yum history undo last'
abbr yumhl 'sudo yum history list'
abbr yumun 'sudo yum history undo'
abbr yums  'sudo yum search'
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
abbr appl 'apt list --installed | ag'
abbr applu 'apt list --upgradable'
abbr appd 'apt depends'

# pacman/yay for manjaro/arch/...
abbr paci 'sudo pacman -S --needed'   # install packages directly without updating the system first
abbr pacI 'sudo pacman -Syu --needed' # -S to install a package, -Syu pkg to ensure the system is update to date then install the package
abbr pacii 'sudo pacman -Syu --needed --noconfirm'
abbr pacil 'sudo pacman -U' # install package from a local .pkg.tar.xz/link file
abbr pacs 'pacman -Ss --color=always'  # search for package to install
abbr pacls 'pacman -Qs --color=always' # search for local installed packages
abbr pacr 'yay -Rsun' # remove a package and its unneeded dependencies, and clean configs
abbr pacrr 'yay -Rsc' # using this if pacr doesn't not uninstall a pacakge
abbr pacrc 'yay -Rsu' # like pacr, but don't clean configs
abbr pacrd 'yay -Rscn'          # do not remove dependencies and their configs
abbr pacd 'sudo pacman -Sw'     # download package without installing
abbr pacc 'sudo pacman -Sc --noconfirm' # clean packages cache
abbr pacC 'paccache -rvk2 --noconfirm' # remove old package cache files is to remove all packages except for the latest 2 package versions
abbr pacu 'yay -Syu' # update the database and update the system, pacman only updates from repo, yay updates from both repo and aur
abbr pacuu 'yay -Syyu' # force a full refresh of database and update the system, must do this when switching branches/mirrors
abbr pacud 'yay -Syuu' # like pacu, but allow downgrade, needed when switch to old branch like testing->stable or you seen local xxx is newer than xxx
abbr paco 'pacman -Qdt --color=always' # To list all orphans, installed packages that are not used by anything else and should no longer be needed
abbr pacor 'sudo pacman -Rsun (pacman -Qdtq)' # remove package and its configs in paco
function pacsh -d 'search info about package, first search installed then search in repo'
    pacman -Qi $argv
    or pacman -Si $argv
end
function pacl -d 'list files in a package'
    pacman -Ql $argv
    or pamac list --files $argv
end
function pacch -d 'check if package is owned by others, if not, delete it'
    # This is used when the following errors occur after executing update command:
    # "error: failed to commit transaction (conflicting files)"
    # "xxx existed in filesystem"
    # After executing this function with xxx one by one, execute the update command again
    # https://wiki.archlinux.org/index.php/Pacman#.22Failed_to_commit_transaction_.28conflicting_files.29.22_error
    # NOTE: this can be also used to check what package provides the file/command/package
    for file in $argv
        if not pacman -Q -o $file
            sudo rm -rfv $file
        end
    end
end
function yaysh -d 'search info about package, first search installed then search in repo'
    yay -Qi $argv
    or yay -Si $argv
end
# yay, install it first
abbr yayc 'yay -Yc'
abbr yayu 'yay -Syu'  # yay == yay -Syu
abbr yayr 'yay -Rsun'
# check yay --help for more
# pacui, depending on yay, install it first
abbr pui 'pacui'
abbr puii 'pacui i'
abbr puid 'pacui d'   # downgrade a package
abbr puil 'pacui s'   # list files in a package
abbr puila 'pacui la' # list packages installed from aur
abbr puils 'pacui ls' # list installed packages by size
abbr puir 'pacui r'
# check pacui h/help for more

# donnot show the other info on startup
abbr gdb 'gdb -q'
abbr gdbx 'gdb -q -n'         # with loading any .gdbinit file
abbr gdbd 'sudo gdb -batch -ex "thread apply all bt" -p' # -p $PID to check the deadlock issue, or `sudo strace -s 99 -ffp $PID`
abbr gdbu 'gdbgui --gdb-args="-q -n"'
# debug the core dump binary and file, by default the core dump file is
# located in /var/lib/systemd/coredump (Arch Linux) or in current running dir
# if it is lz4, decompress it, and `gdb ./file core-file`
# Using the following abbr to debug the latest core dump binary
abbr gdbc 'coredumpctl gdb -1'
abbr cclsc 'cmake -H. -BDebug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=YES ; and ln -s Debug/compile_commands.json . ; or cp Debug/compile_commands.json .'
# .clang-format file used by C/Cpp projects by Emacs
abbr cppf 'ln -s ~/Dotfiles.d/spacemacs/.spacemacs.d/lisp/clang-format-c-cpp .clang-format; or cp ~/Dotfiles.d/spacemacs/.spacemacs.d/lisp/clang-format-c-cpp .clang-format'

# systemd-analyze
function sab --description 'systemd-analyze blame->time, with any argv, open the result graphic'
    if set -q $argv             # no given argv
        systemd-analyze blame | head -40
        systemd-analyze time
    else
        # more verbose version:
        systemd-analyze blame > boottime
        systemd-analyze time  >> boottime
        systemd-analyze plot  >> boottime.svg
        # open boottime.svg
        gwenview boottime.svg
    end
end

# cd
function ..; cd ..; end
function ...; cd ../..; end
function ....; cd ../../..; end
function .....; cd ../../../..; end
abbr cdp 'cd ~/Public; and lls'
abbr cdu 'cd /run/media/chz/UDISK/; and lls'

# NOTE: this function is obsolete since using Spacemacs now
function elpac -d 'print old packages in .emacs.d/elpa/, with any command, it will clean old ones'
    set -l elpa_path ~/.emacs.d/elpa
    # ls contains color which will affect the $pkg string, * part means only directories
    for pkg in (command ls $elpa_path)
        if echo $pkg | rg -q '[0-9]' # check if pkg $contains version number, $status = 0
            set -l pkg_ver (echo $pkg | sed 's!.*-!!')
            set -l pkg_name (echo $pkg | sed 's/[0-9.]*$//g')

            set pkg_com (echo $pkg_name(echo $pkg_ver | cut -c1))
            if test (command ls $elpa_path | rg "^$pkg_com" | wc -l) -gt 1
                set first (command ls $elpa_path | rg "^$pkg_com" | head -1 | sed "s/$pkg_com//g")
                set second (command ls $elpa_path | rg "^$pkg_com" | sed -n "2p" | sed "s/$pkg_com//g")
                if echo $first$second | rg -q '[a-zA-Z]'
                    continue # files/dirs like let-alias-1.0.5 and let-alias-1.0.5.signed
                end
                # echo pkg: $pkg, first: $first, second:$second
                set first_num (echo $first | sed -e 's/\.//g') # get rid of . in version number
                set second_num (echo $second | sed -e 's/\.//g')
                if test $firstnum -le $secondnum
                    echo $pkg_com$first is le
                    echo $pkg_com$second
                    set old $first
                else
                    echo $pkg_com$first is gt
                    echo $pkg_com$second
                    set old $second
                end
                if not set -q $argv[1]
                    command rm -rf $elpa_path/$pkg_com$old
                    echo $elpa_path/$pkg_com$old is deleted!
                end
                echo
            end
        end
    end
end

function vimd -d 'diff files/dirs using vim'
    if test -f $argv[1]
        vim -d -o $argv[1] $argv[2]
    else if test -d $argv[1]
        vim -c "DirDiff $argv[1] $argv[2]"
    end
end
# TODO: `pip install git+https://github.com/jeffkaufman/icdiff.git`
function diffs -d "all kinds of diff features"
    if command -sq icdiff
        icdiff $argv
    else
        set -l options 'f' 'w' 'l' 'L' 'W' 'h'
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
            return
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
        else                        # no option
            diff -r -y -s --suppress-common-line -W $COLUMNS $argv | less
        end
    end
end

function mkcd --description 'mkdir dir then cd dir'
    mkdir -p $argv
    cd $argv
end

# xclip, get content into clipboard, echo file | xclip
alias xc 'xclip -selection c'
abbr xp 'xclip'

abbr km 'sudo kermit'

abbr gcp 'google-chrome --incognito'
abbr ffp 'firefox -private-window'

abbr cx 'chmod +x'

# netease-play, douban.fm
abbr np 'netease-player'
abbr db 'douban.fm'

#vim
set -gx EDITOR 'vim'
abbr viu 'vim -u NONE'
abbr vic 'vim ~/.cgdb/cgdbrc'
alias viM 'vim -u ~/Dotfiles.d/vim/vimrc.more'
function viv -d 'edit vimrc file with vim, $VIMRC(by default), the other(-o), vanilla vim(-v)'
    set -l options 'v' 'o'
    argparse -n viv $options -- $argv
    or return

    if set -q _flag_v
        vim ~/Dotfiles.d/vim/.vimrc
    else if set -q _flag_o
        if test "$VIMRC" = "$HOME/.spacevim"
            test -f ~/.SpaceVim.d/autoload/myspacevim.vim; and vim ~/.SpaceVim.d/autoload/myspacevim.vim
        else
            test -f ~/.spacevim; and vim ~/.spacevim
        end
    else
        vim $VIMRC
    end
end
abbr vib 'vim ~/.bashrc'
abbr vie 'vim $EMACS_EL'
abbr vi2 'vim ~/Dotfiles.d/todo.org'
abbr vif 'vim $FISHRC'
abbr vit 'vim (readlink -f ~/.tmux.conf); tmux source-file ~/.tmux.conf; echo ~/.tmux.conf reloaded!'
abbr viT 'vim (readlink -f ~/.tigrc)'
function vis -d 'switch between vanilla vim(-v) <-> SpaceVim or space-vim(the default)'
    set -l options 'v'
    argparse -n vis $options -- $argv
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
            if test "$answer" = "1"
                curl -fsSL https://git.io/vFUhE | bash
                mkdir ~/.config/nvim; ln -s ~/.space-vim/init.vim ~/.config/nvim/init.vim
            else
                curl -sLf https://spacevim.org/install.sh | bash
                test (ls -ld ~/.vim | awk '{print $11}') = "$HOME/.SpaceVim"; and rm -rf ~/.vim
                test -d ~/.vim.bak; and cpb -m -b ~/.vim.bak
            end
            pip install neovim clang
        end
        if test (ls -ld ~/.config/nvim | awk '{print $11}') = "$HOME/.SpaceVim"
            read -n 1 -l -p 'echo "Currently running SpaceVim, switch to space-vim? [Y/SPC/n]: "' answer
            if test "$answer" = "y" -o "$answer" = " "
                if ! test -d ~/.space-vim
                    curl -fsSL https://git.io/vFUhE | bash
                    pip install neovim clang
                end
                if ! test -f ~/.spacevim
                    cd ~/Dotfiles.d/; stowsh -v spacevim; cd -
                end
                test -d ~/.config/nvim; and rm -rf ~/.config/nvim
                mkdir ~/.config/nvim; ln -s ~/.space-vim/init.vim ~/.config/nvim/init.vim
                set -gx VIMRC ~/.spacevim
                vim $argv
            else
                echo "Cancel the switch..."
            end
        else if test (ls -ld ~/.config/nvim/init.vim | awk '{print $11}') = "$HOME/.space-vim/init.vim"
            read -n 1 -l -p 'echo "Currently running space-vim, switch to SpaceVim? [Y/SPC/n]: "' answer
            if test "$answer" = "y" -o "$answer" = " "
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

# C-w to reload $FISHRC
#bind \cs fsr

# the gpl.txt can be gpl-2.0.txt or gpl-3.0.txt
abbr lic 'wget -q http://www.gnu.org/licenses/gpl.txt -O LICENSE'

function usertest -d 'add user test temporarily for one day, no passwd, and login into it, delete it(-d), by default add it in smart way'
    set -l options 'd'
    argparse -n usertest $options -- $argv
    or return

    if set -q _flag_d
        sudo userdel -rfRZ test
        ll /home/
        return
    end

    if test -d /home/test       # directory exists
        sudo su -s /bin/bash - test
    else
        sudo useradd -m -e (date -d "1 days" +"%Y-%m-%d") test -s /sbin/nologin
        sudo su -s /bin/bash - test
    end
end

# git
abbr gg 'tig'
abbr ggl 'tig log'
abbr gglp 'tig log -p --'
abbr ggs 'tig status'
abbr ggr 'tig refs'
abbr gits 'git status'          # = tig status(ggs)
abbr gitl 'git log --stat'      # = tig log(ggl)
abbr gitlo 'git log --oneline'  # = tig(gg)
abbr gitlp 'git log -p --' # [+ file] to how entire all/[file(even renamed)] history
abbr ggd 'git diff'        # show unstaged modification
abbr ggdd 'git difftool' # show unstaged modification using external tool such as vim
abbr gitdc 'git diff --cached'  # show staged but unpushed local modification
abbr gitsh 'git show' # [+ COMMIT] to show the modifications in a last/[specific] commit
abbr gitcm 'git commit -m'
# amend last pushed commit message with gitcma; then `git push --force-with-lease [origin master]` to push it
abbr gitcma 'git commit --amend'
abbr gitcp 'git checkout HEAD^1' # git checkout previous/old commit
abbr gitcn 'git log --reverse --pretty=%H master | rg -A 1 (git rev-parse HEAD) | tail -n1 | xargs git checkout' # git checkout next/new commit
abbr gitt 'git tag --sort=-taggerdate'    # sort tag by date, new tag first
abbr gitft 'git ls-files --error-unmatch' # Check if file/dir is git-tracked
abbr gitpu 'git push -v'
abbr gitpun 'git push -v -n'    # simulate git push
abbr gitpl 'git pull'
abbr gitpr 'git pull --rebase=interactive'
abbr gitup 'tig log origin/master..HEAD' # list unpushed commits using tig
set -l SSR socks5://127.0.0.1:1080
abbr gitpx "git config --global http.proxy $SSR; git config --global https.proxy $SSR; git config --global http.https://github.com.proxy $SSR"
abbr gitupx 'git config --global --unset http.proxy; git config --global --unset https.proxy; git config --global --unset http.https://github.com.proxy'
function gitpls -d 'git pull another repo from current dir, ~/.emacs.d(-e), ~/.space-vim(-v), ~/Dotfiles.d(by default), all(-a), or add argument'
    set -l options 'e' 'v' 'a'
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
    if set -q $argv             # no given argv
        git clean -f -d
    else
        set files (string split \n -- $argv)
        for i in $files
            echo "remove untracked file/dir: " $i
            git clean -f -d -- $i
        end
    end
end
function gitpll -d 'git pull and location it to previous commit id before git pull in git log'
    set COMMIT_ID (git rev-parse HEAD) # short version: `git rev-parse --short HEAD`
    git log -1                  # show the info of the current commit before git pull
    git pull
    git log --stat | command less -p$COMMIT_ID
end
function gitcl -d 'git clone and cd into it, full-clone(by default), simple-clone(-s)'
    set -l options 's'
    argparse -n gitcl $options -- $argv
    or return

    # https://stackoverflow.com/questions/57335936
    if set -q _flag_s
        set DEPTH "--depth=1 --no-single-branch"
        echo "Use 'git pull --unshallow' to pull all info."
    else
        set DEPTH ""
    end
    git clone -v $argv $DEPTH
    echo ---------------------------
    if test (count $argv) -eq 2
        set project $argv[2]
    else
        set project (basename $argv .git) # this works when $argv contains or not contains .git
    end
    if test -d $project
        cd $project
        echo cd ./$project
    end
end
function gitpa --description 'git pull all in dir using `fing dir`'
    for i in (find $argv[1] -type d -iname .git | sort | xargs realpath)
        cd $i; cd ../
        pwd
        git pull;
        echo -----------------------------
        echo
    end
end
function gitbs -d 'branches and worktrees'
    set -l options 'c' 'd' 'l' 'w' 'v' 'h'
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
        echo "      -v       --> show verbose info of branches"
        echo "      no argv  --> list branches"
        echo "      fzf      --> switch branch using fzf"
        echo "      argv     --> if branch $argv exist, switch to it, if not, create and switch to it"
        echo "      -w       --> add worktree if given argv and cd into it, if else list worktree"
        echo "      -w -d    --> delete worktree"
        echo "      -h       --> usage"
        return
    else if set -q _flag_w
        if set -q _flag_d
            git worktree remove $argv
        else
            if set -q $argv[1]  # no argument
                git worktree list
            else if test -d $argv
                echo "Directory $argv already exists!"
                return
            else
                git worktree add $argv
                and cd $argv
            end
        end
    else                 # by default, for branch operations instead of worktree
        if set -q _flag_c
            if set -q _flag_l   # git log
                # NOTE: .. and ... are different
                # and are opposite meanings in diff and log
                # https://stackoverflow.com/questions/7251477
                # https://stackoverflow.com/questions/462974
                # $argv[1]/$argv[2] can branch names or commit ids
                if set -q _flag_d
                    echo git log $argv[1]...$argv[2] > branches.log
                    git log $argv[1]...$argv[2] >> branches.log
                    vim branches.log
                else
                    git log $argv[1]...$argv[2]
                end
            else                # git diff by default
                if set -q _flag_d
                    echo git diff $argv[1]..$argv[2] > branches.diff
                    git diff $argv[1]..$argv[2] >> branches.diff
                    vim branches.diff
                else
                    if set -q _flag_v
                        git diff --name-status $argv[1]..$argv[2]
                    else
                        git diff $argv[1]..$argv[2]
                    end
                end
            end
        else if set -q _flag_l
            if set -q $argv
                git ls-remote --heads
            else
                git ls-remote --heads | rg -i $argv
            end
        else if set -q _flag_d
            if set -q $argv[1]  # no argv
                git branch -a | fzf | xargs git branch -d
            else
                git branch -d $argv
            end
        else if set -q _flag_v
            git branch -vv
        else
            if set -q $argv[1]  # no argument
                git branch      # list local branches
                # get the current branch name
                echo "Current branch name:"
                git name-rev --name-only HEAD
            else if test "$argv" = "fzf" # use fzf to switch branch
                # NOTE: if the branch is not in `git branch -a`, try `git ls-remote`
                git fetch
                git branch -a | fzf | xargs git checkout
            else                # checkout $argv branch if exists, else create it
                git checkout $argv ^/dev/null
                or git checkout -b $argv
            end
        end
    end
end
function gitco -d 'git checkout -- for multiple files(filA fileB...) at once, all by default'
    if set -q $argv # no given files
        # in case accidentally git checkout all unstaged files
        read -n 1 -l -p 'echo "Checkout all unstaged files? [Y/n]"' answer
        if test "$answer" = "y" -o "$answer" = " "
            git checkout .
        else
            echo "Cancel and exit!"
            return
        end
    else
        # pass commit id
        if git merge-base --is-ancestor $argv HEAD ^/dev/null
            git checkout $argv
        else if test "$argv" = "-" # git switch to previous branch/commit
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
    git remote -v | rg "upstream" ^/dev/null >/dev/null
    set -l upstream_status $status
    if test $upstream_status = 1; and set -q $argv[1]
        echo "Remote upstream is not set, unable to sync!"
        return
    else
        if test $upstream_status != 0
            if set -q $arv[1]       # given argument
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
    set -l options 's' 'h'
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
            if test "$answer" = "y" -o "$answer" = " "
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

function gitdl -d 'download several files from github'
    set -l options 'b' 'B' 'f' 'g' 's' 'v' 'z' 'h'
    argparse -n gitdl $options -- $argv
    or return

    set bins bat broot fzf gitmux scc nvim z.lua
    set funs batp brootp fzfp gitmuxp sccp nvimp zlp
    if set -q _flag_h
        echo "gitdl [-b/-B/-f/-s/-v/-z/-h]"
        echo "      no option --> once for all"
        echo "      -b --> $bins[1]"
        echo "      -B --> $bins[2]"
        echo "      -f --> $bins[3]"
        echo "      -g --> $bins[4]"
        echo "      -s --> $bins[5]"
        echo "      -v --> $bins[6]"
        echo "      -z --> $bins[7]"
        echo "      -h --> usage"
        return
    else if set -q _flag_b
        echo "Update/Download $bins[1]..."
        eval $funs[1] u
    else if set -q _flag_B
        echo "Update/Download $bins[2]..."
        eval $funs[2] u
    else if set -q _flag_f
        echo "Update/Download $bins[3]..."
        eval $funs[3] u
    else if set -q _flag_g
        echo "Update/Download $bins[4]..."
        eval $funs[4] u
    else if set -q _flag_s
        echo "Update/Download $bins[5]..."
        eval $funs[5] u
    else if set -q _flag_v
        echo "Update/Download $bins[6]..."
        eval $funs[6] u
    else if set -q _flag_z
        echo "Update/Download $bins[7]..."
        eval $funs[7] u
    else                        # no option
        read -n 1 -p 'echo "Update/Download all of $bins from github? [Y/n]: "' -l arg
        if test "$arg" = "" -o "$arg" = "y" -o "$arg" = " "
            # dictionary/hash copied from fish-shell/issues/390#issuecomment-360259983
            for key in $bins
                if set -l index (contains -i -- $key $bins)
                    eval $funs[$index] u
                    echo -e "\n=======================================================\n"
                end
            end
        else
            echo "Quit to update/download all of $bins from github!!!"
        end
    end
end

# docker related
abbr docksi 'docker search'     # search a image
abbr dockp 'docker pull'        # pull image +name:tag
# create container example:
# docker run -it -v ~/Public/tig:/Public/tig -net host --name new_name ubuntu:xenial /bin/bash
abbr dockrun 'docker run -it'   # create a container
abbr dockr 'docker rm'          # remove container +ID
abbr dockri 'docker rmi'        # remove image +repo
abbr dockl 'docker ps -a'       # list all created containers
abbr dockli 'docker image ls'   # list all pulled images
function dock2 -d 'start an existed container(or session), first list all the container, then input the ID'
    docker ps -a
    set -l docker_cnt (docker ps -a | wc -l)
    set -l ID
    if test $docker_cnt = 2
        set ID (docker ps -a | tail -1 | awk '{print $1}')
    else if test $docker_cnt -gt 2
        read -p 'echo -e "\nType the container ID: "' -l arg
        set ID $arg
    else if test $docker_cnt -lt 2
        echo "No available container!"
        return
    end

    docker inspect --format="{{.State.Running}}" $ID | rg true ^/dev/null >/dev/null
    if test $status = 0
        # if the ID is already running, exec it,
        # meaning: start another session on the same running container
        echo -e "\nNOTE: the container is already running in another session...\n"
        docker exec -it $ID bash
    else
        docker start -i $ID
    end
end
function docklt -d 'list the first 10 tags for a docker image'
    curl https://registry.hub.docker.com/v2/repositories/library/$argv[1]/tags/ | jq '."results"[]["name"]'
    and echo -e "\nThese are the first 10 tags, use `docklta` to list all tags!\nPlease use `dockp $argv[1]:tag` to pull the image!"
end
function docklta -d 'list all tags for a docker image'
    echo "Wait..."
    wget -q https://registry.hub.docker.com/v1/repositories/$argv[1]/tags -O -  | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}'
    and echo -e "\nThese are all the tags!\nPlease use `dockp $argv[1]:tag` to pull the image!"
end
function docksh -d 'add a share folder to existed container'
    docker ps -a
    read -p 'echo -e "\nType the container ID: "' -l id
    read -p 'echo "new container name: "' -l new_name
    docker commit $id $new_name
    read -p 'echo "The share folder(absolute path) in host: "' -l share_src
    read -p 'echo "The share folder(absolute path) in container: "' -l share_dst
    docker run -ti -v $share_src:$share_dst $new_name /bin/bash
end

if test (ps -ef | rg -v rg | rg -i shadowsocks | awk '{ print $(NF-2)     }') # ssr is running
    set -g PXY 'proxychains4 -q'
else
    set -g PXY
end

abbr bb 'bat'
function batp -d 'check if bat exists, or with any argument, download the latest version'
    if command -sq bat; and set -q $argv[1] # bat is in $PATH, and no any argv is given, two conditions
        # echo "bat is installed, use any extra to upgrade it!"
        return 0
    else
        set tag_name (eval $PXY curl -s "https://api.github.com/repos/sharkdp/bat/releases/latest" | rg "tag_name" | cut -d : -f 2 | awk -F[\"\"] '{print $2}')
        if not test $tag_name
            echo "API rate limit exceeded, please input your password for your username!"
            set tag_name (eval $PXY curl -u c02y -s "https://api.github.com/repos/sharkdp/bat/releases/latest" | rg "tag_name" | cut -d : -f 2 | awk -F[\"\"] '{print $2}')
        end
        set file_name (echo bat-$tag_name-x86_64-unknown-linux-gnu.tar.gz)

        set file_link (echo https://github.com/sharkdp/bat/releases/download/$tag_name/$file_name)
        eval $PXY wget $file_link -O /tmp/$file_name
        if test -s /tmp/$file_name
            tar xvfa /tmp/$file_name -C /tmp
            install -m 755 /tmp/bat-$tag_name-x86_64-unknown-linux-gnu/bat ~/.local/bin/bat
            echo -e "\n====bat installed...====\n"
            return 0
        else
            echo "fzf doesn't exist and error occurs when downloading it!"
            return 1
        end

    end
end

function brootp -d 'check if broot exists, or with any argument, download the latest version'
    if command -sq broot; and set -q $argv[1] # broot is in $PATH, and no any argv is given, two conditions
        # echo "broot is installed, use any extra to upgrade it!"
        return 0
    else
        set br_path ~/.local/bin/broot
        eval $PXY curl -o $br_path -LO https://dystroy.org/broot/download/x86_64-linux/broot
        if test -s $br_path
            chmod +x $br_path
            echo -e "\n====broot installed...====\n"
            return 0
        else
            echo "broot doesn't exist and error occurs when downloading it!"
            return 1
        end
    end
end

function gitmuxp -d 'check if gitmux exists, or with any argument, download the latest version'
    if command -sq gitmux; and set -q $argv[1] # gitmux is in $PATH, and no any argv is given, two conditions
        # echo "gitmux is installed, use any extra to upgrade it!"
        return 0
    else
        # https://github.com/boyter/scc/releases/download/v2.2.0/scc-2.2.0-x86_64-unknown-linux.zip
        set tag_name (eval $PXY curl -s "https://api.github.com/repos/arl/gitmux/releases/latest" | rg "tag_name" | cut -d : -f 2 | awk -F[\"\"] '{print $2}')
        if not test $tag_name
            echo "API rate limit exceeded, please input your password for your username!"
            set tag_name (eval $PXY curl -u c02y -s "https://api.github.com/repos/arl/gitmux/releases/latest" | rg "tag_name" | cut -d : -f 2 | awk -F[\"\"] '{print $2}')
        end
        set file_name (echo gitmux_(echo $tag_name | sed 's/^v//')_linux_amd64.tar.gz)
        set file_link (echo https://github.com/arl/gitmux/releases/download/$tag_name/$file_name)
        eval $PXY wget -c $file_link -O /tmp/$file_name
        if test -s /tmp/$file_name
            tar xvfa /tmp/$file_name -C ~/.local/bin/
            echo -e "\n====gitmux installed...====\n"
            return 0
        else
            echo "gitmux doesn't exist and error occurs when downloading it!"
            return 1
        end
    end
end
function nvimp -d 'check if nvim exists, or with any argument, download the latest stable/nightly(-n) version'
    set -l options 'n'
    argparse -n nvimp $options -- $argv
    or return

    if command -sq nvim; and set -q $argv[1] # nvim is in $PATH, and no any argv is given, two conditions
        return 0
    else
        if set -q _flag_n
            eval $PXY curl -o ~/.local/bin/nvim -LOC - https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
            if test -s ~/.local/bin/nvim
                chmod +x ~/.local/bin/nvim
                return 0
            else
                return 1
            end
        else
            # https://github.com/neovim/neovim/releases/download/v0.4.2/nvim.appimage
            set tag_name (eval $PXY curl -s "https://api.github.com/repos/neovim/neovim/releases/latest" | rg "tag_name" | cut -d : -f 2 | awk -F[\"\"] '{print $2}')
            if not test $tag_name
                echo "API rate limit exceeded, please input your password for your username!"
                set tag_name (eval $PXY curl -u c02y -s "https://api.github.com/repos/neovim/neovim/releases/latest" | rg "tag_name" | cut -d : -f 2 | awk -F[\"\"] '{print $2}')
            end
            set file_name (echo nvim.appimage)
            set file_link (echo https://github.com/neovim/neovim/releases/download/$tag_name/$file_name)
            eval $PXY wget -c $file_link -O /tmp/$file_name
            if test -s /tmp/$file_name # check if file exists and not empty
                install -m 755 /tmp/$file_name ~/.local/bin/nvim
                echo -e "\n====nvim installed...====\n"
                return 0
            else
                echo "nvim doesn't exist and error occurs when downloading it!"
                return 1
            end
        end
    end
end

function sccp -d 'check if scc exists, or with any argument, download the latest version'
    if command -sq scc; and set -q $argv[1] # scc is in $PATH, and no any argv is given, two conditions
        # echo "scc is installed, use any extra to upgrade it!"
        return 0
    else
        # https://github.com/boyter/scc/releases/download/v2.2.0/scc-2.2.0-x86_64-unknown-linux.zip
        set tag_name (eval $PXY curl -s "https://api.github.com/repos/boyter/scc/releases/latest" | rg "tag_name" | cut -d : -f 2 | awk -F[\"\"] '{print $2}')
        if not test $tag_name
            echo "API rate limit exceeded, please input your password for your username!"
            set tag_name (eval $PXY curl -u c02y -s "https://api.github.com/repos/boyter/scc/releases/latest" | rg "tag_name" | cut -d : -f 2 | awk -F[\"\"] '{print $2}')
        end
        set file_name (echo scc-(echo $tag_name | sed 's/^v//')-x86_64-unknown-linux.zip)
        set file_link (echo https://github.com/boyter/scc/releases/download/$tag_name/$file_name)
        eval $PXY wget -c $file_link -O /tmp/$file_name
        if test -s /tmp/$file_name
            unzip -o -e /tmp/$file_name -d ~/.local/bin/
            echo -e "\n====scc installed...====\n"
            return 0
        else
            echo "scc doesn't exist and error occurs when downloading it!"
            return 1
        end
    end
end

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
abbr fcg 'fc-list | ag'

function wc
    if test (count $argv) -gt 1
        command wc $argv | sort -n
    else
        command wc $argv
    end
end

abbr st '~/Dotfiles.d/bin/.local/bin/stowsh -v'

abbr ipy 'ipython' # other alternatives are btpython, ptpython, ptipython
abbr pdb 'pudb3'
function pips -d 'pip related functions, default(install), -i(sudo install), -c(check outdated), -r(remove/uninstall), -s(search), -u(update all outdated packages), -U(upgrade specific packages)'
    set -l options 'i' 'c' 'r' 's' 'u' 'U'
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
        sudo pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -U (pip list --outdated | awk 'NR>2 {print $1}')
    else if set -q _flag_r
        pip uninstall $argv
        or sudo pip uninstall $argv
    else if set -q _flag_s
        pip search $argv
    else if set -q _flag_U
        sudo pip install -i https://pypi.tuna.tsinghua.edu.cn/simple -U $argv
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
function x -d 'exit or deactivate in python env'
    if not set -q $VIRTUAL_ENV # running in python virtual env
        # TODO: since sth. is wrong with the deactivate function in $argv/bin/activate.fish
        deactivate ^/dev/null >/dev/null
        source $FISHRC
    else if not set -q $CONDA_DEFAULT_ENV # running in conda virtual env
        cons -x
    else
        exit
    end
end

# abbr rea 'sudo ~/.local/bin/reaver -i mon0 -b $argv[1] -vv'
# function rea
# sudo ~/.local/bin/reaver -i mon0 -b $argv
# end

abbr epub 'ebook-viewer --detach'
# alias time 'time -p'

abbr sss 'ps -eo tty,command | rg -v rg | rg "sudo ssh "'
abbr p 'ping -c 5'
alias ping 'ping -c 5'
function po -d 'Test the connection of outside internet'
    if not timeout 1 ping... # failed, $status != 0
        echo Offline!
    else
        echo Online!
    end
end
function pl -d 'Test the connection of inside internet'
    if test (count $argv) -eq 1
        if not timeout 1 ping -c 1 10.8.2.$argv ^/dev/null >/dev/null
            echo Offline!
        else
            echo Online!
        end
    else
        if not timeout 1 ping -c 1 10.0.4.4 ^/dev/null >/dev/null
            echo Offline!
        else
            echo Online!
        end
    end
end
function pv --description "ping vpn servers"
    p p1.jp1.seejump.com | tail -n3
    echo --------------------------------------------------------------
    p p1.jp2.seejump.com | tail -n3
    echo --------------------------------------------------------------
    p p1.jp3.seejump.com | tail -n3
    echo --------------------------------------------------------------
    p p1.jp4.seejump.com | tail -n3
    echo --------------------------------------------------------------
    p p1.hk1.seejump.com | tail -n3
    echo --------------------------------------------------------------
    p p1.hk2.seejump.com | tail -n3
    echo --------------------------------------------------------------
    p p1.hk3.seejump.com | tail -n3
    echo --------------------------------------------------------------
end
function ipl -d 'get the location of your public IP address'
    if test (ps -ef | rg -v rg | rg -i shadow | awk '{ print $(NF-2)     }') # ssr is running
        proxychains4 -q curl myip.ipip.net
    else
        curl myip.ipip.net
    end
end
function port -d 'list all the ports are used or check the process which are using the port'
    if test (count $argv) = 1
        netstat -tulpn | rg $argv
    else
        netstat -tulpn
    end
end

alias wget 'wget -c --no-check-certificate'
alias wgets 'wget -c --mirror -p --html-extension --convert-links'
alias curls 'curl -L -O -C -'
# curl -L -O -C - https://site.com/file.iso
alias aria2 'aria2c -c -x 5 --check-certificate=false --file-allocation=none'
abbr sky 'curl wttr.in'
abbr wt 'bash -c \'rm -rf /tmp/Baidu* 2>/dev/null\'; wget -c -P /tmp/ https://speedxbu.baidu.com/shurufa/ime/setup/BaiduWubiSetup_1.2.0.67.exe'
abbr wtt 'bash -c \'rm -rf /tmp/Baidu* 2>/dev/null\'; wget --connect-timeout=5 -c -P /tmp/ https://speedxbu.baidu.com/shurufa/ime/setup/BaiduPinyinSetup_5.5.5063.0.exe'
function wgetr -d 'for wget that get stuck in middle of downloads'
    while true
        command wget -c --no-check-certificate -T 5 -c $argv; and break
    end
end
abbr pxx 'proxychains4 -q'
function pxs -d 'multiple commands using proxychains4'
    set -l options 'a' 'c' 'w'
    argparse -n pxs $options -- $argv
    or return

    if set -q _flag_a
        proxychains4 -q aria2c -c -x 5 --check-certificate=false --file-allocation=none $argv
    else if set -q _flag_c
        proxychains4 -q curl -L -O -C - $argv
    else if set -q _flag_w
        proxychains4 -q wget -c --no-check-certificate $argv
    else
        proxychains4 -q $argv
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

function deff
    echo "-1\n" | sdcv $argv | head -n 1 | rg ", similar to " ^/dev/null >/dev/null
    if test $status = 0         # Found exact words or similar
        echo "-1\n" | sdcv $argv | head -n 2 | tail -n 1 | rg "^-->" ^/dev/null >/dev/null
        if test $status = 0     # Exact definition
            sdcv $argv
        else                    # similar
            echo "-1\n" | sdcv $argv | head -n 1 | rg $argv
            # 1th, send -1 to prompt; 3th, delete last line; 4th, delete first line;
            # 5th, get last part after ">"; 5th & 6th, delete duplicates;
            # 7th, combine and separate multiple lines (words) with ", "
            # 8th, delete last ", "
            echo "-1\n" | sdcv $argv | head -n -1 | tail -n +2 | cut -d ">" -f 2 | sort | uniq | awk 'ORS=", "' | sed 's/, $/\n/'
        end
    else                        # Nothing similar
        sdcv $argv
    end
    # NOTE: double quotes in sed, single quotes does not work
    sed -i "/\<$argv\>/d" ~/.sdcv_history # delete the word in ~/.sdcv_history
end
function SDCV
    sdcv -u "WordNet" -u "牛津现代英汉双解词典" -u "朗道英汉字典5.0" $argv
    sort -u -o ~/.sdcv_history ~/.sdcv_history # sort and unique them
end
function defc_new -d 'Check if the word is new in ~/.sdcv_history, if new add it'
    rg -w $argv ~/.sdcv_history >> /dev/null
    or begin # new, not searched the dict before, save
        if not test -e ~/.sdcv_rem
            touch ~/.sdcv_rem
        end
        echo ---------------------------------------------- >> ~/.sdcv_rem
        echo -e \< $argv \> >> ~/.sdcv_rem
        echo ---------------------------------------------- >> ~/.sdcv_rem
        SDCV $argv >> ~/.sdcv_rem
        echo ---------------------------------------------- >> ~/.sdcv_rem
        echo >> ~/.sdcv_rem
    end
end
function defc --description 'search the defnition of a word and save it into personal dict if it is the first time you search'
    echo "-1\n" | SDCV $argv | head -n 1 | rg ", similar to " ^/dev/null >/dev/null
    if test $status = 0         # Found exact words or similar
        echo "-1\n" | SDCV $argv | head -n 2 | tail -n 1 | rg "^-->" ^/dev/null >/dev/null
        if test $status = 0     # Exact definition
            SDCV $argv
            defc_new $argv
        else                    # similar
            echo "-1\n" | SDCV $argv | head -n 1 | rg $argv
            echo "-1\n" | SDCV $argv | head -n -1 | tail -n +2 | cut -d ">" -f 2 | sort | uniq | awk 'ORS=", "' | sed 's/, $/\n/'
            sed -i "/\<$argv\>/d" ~/.sdcv_history # delete the wrong word in ~/.sdcv_history
        end
    else                        # Nothing similar
        SDCV $argv
        sed -i "/\<$argv\>/d" ~/.sdcv_history # delete the wrong word in ~/.sdcv_history
    end
end

# count chars of lines of a file
# awk '{ print length }' | sort -n | uniq -c

# note that there is no $argv[0], the $argv[1] is the first argv after the command name, so the argc of `command argument` is 1, not 2
function man
    if test (count $argv) -eq 2
        #sed -i "s/.shell/\"$argv[2]\n.shell/g" ~/.lesshst
        echo "\"$argv[2]" >> ~/.lesshst
    else
        #sed -i "s/.shell/\"$argv[1]\n.shell/g" ~/.lesshst
        echo "\"$argv[1]" >> ~/.lesshst
    end
    command man $argv
end
abbr ma 'man'

function wtp --description 'show the real definition of a type or struct in C code, you can find which file it is defined in around the result'
    gcc -E ~/.local/bin/type.c -I$argv[1] > /tmp/result
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

# if usb0 is not connected or data sharing is not enabled:
# `ip link ls dev usb0` returns 255, else returns 0
# if usb0 is not connected to network:
# `ip link ls dev usb | rg UP` returns 1, else returns 0
# if returns 1, then kill dhclient and enabled dhclient again:
# sudo dhclient usb0
function ut -d 'toggle -- use data network sharing through Android device throught USB'
    ip link ls dev usb0 ^/dev/null >/dev/null
    if not ip link ls dev usb0 ^/dev/null >/dev/null0 # ()=255, not plugged or enabled in Android device
        echo Android device is not plugged or data network sharing is not enabled!
    else          # ()=0
        # ip link ls dev usb0 | rg UP ^/dev/null >/dev/null
        # if test $status != 0
        if test 1 != 0
            # echo Network on usb0 is off!
            if test (pgrep dhclient | wc -l) != 0 # This will be useless since the latter kill
                echo dhclient is already running, Kill it!
                echo "      " | sudo -p "" -S pkill dhclient
            end
            echo Starting `dhclient usb0`
            echo "      " | sudo -p "" -S dhclient usb0
            # something it will fail, output error message like
            # dhclient(26477) is already running - exiting....
            if test $status != 0
                sudo dhclient -r
                sudo dhclient
                sudo pkill dhclient
            end
        else
            # echo Network on usb0 is already on!
        end
        if test (pgrep dhclient | wc -l) != 0
            sudo pkill dhclient  # this has no effect on the network, just make next usbt quicker
        end
    end
end

abbr um 'pumount /run/media/chz/UDISK'
abbr mo 'pmount /dev/sdb4 /run/media/chz/UDISK'
function mo-bak
    set -l done 1
    while test $done = 1
        if not command df | rg -v rg | rg -i UDISK  ^/dev/null >/dev/null # no UDISK in df, new or unplug
            set -l device
            if test -b /dev/sdb4
                set device /dev/sdb4
            else if test -b /dev/sdc4
                set device /dev/sdc4
            else
                echo Please plug your USB drive!!!
                return
            end
            pmount $device /media/UDISK
            df
            return
        else                        # UDISK is in df, right or not-umount old
            set -l device (command df | rg -v rg | rg -i UDISK | awk '{print $1}')
            if not test -b $device
                if not pumount /media/UDISK ^/dev/null >/dev/null
                    echo $device -- /media/UDISK is busy.
                    lsof | rg UDISK
                    return
                end
            else                    # right
                echo Device /dev/sdb4 is already mounted to /media/UDISK
                return
            end
        end
    end
end

abbr ytd 'youtube-dl -citw'

function rgs -d 'rg sth in init.el(-e)/errno(-E)/config.fish(-f)/.tmux.conf(-t)/vimrc(-v), or use fzf(-F) to open the file, git repo(-g)'
    set -l options 'e' 'E' 'f' 'F' 'g' 't' 'v'
    argparse -n rgs -N 1 $options -- $argv
    or return

    if set -q _flag_e
        set FILE $EMACS_EL
    else if set -q _flag_E
        for file in /usr/include/asm-generic/errno-base.h /usr/include/asm-generic/errno.h
            rg -i $argv[1] $file
        end
        return
    else if set -q _flag_f
        set FILE $FISHRC
    else if set -q _flag_g
        git grep "$argv" (git rev-list --all)
    else if set -q _flag_t
        set FILE ~/.tmux.conf
    else if set -q _flag_v
        set FILE $VIMRC
    else                        # without options
        if set -q $argv[2] # no $argv[2]
            set FILE .
        else
            set FILE $argv[2]
        end
    end

    echo "\"$argv[1]" >> ~/.lesshst
    rg --hidden -p $argv[1] $FILE | less -i -RM -FX -s

    if set -q _flag_F # search pattern(s) in dir/file, open if using vim
        read -n 1 -p 'echo "Open it with vim? [Y/n]: "' -l answer
        if test "$answer" = "y" -o "$answer" = " "
            rg --hidden --color never $argv[1] $FILE -l | fzf --bind 'enter:execute:vim {} < /dev/tty'
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
    set -l options 'b' 'm'
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
            if test "/" = (echo (string sub --start=-1 $name)) # for dir ending with "/"
                set old (echo (string split -r -m1 / $name)[1])
            end
            if test -e $old.bak
                echo $old.bak already exists.
                read -n 1 -l -p 'echo "Remove $old.bak first? [y/N]"' answer
                if test "$answer" = "y" -o "$answer" = " "
                    rm -rfv $old.bak
                else
                    continue
                end
            end
            eval $CMD $old{,.bak}
        end
    end
end

function d --description "Choose one from the list of recently visited dirs"
    # this function is introduced into fish-shell release since v2.7b1, called `cdh` (mostly similar)
    # See if we've been invoked with an argument. Presumably from the `cdh` completion script.
    # If we have just treat it as `cd` to the specified directory.
    if set -q argv[1]
        cd $argv
        return
    end

    if set -q argv[2]
        echo (_ "d: Expected zero or one arguments") >&2
        return 1
    end

    set -l all_dirs $dirprev $dirnext
    if not set -q all_dirs[1]
        echo (_ 'No previous directories to select. You have to cd at least once.') >&2
        return 0
    end

    # Reverse the directories so the most recently visited is first in the list.
    # Also, eliminate duplicates; i.e., we only want the most recent visit to a
    # given directory in the selection list.
    set -l uniq_dirs
    for dir in $all_dirs[-1..1]
        if not contains $dir $uniq_dirs
            set uniq_dirs $uniq_dirs $dir
        end
    end

    set -l letters - b c d e f h i j k l m n o p q r s t u v w x y z
    set -l dirc (count $uniq_dirs)
    if test $dirc -gt (count $letters)
        set -l msg 'This should not happen. Have you changed the cd command?'
        printf (_ "$msg\n")
        set -l msg 'There are %s unique dirs in your history' \
            'but I can only handle %s'
        printf (_ "$msg\n") $dirc (count $letters)
        return 1
    end

    # Print the recent directories, oldest to newest. Since we previously
    # reversed the list, making the newest entry the first item in the array,
    # we count down rather than up.
    # already_pwd avoid always print the bottom line *pwd:...
    set -l pwd_existed 0
    for i in (seq $dirc -1 1)
        set dir $uniq_dirs[$i]

        if test $pwd_existed != 1
            if test "$dir" = "$PWD"
                set pwd_existed 1
            end
        end

        set -l home_dir (string match -r "$HOME(/.*|\$)" "$dir")
        if set -q home_dir[2]
            set dir "~$home_dir[2]"
            # change dir from /home/user/path to ~/path
            # dir is not PWD anymore
        end

        if test $pwd_existed = 1
            printf '%s* %2d)  %s%s\n' (set_color red) $i $dir (set_color normal)
            set pwd_existed 2 # to make the rest of current the dirprev not red
        else if test $i = 1
            printf '%s- %2d)  %s%s\n' (set_color cyan) $i $dir (set_color normal)
        else if test $i != 1 -a $pwd_existed != 1
            printf '%s %2d)  %s\n' $letters[$i] $i $dir

        end
    end
    if test $pwd_existed = 0 # means the current dir is not in the $uniq_dirs
        printf '%s* %2d)  %s%s\n' (set_color red) "0" $PWD (set_color normal)
    end

    echo '---------------------------'
    read -n 1 -l -p 'echo "Goto: "' choice
    if test "$choice" = ""
        return 0
    else if string match -q -r '^[\-|b-z]$' $choice
        set choice (contains -i $choice $letters)
    end

    if string match -q -r '^\d+$' $choice
        if test $choice -ge 1 -a $choice -le $dirc
            cd $uniq_dirs[$choice]
            set -l dir_short (string match -r "$HOME(/.*|\$)" "$uniq_dirs[$choice]")
            set -l cd_dir "~$dir_short[2]"
            echo cd $cd_dir
            return
        else if test $choice -eq 0
            echo You are already in directory `(pwd)`
        else
            echo Error: expected a number between 0 and $dirc, got \"$choice\"
            return 1
        end
    else
        echo Error: expected a number between 1 and $dirc or letter in that range, got \"$choice\"
        return 1
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
# ~/anaconda3/bin/conda install -c lebedov tig
source $HOME/anaconda3/etc/fish/conf.d/conda.fish >/dev/null ^/dev/null
abbr condas '~/anaconda3/bin/binstar search -t conda' # [packagename]
abbr condai '~/anaconda3/bin/conda install' # [packagename]
abbr condaic '~/anaconda3/bin/conda install -c' # [channel] [packagename]
abbr condau '~/anaconda3/bin/conda upgrade --all -vy; and ~/anaconda3/bin/conda clean -avy'
abbr condac '~/anaconda3/bin/conda clean -avy'
abbr condaS '~/anaconda3/bin/anaconda show' # [channel/packagename]

function cons -d 'conda virtual environments related functions -i(install package in env, -x(exit the env), -l(list envs), -L(list pkgs in env), -r(remove env and its pkgs)), default(switch or pip install argv based on base env), -n(new env with python/pip installed, -b to create new one based on base env)'
    set -l options 'b' 'i' 'n' 'x' 'l' 'L' 'r'
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
            if test $argv = "base"
                echo "!!!Donnot remove base env!!!"
                return -1
            end
            conda remove -n $argv --all
        else if not set -q $CONDA_DEFAULT_ENV # in env
            if test $CONDA_DEFAULT_ENV = "base"
                echo "!!!base env here, do not remove it!!!"
                return -1
            end
            if not set -q $argv ; and test "$CONDA_DEFAULT_ENV" != "$argv" # given another argv
                conda remove -n $argv --all
            else                # no argv or argv=current env
                set argv $CONDA_DEFAULT_ENV
                conda deactivate
                echo "Exit the conda env..."
                conda remove -n $argv --all
            end
        end
    else if set -q _flag_n      # new env, at least one argv
        if set -q $argv         # no argv
            echo "argv is needed!"
            return -1
        else
            if conda env list | awk '{ print $1 }' | rg -w $argv[1] > /dev/null ^/dev/null
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
                conda activate $argv[1] >/dev/null ^/dev/null; and echo "conda env switched to $argv[1]"
                if test (count $argv) -gt 1
                    pip install $argv[2..(count $argv)] # array slice in fish shell
                end
            end
        end
    else                        # no option, switch env or pip install based on base env
        if set -q $argv         # no argv
            conda env list
            read -p 'echo "Which conda env switching to: "' argv
            if test "$argv" = "" # still no argv, just enter("", not " ") for read prompt
                return -1
            else if test (echo $argv[1] | rg ' ' -c) -eq 1
                # contains space in read argv
                echo "$argv[1]: error format!"
                return -1
            end
        end
        if conda env list | awk '{ print $1 }' | rg -w $argv[1] > /dev/null ^/dev/null
            conda activate $argv[1]
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
