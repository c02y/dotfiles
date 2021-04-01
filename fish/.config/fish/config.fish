### you can use `fish_config` to config a lot of things in WYSIWYG way in browser

set -gx TERM screen-256color
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
# Use different PATH/MANPATH for different distro since anaconda may affect system tools
# for Windows and Linux compatible
if command -sq uname
    if test (uname) = "Linux"
        if command -sq lsb_release
            if not test (lsb_release -i | rg -i -e 'manjaro|arch|opensuse') # not manjaro/arch/opensuse
                set -gx PATH $HOME/anaconda3/bin $PATH
                set -gx MANPATH $HOME/anaconda3/share/man $MANPATH
            end
        end
    else
        # Windows
        set -gx PATH /mingw64/bin /c/Program\ Files/CMake/bin $PATH
    end
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

# show key code and key name using xev used for other programs such as sxhkd
abbr key "xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf \"%-3s %s\n\", \$5, \$8 }'"

if test $DISPLAY
    # change keyboard auto repeat, this improves keyboard experience, such as the scroll in Emacs
    # Check default value and result using `xset -q`
    # 200=auto repeat delay, given in milliseconds
    # 50=repeat rate, is the number of repeats per second
    # or uncomment the following part and use System Preference
    if command -sq uname; and test (uname) = "Linux"
        xset r rate 200 100
    end

    # fix the Display :0 can't be opened problem
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
    echo $FISHRC is reloaded!
    vars -c ^/dev/null >/dev/null
end

# tmux related
abbr tls 'tmux list-panes -s'
function tk -d 'tmux kill-session all(default)/single(id)/multiple(id1 id2)/except(-e)/list(-l) sessions'
    if test (ps -ef | rg -w -v rg | rg tmux | wc -l ) = 0
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
if test "$TERM" = "dumb"
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
# all bindings should be put inside the single one fish_user_key_bindings
function fish_user_key_bindings
    # without this line, C-l will not print the path at top of the screen
    #bind \cl 'clear; commandline -f repaint; path_prompt'
    #bind \cl ""
    #bind \cl "tput reset; commandline -f repaint; path_prompt"
    bind \cd delete-or-ranger # check the BUG part in the function
    bind \cq lazygit
    # if Alt-backword doesn't work, use this
    # TODO: delete it if fish-shell itself fix it
    bind \e\b backward-kill-word
    # TODO: delete it if fish-shell itself fix it
    # Ctrl-c/v is bound to fish_clipboard_copy/paste which is not working in non-X
    if not test $DISPLAY
        bind --erase \cx # or bind \cx ""
        bind --erase \cv # or bind \cv ""
    end
    fzf_key_bindings # C-s for file/dir, C-r for history, Tab for complete
    bind --erase \cb
    bind \cf zz
    bind \ch htop
end

abbr pm-sl 'sudo pm-suspend' # 'Suspend to ram' in GUI buttom, power button to wake up
abbr pm-hb 'sudo pm-hibernate' # not work in old CentOS6

abbr rgr 'ranger'
abbr fpp '~/Public/PathPicker/fpp'
abbr ga 'glances -t 1 --hide-kernel-threads -b --disable-irq --enable-process-extended'
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
    set -l options 'a' 's' 'r' 'e' 'l' 'A'
    argparse -n lls $options -- $argv
    or return

    # no dir is given, assign it to .
    # the single quote in `'$argv'` is for directories with space like `~/VirtualBox VMs/`
    set -q $argv[1]; and set ARGV .; or set ARGV '$argv'
    # using -A to not show hidden files/dirs
    ! set -q _flag_A; and set OPT -A --color=yes $ARGV; or set OPT --color=yes

    set -q _flag_l; and set OPT $OPT -lh
    # reverse order(-r) or not
    set -q _flag_r; and set OPT $OPT -r
    # list and sort by extension, and directories first
    set -q _flag_e; and eval ls $OPT -X --group-directories-first $ARGV && return
    # list all(-a) or not
    set -q _flag_a; and set PIP "| nl -v 0 | sort -nr"; or set PIP "| nl -v 0 | sort -nr | tail -20"
    # sort by size(-s) or sort by last modification time
    set -q _flag_s; and set OPT $OPT --sort=size; or set OPT $OPT --sort=time --time=ctime

    eval ls $OPT $PIP
end

# valgrind
# TODO: pip install colour-valgrind
# abbr va='valgrind -v --track-origins=yes'
abbr va 'colour-valgrind --track-origins=yes --leak-check=full'
# more detail about time
abbr vad 'colour-valgrind --tool=callgrind --dump-instr=yes --simulate-cache=yes --collect-jumps=yes'

abbr kill9 'killall -9'
# get the pid of a gui program using mouse
abbr pid 'xprop | rg -i pid | rg -oe "[0-9]+"'
function psss -d 'pgrep process, used in script'
    ps -ef | rg -w -v rg | rg -i $argv[1] | nl
end
function pss -d 'pgrep process, used in command line'
    set -l options 'h'
    argparse -n pss $options -- $argv
    or return

    set -g PSS 'ps -e -o "user pid ppid pcpu pmem vsz rssize tty stat start time command" | rg -w -v rg'
    if set -q _flag_h
        eval $PSS | head -2
    else
        # ps aux | rg -w -v rg | rg -i $argv[1] | nl
        eval $PSS | rg -i $argv[1] | nl
        if test (eval $PSS | rg -i $argv[1] | nl | wc -l) = 1
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
        set -l __kp__pid (ps -ef | sed 1d | eval "fzf $FZF_DEFAULT_OPTS -m --header='[kill:process]'" | awk '{print $2}')
        set -l __kp__kc $argv[1]

        if test "x$__kp__pid" != "x"
            if test "x$argv[1]" != "x"
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
            if test "$arg" = "" -o "$arg" = "y" -o "$arg" = " "
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
                    if test "$arg2" = "y" -o "$arg2" = "a" -o "$arg2" = " "
                        set -l pids (psss $argv[1] | awk '{print $3}')
                        for i in $pids
                            if not kill -9 $i # failed to kill, $status != 0
                                psss $i | rg $argv[1]
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
                    else if test "$arg2" = "n"
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
                                if test $arg4 = "" -o "$arg4" = "y" -o "$arg4" = " "
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

function vars -d "list item in var line by line, all envs(by default), -m(MANPATH), -c(clean duplicated var), -p(PATH), var name(print value or var)"
    set -l options 'm' 'c' 'p'
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
        if test (echo $result_1 | rg "is a function with definition")
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
            # abbrc
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

zoxide init fish | source
alias zz 'zi'
set -gx _ZO_FZF_OPTS "-1 -0 --reverse --print0"
set -gx FZF_DEFAULT_OPTS '+s -e -m -0 --reverse --print0' # -m to mult-select using Tab/S-Tab, auto select the only match, auto exit if no match
set -gx FZF_TMUX_HEIGHT 100%

# touch temporary files
abbr tout 'touch ab~ .ab~ .\#ab .\#ab\# \#ab\# .ab.swp ab.swp'
# find
# alias find 'find -L' # make find follow symlink dir/file by default
function finds -d 'find a file/folder and view/edit using less/vim/emacs/emx/cd/readlink with fzf, find longest path(-L)'
    set -l options 'l' 'v' 'e' 'x' 'c' 'p' 'g' 'd' 'L'
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
    set -l options 'c' 'C' 'r' 'R' 'l'
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
            find $ARGV -maxdepth 1 \( -iname "*.$EXT" -o -iname "auto" \) | xargs -r rm -rv
        end
        fts -C
    else
        find $ARGV \( -iname "*~" -o -iname "#?*#" -o -iname ".#?*" -o -iname "*.swp*" \) | xargs -r ls -lhd | nl
    end

end
# NOTE: you need to mask updatedb.service and delete /var/lib/mlocate/mlocate.db file first
function loo -d 'locate functions, -u(update db) -a(undr /), -v(video), -m(audio), -d(dir), -o(open), -x(copy), -r(remove)'
    set -l options 'u' 'a' 'v' 'm' 'd' 'o' 'x' 'r'
    argparse -n loo $options -- $argv
    or return

    set -q $argv; and return

    set -l UPDATEDB 0
    set -l UPDATEDB_CMD "updatedb --require-visibility 0 -o /tmp/mlocate.db"
    set -l UPDATEDB_HOME 0
    set -l UPDATEDB_HOME_CMD "updatedb --require-visibility 0 -U /home/$USER -o /tmp/mlocate-home.db"

    if set -q _flag_a
        not test -f /tmp/mlocate.db; and set UPDATEDB 1
    else
        not test -f /tmp/mlocate-home.db; and set UPDATEDB_HOME 1
    end

    if set -q _flag_u
        set -q _flag_a; and set UPDATEDB 1; or set UPDATEDB_HOME 1
    end

    test $UPDATEDB -eq 1; and eval $UPDATEDB_CMD
    test $UPDATEDB_HOME -eq 1; and eval $UPDATEDB_HOME_CMD

    if set -q _flag_a # search file/dir in /
        set LOCATE 'locate -e -i -d /tmp/mlocate.db $argv'
    else if set -q _flag_v # search all video files in home
        set LOCATE 'locate -e -i -d /tmp/mlocate-home.db $argv | rg -ie ".mp4\$|.mkv\$|.avi\$|.webm\$|.mov\$|.rmvb\$"'
    else if set -q _flag_m # serach all audio files in home
        set LOCATE 'locate -e -i -d /tmp/mlocate-home.db $argv | rg -ie ".mp3\$|.flac\$|.ape\$|.wav\$|.w4a\$|.dsf\$|.dff\$"'
    else if set -q _flag_d
        set LOCATE 'locate -e -i -d /tmp/mlocate-home.db --null -b $argv | xargs -r0 sh -c \'for i do [ -d "$i" ] && printf "%s\n" "$i"; done\' sh {} + '
    else # search file/dir in home dir
        set LOCATE 'locate -e -i -d /tmp/mlocate-home.db $argv'
    end

    # if not found at the first time, maybe the db is not updated, update the db once
    if not eval $LOCATE ^/dev/null >/dev/null
        set -q _flag_a; and set UPDATEDB 1; or set UPDATEDB_HOME 1
        test $UPDATEDB -eq 1; and eval $UPDATEDB_CMD
        test $UPDATEDB_HOME -eq 1; and eval $UPDATEDB_HOME_CMD
    end

    if set -q _flag_o # open it using fzf
        # NOTE: the -0 + --print0 in fzf to be able to work with file/dir with spaces
        # -r in xargs is --no-run-if-empty
        eval $LOCATE | fzf | xargs -0 -r xdg-open
    else if set -q _flag_x # copy the result using fzf
        eval $LOCATE | fzf | xc && xc -o
    else if set -q _flag_r # remove it using fzf
        eval $LOCATE | fzf | xargs -0 -r rm -rfv
    else
        eval $LOCATE | rg -i $argv
    end

    # update db if -r(remove) option is given
    if set -q _flag_r
        set -q _flag_a; and eval $UPDATEDB_CMD; or eval $UPDATEDB_HOME_CMD
    end
end

# df+du+gdu/dua
function dfs -d 'df(-l, -L for full list), gua(-i), dua(-I), du(by default), cache/config dir of Firefox/Chrome/Vivaldi/yay/pacman'
    set -l options 'i' 'I' 'l' 'L' 'c' 'h'
    argparse -n dfs $options -- $argv
    or return

    if set -q _flag_i
        gdu $argv
    else if set -q _flag_I
        dua -f binary i $argv/* # NOTE: even if argv is empty, this works too
    else if set -q _flag_l
        # NOTE: if /tmp is out of space, use `sudo mount -o remount,size=20G,noatime /tmp` to temporally resize /tmp
        df -Th | rg -v -e 'rg|tmpfs|boot|var|snap|opt|tmp|srv|usr|user'
    else if set -q _flag_L
        df -Th
    else if set -q _flag_c
        dua -f binary a --no-sort ~/.cache/google-chrome ~/.config/google-chrome ~/.cache/vivaldi ~/.config/vivaldi ~/.cache/mozilla ~/.mozilla ~/.cache/yay /var/cache/pacman/pkg
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
        mdcat $argv | less
    else if command -sq pandoc; and command -sq lynx
        pandoc $argv | lynx --stdin
    else
        echo "Please make sure pandoc+lynx or mdcat are installed!"
    end
end

# TODO: pip install cppman; cppman -c # it will take a while
abbr manp 'cppman'

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
        find $argv
        echo -e "\n...tree is not installed, use find instead..."
    end
end

# j for .bz2, z for .gz, J for xz, a for auto determine
function tars -d 'tar extract(x)/list(l, by default)/create(c, add extra arg to exclude .git dir), fastest(C, add extra arg to exclude .git)or others using extr(o)'
    set -l options 'x' 'l' 'c' 'C' 'o'
    argparse -n tars $options -- $argv
    or return

    # remove the end slash in argv[1] if it is a directory
    test -d $argv[1]; and set ARGV (echo $argv[1] | sed 's:/*$::')

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
        if set -q _flag_l # list
            if command -sq lsar
                lsar $a
            else
                unzip -l $a
            end
        else if set -q _flag_L # list Chinese characters
            zips.py -l $a
        else if set -q _flag_x
            if command -sq unar
                unar $a
            else
                unzip $a
            end
        else if set -q _flag_X # extract Chinese characters
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

    if set -q _flag_x # extract
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
    else # default, list
        dpkg -c $argv
    end
end

# rpm
function rpms -d 'rpm file, install(i)/extract(x)/list(default)'
    set -l options 'i' 'x'
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
# NOTE: yay: generate ~/.confif/yay/config.json
test -f ~/.config/yay/config.json; or yay --sudoloop --aururl "https://aur.tuna.tsinghua.edu.cn" --combinedupgrade --save
#
alias pacr 'yay -Rsun' # remove a package and its unneeded dependencies, and clean configs
alias pacrr 'yay -Rsc' # using this if pacr doesn't not uninstall a pacakge
abbr pacrc 'yay -Rsu' # like pacr, but don't clean configs
abbr pacrd 'yay -Rscn' # do not remove dependencies and their configs
abbr pacd 'sudo pacman -Sw' # download package without installing
abbr pacc 'sudo pacman -Sc --noconfirm' # clean packages cache
abbr pacC 'paccache -rvk2 --noconfirm' # remove old package cache files is to remove all packages except for the latest 2 package versions
abbr pacu 'yay -Syu' # update the database and update the system, pacman only updates from repo, yay updates from both repo and aur
abbr pacuu 'yay -Syyu' # force a full refresh of database and update the system, must do this when switching branches/mirrors
abbr pacud 'yay -Syuu' # like pacu, but allow downgrade, needed when switch to old branch like testing->stable or you seen local xxx is newer than xxx
abbr paco 'yay -Qdt --color=always' # To list all orphans, installed packages that are not used by anything else and should no longer be needed
abbr pacor 'yay -Rsun (yay -Qdtq)' # remove package and its configs in paco
function paci -d 'pacman/yay install function, -y(noconfirm), -u(update first), -r(reinstall), -l(local install), -i(interactive)'
    set -l options 'y' 'u' 'r' 'l' 'i'
    argparse -n paci $options -- $argv
    or return

    set -q _flag_i; and proxychains4 -q pacui i $argv && return # install package interactively using pacui
    set -q _flag_l; and yay -U $argv && return # install package from a local .pkg.tar.xz/link file

    # -S to install a package, -Syu pkg to ensure the system is update to date then install the package
    set -q _flag_u; and set OPT $OPT -Syu; or set OPT $OPT -S

    set -q _flag_y; and set OPT $OPT --noconfirm # noconfirm, without asking for y/n
    set -q _flag_r; and set OPT $OPT; or set OPT $OPT --needed

    eval yay $OPT $argv
end
function pacs -d 'pacman/yay search, -i(interactive using pacui), -n(only names), -L(list content), -g(list packages in a group), -s(show info)'
    set -l options 'a' 'i' 'n' 'l' 'L' 'g' 's'
    argparse -n pacs $options -- $argv
    or return

    if set -q _flag_i # interactively search using pacui i
        proxychains4 -q pacui i $argv
        return
    end

    if set -q _flag_g # list packages in a groupadd
        # available groups(not all) and their packages: https://archlinux.org/groups/
        if set -q _flag_l # list all installed groups and packages
            yay -Qg
        else
            yay -Sg $argv
        end
        return
    end

    if set -q _flag_s
        if ! set -q $argv # given $argv
            for file in $argv
                if set -q _flag_l # get URL info and send it to clipper
                    if set -q _flag_a # get AUR URL info and send it to clipper
                        yay -Si $file | rg "AUR URL" | awk '{print $4}' | xc && xc -o
                    else
                        if yay -Q $file ^/dev/null >/dev/null
                            yay -Qi $file | rg "^URL" | awk '{print $3}' | xc && xc -o
                        else
                            yay -Si $file | rg "^URL" | awk '{print $3}' | xc && xc -o
                        end
                    end
                    open (xc -o) ^/dev/null >/dev/null
                else
                    yay -Qi $file
                    or yay -Si $file
                end
            end
        else
            # without args, it will print info of all the intalled packages
            echo "Need argv[s]!"
        end
        return
    end

    if set -q _flag_l # list installed pcakges containing the keyword(including description)
        if set -q _flag_L # list installed packages by size
            pacui ls
        else if set -q _flag_a # list packages installed from AUR
            pacui la
        else
            yay -Qs --color=always $argv
        end
        return
    end

    if set -q _flag_L # list content in a pacakge
        pacman -Ql $argv
        or pamac list --files $argv
        return
    end

    set -q _flag_a; and set CMD yay; or set CMD pacman
    if set -q _flag_n # search only in package names
        eval $CMD -Slq | sort | rg $argv
        # if failed with pacman, using yay directly (yay including aur is slow)
        or yay -Slq | rg $argv
        return
    end
    # if failed with pacman, using yay directly (yay including aur is slow)
    eval $CMD -Ss --color=always $argv; or yay -Ss --color=always $argv
end
function pacms -d 'pacman-mirrors functions, default(China), -f(fastest 5), -s(status), -i(interactive), -r(reflector)'
    set -l options 'f' 's' 'i' 'r'
    argparse -n pacms $options -- $argv
    or return

    if set -q _flag_f
        sudo pacman-mirrors -f 3
    else if set -q _flag_s
        pacman-mirrors --status
    else if set -q _flag_i
        sudo pacman-mirrors -i -d
    else if set -q _flag_r
        set -q $argv; and set ARGV China; or set ARGV $argv
        sudo reflector --country $ARGV --verbose --latest 6 --sort rate --save /etc/pacman.d/mirrorlist
    else
        if ! set -q $argv[1] # given arguments
            sudo pacman-mirrors -c $argv
        else
            sudo pacman-mirrors -c China
        end
    end
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
abbr yayu 'yay -Syu' # yay == yay -Syu
abbr yayr 'yay -Rsun'
# check yay --help for more
# pacui, depending on yay, install it first
abbr pacf 'proxychains4 -q pacui i'
# check pacui h/help for more

# donnot show the other info on startup
abbr gdbi 'gdb -q -x ~/Dotfiles.d/gdb/.gdbinit'
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
    gdb -q -x ~/Dotfiles.d/gdb/.gdbinit -ex "dashboard source -output $tty" "$argv"
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
abbr gcca 'gcc -g -pedantic -Wall -W -Wconversion -Wshadow -Wcast-qual -Wwrite-strings -Wmissing-prototypes  -Wno-sign-compare -Wno-unused-parameter'
# gcc -Wall -W -Wextra -Wconversion -Wshadow -Wcast-qual -Wwrite-strings -Werror
function mkk -d "gcc, g++, cmake and make"
    # gcc/g++ for simple C/Cpp file
    if ! set -q $argv[1] # given arguments
        set -l DIR (dirname $argv)
        set -l BIN (string split -r -m1 . (basename $argv))[1] # get the binary name
        set -l EXT (string split -r -m1 . (basename $argv))[2] # get the extension name
        if ! set -q $EXT # extension is not empty, argv is c/cpp file
            if test $EXT = "cpp" -o $EXT = "cc"
                g++ -Wall -W -g $argv -o $DIR/$BIN && $DIR/$BIN
                return
            else if test $EXT = "c"
                gcc -Wall -W -g $argv -o $DIR/$BIN && $DIR/$BIN
                return
            end
        end
    end

    if test -f ../CMakeLists.txt # inside build dir
        if not set -q $argv
            make -q $argv
            # if make pass or make error, status=1
            # if no given target, status=2
            if test $status = 1; or cmake ..
                make $argv; and ./$argv
            end
        else
            cmake ..; and make
        end
    else if test -f ./Makefile -o -f makefile # not cmake
        make
    else if test -f ./CMakeLists.txt # no build dir
        not test -d build; and mkdir build
        cd build && cmake .. && make
        not set -q $argv; and ./$argv
    else
        echo "No CMakeLists.txt or not inside build or no Makefile/makefile..."
    end
end
# static code analyzer, another tool is from clang-analyzer which is scan-build
# https://clang-analyzer.llvm.org/scan-build.html
# https://clang.llvm.org/extra/clang-tidy/
# scan-build make or scan-build gcc file.c or clang --analyze file.c or clang-tidy file.c
abbr cppc 'cppcheck --enable=all --inconclusive'

function o -d 'open file or directory'
    set -q $argv; and set ARGV .; or set ARGV $argv

    open $ARGV ^/dev/null >/dev/null
end

function fmts -d "compile_commands.json(-l), clang-format(-f), cmake-format(-m)"
    set -l options 'f' 'l' 'm'
    argparse -n fmts $options -- $argv
    or return

    if set -q _flag_l
        # test -f build/compile_commands.json; and command rm -rf build
        # test -f compile_commands.json; and command rm -rf compile_commands.json

        # generate compile_commands.json file for C/C++ files used by ccls/lsp
        if test -f CMakeLists.txt
            cmake -H. -B build -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=YES
            if test $status != 0 -o ! -f build/compile_commands.json
                echo -e "\nGenerating build/compile_commands.json failed!!!"
            else if ! ln -nsfv build/compile_commands.json
                # if ln fails(failed, such as Linux->Windows), cp directly
                command cp -v build/compile_commands.json .
            end
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
    if file $argv[1] | rg -i "ISO" ^/dev/null >/dev/null
        if echo $argv[2] | rg -i "dev" ^/dev/null >/dev/null
            set FILE (readlink -f $argv[1])
            set DEV $argv[2]
            lsblk -l
            echo
            set CMD "sudo dd if=$FILE of=$DEV bs=4M status=progress oflag=sync"
            echo $CMD
            read -n 1 -l -p 'echo "Really run above command? [Y/n]"' answer
            if test "$answer" = "y" -o "$answer" = "" -o "$answer" = ""
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
    set -l options 'u' 'e' 'd' 'D' 'm' 'M' 'r' 's' 'S' 'l' 'R' 'f' 'c' 'p' 'L' 't' 'h'
    argparse -n syss $options -- $argv
    or return

    if set -q _flag_h; and ! set -q _flag_c
        echo "syss [-u/-e/-d/-D/-m/-M/-r/-s/-S/-l/-R/-f/-c -s/-c -h/-c -S/-c -r/-c -p/-L/-t/-h]"
        echo "     --> check all the services of the user if no argv, argv for the argv.service"
        echo "     -u --> current user or using default sudo"
        echo "     -e --> systemctl enable name.service"
        echo "     -d --> systemctl disable name.service"
        echo "     -D --> systemctl reenable name.service"
        echo "     -m --> systemctl mask name.service"
        echo "     -M --> systemctl unmask name.service"
        echo "     -r --> systemctl restart name.service"
        echo "     -s --> systemctl start name.service"
        echo "     -S --> systemctl stop name.service"
        echo "     -l --> systemctl list-units --type service --all, arg to search"
        echo "     -R --> systemctl daemon-reload"
        echo "     -f --> systemctl --failed"
        echo "     -c -s --> suspend"
        echo "     -c -h --> hibernate"
        echo "     -c -S --> hibernate-sleep"
        echo "     -c -r --> reboot"
        echo "     -c -p --> poweroff/shutdown"
        echo "     -L --> journalctrl -xe, the log"
        echo "     -t --> systemd-analyze for boo time analyze, any argv for saving to file and view"
        echo "     -h --> print this usage message"
        return
    end

    if set -q _flag_c
        if set -q _flag_s
            systemctl suspend
        else if set -q _flag_h
            systemctl hibernate
        else if set -q _flag_S
            systemctl hybrid-sleep
        else if set -q _flag_r
            # or simplily `reboot`
            systemctl reboot
        else if set -q _flag_p
            # or simplily `poweroff`
            systemctl poweroff
        else
            syss -h
        end
        return
    end

    if set -q _flag_t # list the boot time of all services
        if set -q $argv # no given argv
            systemd-analyze blame | head -40
            systemd-analyze time
        else
            # more verbose version:
            systemd-analyze blame >boottime
            systemd-analyze time >>boottime
            systemd-analyze plot >>boottime.svg
            echo "file: ./boottime + ./boottime.svg"
            # open boottime.svg, display is from imagemagick
            display boottime.svg
        end
        return
    end

    set -q _flag_L; and journalctl -xe && return
    set -q _flag_R; and sudo systemctl daemon-reload && return
    set -q _flag_f; and systemctl --failed && return

    set -q _flag_u; and set PRI systemctl --user; or set PRI systemctl

    set CMD status # default action: status
    set -q _flag_e; and set CMD enable
    set -q _flag_d; and set CMD disable
    set -q _flag_D; and set CMD reenable
    set -q _flag_m; and set CMD mask
    set -q _flag_M; and set CMD unmask
    set -q _flag_R; and set CMD reenable
    set -q _flag_s; and set CMD start
    set -q _flag_r; and set CMD restart
    set -q _flag_S; and set CMD stop

    if set -q _flag_l
        set CMD list-units --type service --all
        if set -q $argv # no given argv
            eval $PRI $CMD
        else
            systemctl list-units --type service --all | rg $argv
            or systemctl --user list-units --type service --all | rg $argv
        end
        return
    end

    # without argv and opt, show all the status of services under user
    eval $PRI $CMD $argv
end

# cd
function ..
    cd ..
end
function ...
    cd ../..
end
function ....
    cd ../../..
end
function .....
    cd ../../../..
end
abbr cdp 'cd ~/Public; and lls'

function diffs -d "all kinds of diff features"
    if command -sq ydiff
        diff -u $argv | ydiff -s -w 0 --wrap
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
abbr xp 'xclip'

#vim
set -gx EDITOR 'vim'
function vis -d 'vim different targets'
    set -l options '2' 'b' 'B' 'c' 'd' 'e' 'f' 't' 'T' 'a' 'k' 's' 'u' 'm' 'M' 'v' 'o' 'r'
    argparse -n vis $options -- $argv
    or return

    if set -q _flag_2
        vim ~/Dotfiles.d/todo.org
    else if set -q _flag_b
        vim ~/.bashrc
    else if set -q _flag_B
        vim ~/.bash_aliases
    else if set -q _flag_d # vim diff
        if test -f $argv[1]
            vim -d -o $argv[1] $argv[2]
        else if test -d $argv[1]
            vim -c "DirDiff $argv[1] $argv[2]"
        end
    else if set -q _flag_c
        vim ~/Dotfiles.d/spacemacs/.spacemacs.d/lisp/clang-format-c-cpp
    else if set -q _flag_e
        vim $EMACS_EL
    else if set -q _flag_f
        vim $FISHRC
    else if set -q _flag_t
        vim ~/.tmux.conf
        tmux source-file ~/.tmux.conf
        echo ~/.tmux.conf reloaded!
    else if set -q _flag_T
        vim ~/.tigrc
    else if set -q _flag_a
        vim ~/.config/alacritty/alacritty.yml
    else if set -q _flag_k
        vim ~/.config/kitty/kitty.conf
    else if set -q _flag_s
        vim ~/.config/sxhkd/sxhkdrc
    else if set -q _flag_u
        vim -u NONE $argv
    else if set -q _flag_m
        vim -u ~/Dotfiles.d/vim/vimrc.more $argv
    else if set -q _flag_M
        vim ~/Dotfiles.d/spacemacs/.spacemacs.d/lisp/cmake-format.json
    else if set -q _flag_v
        vim ~/.spacevim
    else if set -q _flag_o
        vim ~/Dotfiles.d/vim/.vimrc
    else if set -q _flag_r # replace `sudo vim`
        # can also use `sudoedit`, they will be local vim config + sudo vim
        sudo -e $argv
    else
        vim $argv
    end
end
function vims -d 'switch between vanilla vim(-v) <-> SpaceVim or space-vim(the default)'
    set -l options 'v'
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
            if test "$answer" = "1"
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
            if test "$answer" = "y" -o "$answer" = " "
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

    if test -d /home/test # directory exists
        sudo su -s /bin/bash - test
    else
        sudo useradd -m -e (date -d "1 days" +"%Y-%m-%d") test -s /sbin/nologin
        sudo su -s /bin/bash - test
    end
end

# git
abbr gg 'lazygit'
abbr ggl 'git log'
abbr gglp 'git log -p --'
abbr ggs 'git status'
abbr gits 'git status'
abbr gitl 'git log'
abbr gitlo 'git log --oneline'
abbr gitlp 'git log -p --' # [+ file] to how entire all/[file(even renamed)] history
abbr gitls 'git diff --name-only --cached' # list staged files to be commited
abbr gitd 'ydiff' # show unstaged modification
abbr ggd 'ydiff' # show unstaged modification
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
abbr gitup 'git log origin/master..HEAD' # list unpushed commits
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
function gitcl -d 'git clone and cd into it, full-clone(by default), simple-clone(-s)'
    set -l options 's'
    argparse -n gitcl $options -- $argv
    or return

    # https://stackoverflow.com/questions/57335936
    if set -q _flag_s
        set DEPTH "--depth=1 --no-single-branch"
        echo "Use 'git pull --unshallow' to pull all info."
    else
        set DEPTH
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
        cd $i
        cd ../
        pwd
        git pull
        echo -----------------------------
        echo
    end
end
function gitbs -d 'branches, tags and worktrees'
    set -l options 'c' 'd' 'f' 'l' 't' 'T' 'w' 'v' 'h'
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
function sss -d 'count lines of code from a local code dir or a github url'
    if echo $argv | rg "https://github.com" ^/dev/null >/dev/null
        # or use website directly: https://codetabs.com/count-loc/count-loc-online.html
        set -l username_repo (echo $argv | cut -c20-)
        curl "https://api.codetabs.com/v1/loc/?github=$username_repo" | jq -r '(["Files", "Lines", "Blanks", "Comments", "LinesOfCode", "Language"] | (., map(length*"-"))), (.[] | [.files, .lines, .blanks, .comments, .linesOfCode, .language]) | @tsv' | column -t
    else
        scc -c --no-cocomo $argv
    end
end
abbr gitsc "sss"
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
    git remote -v | rg "upstream" ^/dev/null >/dev/null
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

# docker related
abbr docksi 'docker search' # search a image
abbr dockp 'docker pull' # pull image +name:tag
# create container example:
# docker run -it -v ~/Public/tig:/Public/tig -net host --name new_name ubuntu:xenial /bin/bash
abbr dockrun 'docker run -it' # create a container
abbr dockr 'docker rm' # remove container +ID
abbr dockri 'docker rmi' # remove image +repo
abbr dockl 'docker ps -a' # list all created containers
abbr dockli 'docker image ls' # list all pulled images
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
    wget -q https://registry.hub.docker.com/v1/repositories/$argv[1]/tags -O - | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n' | awk -F: '{print $3}'
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

if test (ps -ef | rg -w -v rg | rg -e 'shadowsocks|v2ray' | wc -l) != 0 # ssr/v2ray is running
    set -g PXY 'proxychains4 -q'
else
    set -g PXY
end

abbr bb 'bat'

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
        # pip search $argv
        # if `pip search` fails, then `sudo pip install pip_search` first
        pip_search search $argv
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
alias q 'x'
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

# abbr rea 'sudo $LBIN/reaver -i mon0 -b $argv[1] -vv'
# function rea
# sudo $LBIN/reaver -i mon0 -b $argv
# end

abbr epub 'ebook-viewer --detach'
# alias time 'time -p'

function ssh -d 'show ssh info for current tmux window'
    if set -q TMUX
        # you can see this new name in choose-tree list
        tmux rename-window "ssh $argv"
        command ssh "$argv"
    else
        command ssh "$argv"
    end
end

# abbr sss 'ps -eo tty,command | rg -v rg | rg "sudo ssh "'
abbr p 'ping -c 5'
function ipl -d 'get the location of your public IP address'
    eval $PXY curl myip.ipip.net
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
function ios -d 'io stat'
    # check the current io speed, using command like
    # `dstat -d -n`
    if set -q argv[1]
        sudo hdparm -Tt $argv # $argv is device like /dev/sda1
    else
        dstat -d -n -m -s -c --nocolor
    end
end

abbr pxx 'proxychains4 -q'
function pxs -d 'multiple commands using proxychains4'
    set -l options 'w' 'c' 'p'
    argparse -n pxs $options -- $argv
    or return

    # two conditions, one or another
    if test (echo $argv | rg github); or set -q _flag_p
        set CMD $PXY
    else
        set CMD
    end

    if set -q _flag_w
        eval $CMD wget -c --no-check-certificate $argv
    else if set -q _flag_c
        eval $CMD curl -L -O -C - $argv
    else # default using aria2
        eval $CMD aria2c -c -x 5 --check-certificate=false --file-allocation=none $argv
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

alias dic 'trans :zh -d -show-dictionary Y -v'
function deff -d 'find definition in dictionary'
    echo "-1\n" | sdcv $argv | head -n 1 | rg ", similar to " ^/dev/null >/dev/null
    if test $status = 0 # Found exact words or similar
        echo "-1\n" | sdcv $argv | head -n 2 | tail -n 1 | rg "^-->" ^/dev/null >/dev/null
        if test $status = 0 # Exact definition
            sdcv $argv
        else # similar
            echo "-1\n" | sdcv $argv | head -n 1 | rg $argv
            # 1th, send -1 to prompt; 3th, delete last line; 4th, delete first line;
            # 5th, get last part after ">"; 5th & 6th, delete duplicates;
            # 7th, combine and separate multiple lines (words) with ", "
            # 8th, delete last ", "
            echo "-1\n" | sdcv $argv | head -n -1 | tail -n +2 | cut -d ">" -f 2 | sort | uniq | awk 'ORS=", "' | sed 's/, $/\n/'
        end
    else # Nothing similar
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
    rg -w $argv ~/.sdcv_history >>/dev/null
    if test $status != 0 # new, not searched the dict before, save
        if not test -e ~/.sdcv_rem
            touch ~/.sdcv_rem
        end
        echo ---------------------------------------------- >>~/.sdcv_rem
        echo -e \< $argv \> >>~/.sdcv_rem
        echo ---------------------------------------------- >>~/.sdcv_rem
        SDCV $argv >>~/.sdcv_rem
        echo ---------------------------------------------- >>~/.sdcv_rem
        echo >>~/.sdcv_rem
    end
end
function defc --description 'search the defnition of a word and save it into personal dict if it is the first time you search'
    echo "-1\n" | SDCV $argv | head -n 1 | rg ", similar to " ^/dev/null >/dev/null
    if test $status = 0 # Found exact words or similar
        echo "-1\n" | SDCV $argv | head -n 2 | tail -n 1 | rg "^-->" ^/dev/null >/dev/null
        if test $status = 0 # Exact definition
            SDCV $argv
            defc_new $argv
        else # similar
            echo "-1\n" | SDCV $argv | head -n 1 | rg $argv
            echo "-1\n" | SDCV $argv | head -n -1 | tail -n +2 | cut -d ">" -f 2 | sort | uniq | awk 'ORS=", "' | sed 's/, $/\n/'
            sed -i "/\<$argv\>/d" ~/.sdcv_history # delete the wrong word in ~/.sdcv_history
        end
    else # Nothing similar
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
        echo "\"$argv[2]" >>~/.lesshst
    else
        #sed -i "s/.shell/\"$argv[1]\n.shell/g" ~/.lesshst
        echo "\"$argv[1]" >>~/.lesshst
    end
    command man $argv
end

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
    else # ()=0
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
            sudo pkill dhclient # this has no effect on the network, just make next usbt quicker
        end
    end
end

abbr um 'pumount /run/media/chz/UDISK'
abbr mo 'pmount /dev/sdb4 /run/media/chz/UDISK'
function mo-bak
    set -l done 1
    while test $done = 1
        if not command df | rg -w -v rg | rg -i UDISK ^/dev/null >/dev/null # no UDISK in df, new or unplug
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
        else # UDISK is in df, right or not-umount old
            set -l device (command df | rg -w -v rg | rg -i UDISK | awk '{print $1}')
            if not test -b $device
                if not pumount /media/UDISK ^/dev/null >/dev/null
                    echo $device -- /media/UDISK is busy.
                    lsof | rg UDISK
                    return
                end
            else # right
                echo Device /dev/sdb4 is already mounted to /media/UDISK
                return
            end
        end
    end
end

# interactively(choose format and resolution) stream video using mpv+youtube-dl+fzf
# https://github.com/seanbreckenridge/mpvf/
alias mpvs 'proxychains4 -q mpvf'
function yous -d 'youtube-dl functions'
    set -l options 'l' 'a' 'f' 'p' 'P'
    argparse -n yous -N 1 $options -- $argv
    or return

    if set -q _flag_l # list all formats
        eval $PXY youtube-dl -F \"$argv\"
    else if set -q _flag_f # choose the num from the list
        eval $PXY youtube-dl -f $argv[1] \"$argv[2]\"
    else if set -q _flag_a # only download best audio into mp3
        eval $PXY youtube-dl -ciw --extract-audio --audio-format mp3 --audio-quality 0 \"$argv\"
    else if set -q _flag_p # download playlist
        eval $PXY youtube-dl --download-archive downloaded.txt --no-overwrites -ict --yes-playlist --socket-timeout 5 \"$argv\"
    else if set -q _flag_P # download playlist into audio
        eval $PXY youtube-dl --download-archive downloaded.txt --no-overwrites -ict --yes-playlist --extract-audio --audio-format mp3 --audio-quality 0 --socket-timeout 5 \"$argv\"
    else # download video
        eval $PXY youtube-dl -ciw \"$argv\"
    end
end

function rgs -d 'rg sth in -e(init.el)/-E(errno)/-f(config.fish)/-t(.tmux.conf)/-v(vimrc), or use -F(fzf) to open the file, -g(git repo), -w(whole word), -V(exclude pattern), -l(list files), -s(sort), -n(no ignore), -S(smart case, otherwise ignore case), -2(todo.org)'
    # NOTE -V require an argument, so put "V=" line for argparse
    set -l options 'e' 'E' 'f' 't' 'v' 'F' 'g' 'n' 'w' 'V=' 'l' 's' 'S' '2'
    argparse -n rgs -N 1 $options -- $argv
    or return

    set OPT "--hidden"
    set -q _flag_w; and set OPT $OPT "-w"
    set -q _flag_l; and set OPT $OPT "-l"
    # and $_flag_V is the argument for for -V
    set -q _flag_V; and set OPT $OPT -g !$_flag_V
    set -q _flag_s; and set OPT $OPT --sort path
    set -q _flag_n; and set OPT $OPT --no-ignore
    set -q _flag_S; and set OPT $OPT -s; or set OPT $OPT -i

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
        if test "$answer" = "y" -o "$answer" = " "
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

# this function is a copy of _halostatue_fish_fzf_cdhist_widget function
# from https://github.com/halostatue/fish-fzf/blob/master/conf.d/halostatue_fish_fzf.fish
# to replace the original d function which is now d2 function
function d -d 'cd to one of the previously visited locations'
    # Clear non-existent folders from cdhist.
    set -l buf
    for i in (seq 1 (count $dirprev))
        set -l dir $dirprev[$i]
        if test -d $dir
            set buf $buf $dir
        end
    end

    set dirprev $buf
    string join \n $dirprev | tail | sed 1d | \
        eval (__fzfcmd) +m --tiebreak=index --toggle-sort=ctrl-r $FZF_CDHIST_OPTS | \
        read -l result

    test -z $result
    or cd $result

    commandline -f repaint
end

# this function is deprecated, use d instead
function d2 --description "Choose one from the list of recently visited dirs"
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
            if conda env list | awk '{ print $1 }' | rg -w $argv[1] >/dev/null ^/dev/null
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
    else # no option, switch env or pip install based on base env
        if set -q $argv # no argv
            conda env list
            read -p 'echo "Which conda env switching to: [base?] "' argv
        end
        if conda env list | awk '{ print $1 }' | rg -w $argv[1] >/dev/null ^/dev/null
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
