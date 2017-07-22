# ~/.fishrc linked to ~/.config/fish/config.fish
### you can use `fish_config` to config a lot of things in WYSIWYG way in browser

set -gx GOPATH $GOPATH ~/GoPro
# set -gx PATH $HOME/anaconda3/bin ~/.local/share/arm-linux/bin ~/.local/bin ~/.linuxbrew/bin $GOPATH/bin ~/bin $PATH
set -gx PATH $HOME/anaconda3/bin $HOME/.local/bin $GOPATH/bin /usr/local/bin /usr/local/liteide/bin /bin /sbin /usr/bin /usr/sbin $PATH


# for ~/.linuxbrew/ (brew for linux to install programs)
set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH ~/.linuxbrew/Library

# do not use the format above
# http://vivafan.com/2013/03/%E3%80%8Cfish%E3%80%8D%E3%82%B7%E3%82%A7%E3%83%AB%E3%82%92%E5%AE%9F%E9%9A%9B%E3%81%AB%E4%BD%BF%E3%81%86%E3%81%9F%E3%82%81%E3%81%AB/
# for more formats

# remove the greeting message
set fish_greeting

set -gx fish_color_user magenta
set -gx fish_color_host yellow

if test -f $HOME/.autojump/share/autojump/autojump.fish;
    . $HOME/.autojump/share/autojump/autojump.fish;
    alias js 'j --purge; j -s'
end

. $HOME/.config/fish/functions/done.fish

# LS_COLORS, color for ls command
# http://linux-sxs.org/housekeeping/lscolors.html
# http://www.bigsoft.co.uk/blog/index.php/2008/04/11/configuring-ls_colors
set -gx LS_COLORS 'ex=01;33:ln=96:*~=90:*.swp=90:*.bak=90:*.o=90:*#=90'

# fix the `^[]0;fish  /home/chz^G` message in shell of Emacs
if test "$TERM" = "dumb"
    function fish_title
    end
end

function dirp --on-event fish_preexec
    set -g OLDPWD $PWD
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
    bind \cl "tput reset; commandline -f repaint; path_prompt"
    bind \cd delete-or-ranger
end
alias clr="echo -e '\033c\c'; path_prompt"

alias rg 'ranger'
alias fpp '~/Public/PathPicker/fpp'
alias ga 'glances -t 1 --hide-kernel-threads -b --disable-irq --enable-process-extended'
alias dst 'dstat -d -n'

# make the make and gcc/g++ color
function make
    /usr/bin/make -B $argv 2>&1 | grep --color -iP "\^|warning:|error:|undefined|"
end
function gcc
    /usr/bin/gcc $argv 2>&1 | grep --color -iP "\^|warning:|error:|undefined|"
end
function g++
    /usr/bin/g++ $argv 2>&1 | grep --color -iP "\^|warning:|error:|Undefined|"
end

function path_prompt
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
    set_color -o yellow
    echo -n (prompt_pwd)
    set_color normal
    echo
end
function fish_prompt --description 'Write out the prompt'
    h
    set -l last_status $status

    # if the PWD is not the same as the PWD of previous prompt, print path part
    if test "$OLDPWD" != "$PWD"
        path_prompt
    end

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
    echo ' '
end
function measure_time
    # from joker plugin https://github.com/fisherman/joker
    if test "$CMD_DURATION" -gt 1000 # 1s
        set -l duration_copy $CMD_DURATION
        set -l duration (echo $CMD_DURATION | humanize_duration)
        printf (set_color red)"($duration)"(set_color normal)
    end
end
function fish_right_prompt -d "Write out the right prompt"
    # set_color -o black
    measure_time
    set_color normal
    echo -n '['
    echo -n (date +%T)
    echo -n ']'

    __informative_git_prompt
    set_color $fish_color_normal
end
###################################################################

set fish_new_pager 1


# User specific aliases and functions
alias sl 'ls'
alias l 'ls'
alias ls 'ls --color=always'
alias lsd 'ls -d */' # only list unhidden directories
alias ll 'ls -lh'
alias la 'ls -d .*' # only list the hidden dirs
alias lla 'ls -lhA' # list all but not . ..
alias ls. 'ls -A'
alias lsf 'ls -A1' # list only filenames, same as `ls -A | sort
alias lsl 'ls -1' # list the names of content line by line without attributes
alias lsL 'ls -A1' # like lsl but including hiddens ones (no . or ..)
function lsx --description 'cp the full path of a file to sytem clipboard'
    readlink -nf $argv | x
    x -o
    echo \n---- Path Copied to Clipboard! ----
end
function lst
    ls --color=yes $argv[1] --sort=time -lh | nl -v 0| less
end
function lsh
    ls --color=yes $argv[1] --sort=time -lh | head | nl -v 0
end
function lsh2
    ls --color=yes $argv[1] --sort=time -lh | head -20 | nl -v 0
end
function lls
    ll --color=yes $argv --sort=size -lh | less -R | nl -v 0
end
function llh
    ll --color=yes $argv --sort=time -lh | head | nl -v 0
end
alias llt 'lla --color=yes --sort=time -lh | less -R | nl -v 0'
alias lat 'lla --color=yes --sort=time -lh | less -R | nl -v 0'
alias lah 'lla --color=yes --sort=time -lh | head | nl -v 0'
# count the number of the files in the dir(not sub.), use tree | wc -l for subdirs
alias lsc 'ls -all | wc -l'
# valgrind
# alias va='valgrind -v --track-origins=yes'
alias va 'valgrind --track-origins=yes --leak-check=full '
# more detail about time
alias vad 'valgrind --tool=callgrind --dump-instr=yes --simulate-cache=yes --collect-jumps=yes '

alias im 'ristretto'
alias ds 'display'

alias ka 'killall -9'
# If Emacs hangs and won't response to C-g, use this to force it to stop whatever it's doing
# Note that do not use this if you got more than one instances of Emacs running
# Use `pkill -SIGUSR2 PID` to kill the PID, send SIGUSR2 to emacs will turn on `toggle-debug-on-quit`, turn it off once emacs is alive again
alias ke 'pkill -SIGUSR2 emacs'
# get the pid of a gui program using mouse
alias pid 'xprop | grep -i pid | grep -Po "[0-9]+"'
function psg -d 'pgrep process'
    ps -ef | grep -v grep | grep -i $argv[1] | nl
end
# pkill will not kill processes matching pattern, you have to kill the PID
function pk --description 'kill processes containg a pattern'
    set result (psg $argv[1] | wc -l)
    if test $result = 0
        echo "No '$argv[1]' process is running!"
    else if test $result = 1
        set -l pid (psg $argv[1] | awk '{print $3}')
        kill -9 $pid
        if test $status != 0 # Operation not permitted
            psg $pid | ag $argv[1] # list the details of the process need to be sudo kill
            read -p 'echo "Use sudo to kill it? [Y/n]: "' -l arg
            if test "$arg" = "" -o "$arg" = "y" -o "$arg" = " "
                sudo kill -9 $pid
            end
        end
    else
        while test 1
            psg $argv[1]
            if test (psg $argv[1] | wc -l) = 0
                return
            end
            read -p 'echo "Kill all of them or specific PID? [y/N/index/pid/m_ouse]: "' -l arg2
            if test "$arg2" = "y" -o "$arg2" = " "
                set -l pids (psg $argv[1] | awk '{print $3}')
                for i in $pids
                    kill -9 $i
                    if test $status != 0 # Operation not permitted
                        psg $i | ag $argv[1]
                        read -p 'echo "Use sudo to kill it? [Y/n]: "' -l arg3
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
                # kill -usr2 (xprop | grep -i pid | grep -Po "[0-9]+")
                # kill -SIGUSR2 (xprop | grep -i pid | grep -Po "[0-9]+")
                set -l pid_m (xprop | grep -i pid | grep -Po "[0-9]+")
                if test (psg $pid_m | grep -i emacs)
                    kill -SIGUSR2 $pid_m
                else
                    kill -9 $pid_m
                end
                echo Pid is: $pid_m
                return
            else if test "$arg2" -a "$arg2" -lt 20 # index
                # the fist cond in test means you typed something, RET will not pass
                set -l pid_of_index (psg $argv[1] | awk 'NR == n' n=$arg2 | awk '{print $3}')
                kill -9 $pid_of_index
                if test $status != 0 # kill failed
                    psg $pid_of_index | ag $argv[1] # list the details of the process need to be sudo kill
                    read -p 'echo "Use sudo to kill it? [Y/n]: "' -l arg4
                    if test $arg4 = "" -o "$arg4" = "y" -o "$arg4" = " "
                        # the first condition is to check RET key
                        sudo kill -9 $pid_of_index
                    end
                end
            else if test $arg2 -a "$arg2" != "y" -a "$arg2" != "n" # pid
                # the fist cond in test means you typed something, RET will not pass
                if test (psg $argv[1] | awk '{print $3}' | grep -i $arg2)
                    kill -9 $arg2
                    if test $status -eq 1 # kill failed
                        psg $arg2 | ag $argv[1] # list the details of the process need to be sudo kill
                        read -p 'echo "Use sudo to kill it? [Y/n]: "' -l arg5
                        if test $arg5 = "" -o "$arg5" = "y" -o "$arg5" = " "
                            sudo kill -9 $arg2
                        end
                    end
                else
                    echo "PID or index '$arg2' is not in the list!"
                    echo
                end
            else
                # RET goes here, means `quit` like C-c
                return
            end
            sleep 1
        end
    end
end

alias epath 'varclear PATH; echo $PATH | tr " " "\n" | nl'
function varclear --description 'Remove duplicates from environment varieble'
    if test (count $argv) = 1
        set -l newvar
        set -l count 0
        for v in $$argv
            if contains -- $v $newvar
                set count (math $count+1)
            else
                set newvar $newvar $v
            end
        end
        set $argv $newvar
        test $count -gt 0
        and echo Removed $count duplicates from $argv
    else
        for a in $argv
            varclear $a
        end
    end
end

alias rm 'rm -vi'
alias cp 'cp -vi'
alias mv 'mv -vi'
alias rcp 'rsync --stats --progress -rhv '
alias rmc 'rsync --stats --progress -rhv --remove-source-files ' # this will not delte the src dir, only the contents

#alias grep='grep -nr --color=auto'
alias g 'grep -F -n --color=auto'
alias egrep 'egrep --color=auto'
alias fgrep 'fgrep --color=auto'

# alias fu 'type'
function fu -d 'fu command and prompt to ask to open it or not'
    type $argv
    if test $status != 0
        return
    end
    echo
    set -l result (type $argv)
    # check if the argv is a definition in config.fish
    printf '%s\n' $result | head -1 | grep -i "is a function with definition" ^/dev/null >/dev/null
    if test $status = 0
        read -n 1 -p 'echo "Open the file containing the definition? [y/N]: "' -l answer
        if test "$answer" = "y" -o "$answer" = " "
            # check if the definition is an alias or a function
            # alias    -- second line of output of fu ends with "- @ line 0"
            # function -- second line of output of fu ends with "$path @ line $num_line"
            set -l num_line (printf '%s\n' $result | sed -n "2p" | awk -v x=7 '{print $x}')
            # or
            # set -l num_line (printf '%s\n' $result | sed -n "2p" | awk 'NF>1{print $NF}')
            set -l def_file (printf '%s\n' $result | sed -n "2p" | awk -v x=4 '{print $x}')
            if test $def_file = "-"
                set def_file ~/.config/fish/config.fish
                set -l argv_line (printf "alias %s " $argv)
                set num_line (grep -n $argv_line $def_file | cut -d: -f1)
            end
            vim $def_file +$num_line
        end
    else if test (printf '%s\n' $result | head -1 | grep -i "is a builtin")
        return                  # is a builtin like if
    else # argv is a file
        set -l file_path (printf '%s\n' $result | awk 'NF>1{print $NF}')
        # symbolic
        file $file_path | grep "symbolic"
        if test $status = 0
            # the file_path may only contains the file name if target is in the same dir
            set file_path (readlink -f $file_path)
        end
        # script
        file $file_path | grep "script"
        if test $status = 0
            echo
            read -n 1 -p 'echo "Open the file?[y/N]: "' -l answer
            if test "$answer" = "y" -o "$answer" = " "
                vim $file_path
            end
        else
            file $file_path
        end
    end
end

# touch temporary files
alias tout 'touch ab~ .ab~ .\#ab .\#ab\# \#ab\# .ab.swp ab.swp'
# find
function fd --description 'find the files by name, if no argv is passed, use the current dir'
    find $argv[1] -name $argv[2]
end
function ft --description 'find the temporary files such as a~ or #a or .a~, if no argv is passed, use the current dir'
    find $argv[1] \( -name "*~" -o -name "#?*#" -o -name ".#?*" -o -name "*.swp" \) | xargs -r ls -lhd | nl

end
function ftr --description 'delete the files found by ft'
    find $argv[1] \( -name "*~" -o -name "#?*#" -o -name ".#?*" -o -name "*.swp" \) | xargs rm -rfv

end
function ftc --description 'find the temporary files such as a~ or #a or .a~, if no argv is passed, use the current dir, not recursively'
    find $argv[1] -maxdepth 1 \( -name "*~" -o -name "#?*#" -o -name ".#?*" -o -name "*.swp" \) | xargs -r ls -lhd | nl
end
function ftcr --description 'delete the files found by ftc'
    find $argv[1] -maxdepth 1 \( -name "*~" -o -name "#?*#" -o -name ".#?*" -o -name "*.swp" \) | xargs rm -rfv
end
function fing --description 'find all the git projects, if no argv is passed, use the current dir'
    find $argv[1] -type d -name .git | sort
end
function findn --description 'find the new files in the whole system, argv[1] is the last mins, argv[2] is the file name to search'
    sudo find / -type f -mmin -$argv[1] | sudo ag $argv[2]
end

function lcl --description 'clean latex temporary files such as .log, .aux'
    # one way, but this may delete some file like file.png if tex file is file.tex
    # for FILE in (find . -name "*.tex")
    #   for NO_EXT in (expr "//$FILE" : '.*/\([^.]*\)\..*$')
    #       find . -type f -name "$NO_EXT*" | ag -v ".pdf|.tex" | xargs -r /bin/rm -rv
    #   end
    # end
    # another way, more safe
    for EXT in ind ilg toc out idx aux fls log fdb_latexmk
        # ind ilg toc out idx aux fls log fdb_latexmk faq blg bbl brf nlo dvi ps lof pdfsync synctex.gz
        find . -name "*.$EXT" | xargs -r rm -rv
    end
    rm -rfv auto
    ftr
end

# du
alias du 'du -h --apparent-size'
alias dus 'du -c -s'
function duS
    du -s -c $argv | sort -h
end
alias dul 'sudo du --summarize -h -c /var/log/* | sort -h'
function duss --description 'list and sort all the files recursively by size'
    du -ah $argv | grep -v "/\$" | sort -rh
end

alias watd 'watch -d du --summarize'
alias df 'df -h'
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
alias me 'm $argv[1] ~/.emacs.d/init.el'
alias mh 'm $argv[1] /etc/hosts'
alias m2 'm $argv[1] ~/Recentchange/TODO'
alias mf 'm $argv[1] ~/.fishrc'
#
alias less 'less -RM -s +Gg'
# color in less a code file
# set -gx LESSOPEN '|pygmentize -g %s'
# if pygmentize not working, use source-highlight instead
set -gx LESSOPEN '| /usr/bin/src-hilite-lesspipe.sh %s'
# nums are explained at
# http://www.tuxarena.com/2012/04/tutorial-colored-man-pages-how-it-works/
set -gx LESS_TERMCAP_me \e'[0m' # turn off all appearance modes (mb, md, so, us)
set -gx LESS_TERMCAP_se \e'[0m' # leave standout mode
set -gx LESS_TERMCAP_ue \e'[0m' # leave underline mode
set -gx LESS_TERMCAP_so \e'[01;44m' # standout-mode – info
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

# another way to do it
alias vm 'vim -u ~/.vimrc.more'
# color in man page
set -gx MANPAGER 'less -s -M +Gg -i'
# color in man page and less
# without this line, the LESS_TERMCAP_xxx won't work in Fedora
set -gx GROFF_NO_SGR yes
# other major details goto the end of the this file

# gcc
alias gcc-w 'gcc -g -Wall -W -Wsign-conversion'
alias gcc-a 'gcc -g -pedantic -Wall -W -Wconversion -Wshadow -Wcast-qual -Wwrite-strings -Wmissing-prototypes  -Wno-sign-compare -Wno-unused-parameter'
# gcc -Wall -W -Wextra -Wconversion -Wshadow -Wcast-qual -Wwrite-strings -Werror

alias ifw 'ifconfig wlp5s0'
#alias nl 'nload -u H p4p1'
alias nll 'nload -u H wlp8s0'
alias nh 'sudo nethogs wlp5s0'
# =ifconfig= is obsolete! For replacement check =ip addr= and =ip link=. For statistics use =ip -s link=.
alias ipp 'ip -4 -o address'
alias tf 'traff wlan0'
alias m-c 'minicom --color=on'
alias tree 'tree -Cshf'

# j for .bz2, z for .gz, J for xz, a for auto determine
alias t-tbz2 'tar tvfj'
alias t-tgz 'tar tvfz'
alias t-txz 'tar tvfJ' # show the contents
alias t-ta 'tar tvfa' # the above three can just use this one to auto choose the right one
alias t-xbz2 'tar xvfj'
alias t-xgz 'tar xvfz'
alias t-xxz 'tar xvfJ' # extract
alias t-xa 'tar xvfa' # the above three can jsut use this one to auto choose the right one
alias t-cbz2 'tar cvfj'
alias t-cgz 'tar cvfz'
alias t-cxz 'tar cvfJ $argv[1].tar.xz $argv[1]'
function t-ca --description '`t-ca dir vcs` to include .svn/.git, or `t-ca dir` to exclude'
    # remove the end slash in argv
    set ARGV (echo $argv[1] | sed 's:/*$::')
    if test (count $argv) = 1
        tar cvfa $ARGV.tar.xz $ARGV --exclude-vcs
    else
        tar cvfa $ARGV.tar.xz $ARGV
    end
end
alias dt 'dtrx -v '
# using unar -- https://unarchiver.c3.cx/unarchiver is available
# if the code is not working, try GBK or GB18030
# unzip zip if it is archived in Windows and messed up characters with normal unzip
alias unzipc 'unzip -O CP936'
function debx --description 'extract the deb package'
    set pkgname (basename $argv[1] .deb)
    mkdir -v $pkgname
    set dataname (ar t $argv[1] | ag data)
    ar p $argv[1] $dataname| tar zxv -C $pkgname
    if not test (echo $status) -eq 0
        ar p $argv[1] $dataname | tar Jxv -C $pkgname
        if not test (echo $status) -eq 0
            rm -rfv $pkgname
        end
    end
    echo ----in $pkgname ----
end

alias wget 'wget -c '
alias wgets 'wget -c --mirror -p --html-extension --convert-links'
alias wt 'bash -c \'rm -rfv /tmp/Thun* 2>/dev/null\'; wget -c -P /tmp/ http://dl1sw.baidu.com/soft/9e/12351/ThunderMini_1.5.3.288.exe'
alias wtt 'bash -c \'rm -rfv /tmp/Thun* 2>/dev/null\'; wget --connect-timeout=5 -c -P /tmp/ http://dlsw.baidu.com/sw-search-sp/soft/ca/13442/Thunder_dl_V7.9.39.4994_setup.1438932968.exe'

# rpm
alias rpmi 'sudo rpm -Uvh'
function rpml --description 'list the content of the pack.rpm file'
    for i in $argv
        echo \<$i\>
        echo -------------------
        rpm -qlpv $i | less
    end
end
function rpmx --description 'extract the pack.rpm file'
    for i in $argv
        echo \<$i\>
        echo -------------------
        rpm2cpio $i | cpio -idmv
    end
end

# yum
alias yum   'sudo yum -C --noplugins ' # not update cache
alias yumi  'sudo yum install '
alias yumiy 'sudo yum install -y'
alias yumr  'sudo yum remove '
alias yumri 'sudo yum reinstall -y'
alias yumca 'sudo yum clean all -v'
alias yumu  'sudo yum --exclude=kernel\* upgrade ' # this line will be '=kernel*' in bash
alias yumuk 'sudo yum upgrade kernel\*'
alias yumue 'sudo yum update --exclude=kernel\* '
alias yumul 'sudo yum history undo last'
alias yumhl 'sudo yum history list'
alias yumun 'sudo yum history undo'
alias yums  'sudo yum search'
alias yumsa 'sudo yum search all'
# dnf
alias dnfu 'sudo dnf update -v'
alias dnfU 'sudo dnf update --setopt exclude=kernel\* -v'
alias dnfu2 'sudo dnf update -y --disablerepo="*" --enablerepo="updates" '
alias dnfc 'sudo dnf clean all'
alias dnfi 'sudo dnf install -v'
alias dnfr 'sudo dnf remove -v'
alias dnfl 'dnf list installed| less'
alias dnfs 'sudo dnf search'
alias dnfsa 'sudo dnf search all'
alias dnful 'sudo dnf history undo last'

# apt
alias api 'sudo apt-get install -V'
alias apu 'sudo apt-get update; sudo apt-get upgrade -V'
alias apr 'sudo apt-get remove -V'
alias apar 'sudo apt-get autoremove -V'

# donnot show the other info on startup
alias gdb 'gdb -q '

# systemd-analyze
function sab --description 'systemd-analyze blame->time'
    systemd-analyze blame | head -40
    systemd-analyze time
end

# cd
function .-; cd -; end
function ..; cd ..; end
function ...; cd ../..; end
function ....; cd ../../..; end
function .....; cd ../../../..; end
alias cdi 'cd /usr/include/'
alias cde 'cd ~/.emacs.d/elpa; and lah'
alias cdb 'cd ~/.vim/bundle'
alias cdp 'cd ~/Public; and lah'
alias cdc 'cd ~/Projects/CWork; and lah'
alias cds 'cd ~/Projects/CWork/snippets; and lah'
alias cdP 'cd ~/Projects'
alias cdu 'cd /run/media/chz/UDISK/; and lah'
# cd then list
function cdls
    cd $argv
    ls
end
function cdll
    cd $argv
    ll
end
function cdla
    cd
    la
end
# path replacement like zsh
# https://www.slideshare.net/jaguardesignstudio/why-zsh-is-cooler-than-your-shell-16194692
function cs -d 'change dir1 to dir2 in the $PWD and cd into it'
    if test (count $argv) -eq 2
        set new_path (echo $PWD|sed -e "s/$argv[1]/$argv[2]/")
        cd $new_path
    else
        printf "%s\n" (_ "Wrong argument!!!")
        return 1
    end
end

# diff
alias diff-s 'diff -y -s --suppress-common-line -W $COLUMNS'
alias diff-sw 'diff-s -w'
alias diff-y 'diff -y -s -W $COLUMNS '
alias diff-yw 'diff-y -w'

function mkcd --description 'mkdir dir then cd dir'
    mkdir -p $argv
    cd $argv
end

# xclip, get content into clipboard, echo file | xclip
alias xp 'xclip'
alias x 'xclip -selection c'

alias km 'sudo kermit'

alias dusc 'dus -c ~/.config/google-chrome ~/.cache/google-chrome ~/.mozilla ~/.cache/mozilla '
alias gcp 'google-chrome --incognito'
alias ffp 'firefox -private-window'

alias cx 'chmod +x '

# netease-play, douban.fm
alias np 'netease-player '
alias db 'douban.fm '

#vim
alias v 'vim'
alias V 'vim -u NONE'
alias vc 'vim ~/.cgdb/cgdbrc'
alias vv 'vim ~/.vimrc'
alias vb 'vim ~/.bashrc'
alias ve 'vim ~/.emacs.d/init.el'
alias v2 'vim ~/Recentchange/TODO'
alias vf 'vim ~/.fishrc; source ~/.fishrc; echo ~/.fishrc reloaded!'
alias vt 'vim ~/.tmux.conf; tmux source-file ~/.tmux.conf; echo ~/.tmux.conf reloaded!'

# emacs
# -Q = -q --no-site-file --no-splash, which will not load something like emacs-googies
# FIXME:
alias eit "time emacs --debug-init -eval '(kill-emacs)'"
alias emq 'emacs -q --no-splash'
alias emx 'emacs -nw -q --no-splash --eval "(setq find-file-visit-truename t)"'
alias emn 'emacs --no-desktop'
alias emi 'emacs -q --no-splash --load $argv'
function emd --description 'remove .emacs.d/init.elc then $ emacs --debug-init'
    rm -rf ~/.emacs.d/init.elc
    emacs --debug-init
end
alias e 'emx '
alias ei 'emx ~/.emacs.d/init.el'
alias ec 'emx ~/.cgdb/cgdbrc'
alias ef 'emx ~/.fishrc'
alias ev 'emx ~/.vimrc'
alias eb 'emx ~/.bashrc'
alias ee 'emx ~/.emacs.d/init.el'
# alias et 'emx ~/.tmux.conf'
alias e2 'emx ~/Recentchange/TODO'

function fsr --description 'Reload your Fish config after configuration'
    source ~/.config/fish/config.fish # fsr
    echo .fishrc is reloaded!
    path_prompt
end
# C-w to reload ~/.fishrc
#bind \cs fsr

# the gpl.txt can be gpl-2.0.txt or gpl-3.0.txt
alias lic 'wget -q http://www.gnu.org/licenses/gpl.txt -O LICENSE'

# git
alias gits 'git status ' # gs is original Ghostscript app
alias gitp 'git pull -v'
alias gitc 'git clone -v'
alias gitl 'git log --stat'
alias gitd 'git diff' # show unpushed local modification
alias gitlp 'git log -p -- ' # [+ file] to how entire all/[file(even renamed)] history
alias gitsh 'git show ' # [+ COMMIT] to show the modifications in a last/[specific] commit
alias gitlo 'git log --oneline'
alias gitsh 'git show ' # + COMMIT to show the modifications in a commit
alias gitb 'git branch'
alias gitco 'git checkout'
alias gitcl 'git config -l'
alias gitcp 'git checkout HEAD^1' # git checkout previous/old commit
alias gitcn 'git log --reverse --pretty=%H master | grep -A 1 (git rev-parse HEAD) | tail -n1 | xargs git checkout' # git checkout next/new commit
alias gitt 'git tag'
function gitpa --description 'git pull all in dir using `fing dir`'
    for i in (find $argv[1] -type d -name .git | sort | xargs realpath)
        cd $i; cd ../
        pwd
        git pull -v;
        echo -----------------------------
        echo
    end
end

# svn
alias svnp 'svn update; and echo "---status---"; svn status'
alias svnpn 'svn update ~/NVR.ori/Code'
alias svns 'svn status'
alias svnc 'svn commit -m'
alias svnd 'svn diff | less'
alias svnll 'svn log -v -l 10 | less'
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
    set Revision (svn info | awk '/Revision/ {print $2}')
    if test (echo $argv[1] | grep ':' -c) -eq 1
        # if argv is like 1000:1010, then svn diff the two revisions
        svn diff -r $argv[1] | less
    else if test (count $argv) -eq 1
        if test $argv[1] -gt 10
            # if the argv is like 1000, then svn diff revision
            svn diff -c $argv[1] | less
        else
            # if the argv is like 3, the svn diff the 3th commit to the last
            # the PREV is 1
            set Rev (echo $Revision-$argv[1]+1 | bc)
            svn diff -c $Rev | less
        end
    else if test (svn status | wc -l) != 0
        # show the diff if local differs from server
        svn diff
    else if test (count $argv) = 0
        # if no argv is given, then svn diff the last commit
        # equals to `sdd` == `sdd 1`
        svn diff -r PREV | less
    end
end

alias hs 'sudo cp -v ~/Public/hosts/hosts /etc/hosts'

# https://stackoverflow.com/questions/10408816/how-do-i-use-the-nohup-command-without-getting-nohup-out
function meld --description 'lanuch meld from terminal without block it'
    bash -c "(nohup /usr/bin/meld $argv </dev/null >/dev/null 2>&1 &)"
end
# okular
alias ok 'bash -c "(nohup okular $argv </dev/null >/dev/null 2>&1 &)"'
alias ima 'bash -c "(nohup gwenview $argv </dev/null >/dev/null 2>&1 &)"'
alias op 'bash -c "(nohup xdg-open $argv </dev/null >/dev/null 2>&1 &)"'

alias fcg 'fc-list | ag '

# do `h` in the new one after switching terminal session
function h --on-process-exit %self
    history --merge
end
function his
    history | ag $argv[1]
end

alias cl 'cloc '
alias cll 'cloc --by-file-by-lang '

alias st 'stow --verbose'

alias ptp 'ptipython'

#alias rea 'sudo ~/.local/bin/reaver -i mon0 -b $argv[1] -vv'
# function rea
# sudo ~/.local/bin/reaver -i mon0 -b $argv
# end

alias epub 'ebook-viewer --detach'
alias time 'time -p'
alias ex 'exit'

alias p 'ping -c 5'
alias ping 'ping -c 5'
function po -d 'Test the connection of outside internet'
    timeout 1 ping -c 1 www.baidu.com ^/dev/null >/dev/null
    if test $status != 0
        echo Offline!
    else
        echo Online!
    end
end
function pl -d 'Test the connection of inside internet'
    if test (count $argv) -eq 1
        timeout 1 ping -c 1 10.8.2.$argv ^/dev/null >/dev/null
        if test $status != 0
            echo Offline!
        else
            echo Online!
        end
    else
        timeout 1 ping -c 1 10.0.4.4 ^/dev/null >/dev/null
        if test $status != 0
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
function ipl -d 'check the location of your public IP address'
    # https://www.cyberciti.biz/faq/how-to-find-my-public-ip-address-from-command-line-on-a-linux/
    # set -l publicIP (dig +short myip.opendns.com @resolver1.opendns.com)
    # set -l publicIP (dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | sed s/\"//g)
    set -l publicIP (curl ifconfig.co ^ /dev/null)
    curl ipinfo.io/$publicIP
end
function port -d 'list all the ports are used or check the process which are using the port'
    if test (count $argv) = 1
        netstat -tulpn | grep $argv
    else
        netstat -tulpn
    end
end

alias lo 'locate -e'
function lop --description 'locate the full/exact file'
    locate -e -r "/$argv[1]\$"
end
function findn --description 'find the new files in the whole system, argv[1] is the last mins, argv[2] is the file name to search'
    sudo find / -type f -mmin -$argv[1] | sudo ag $argv[2]
end

# bc -- calculator
function bc --description 'calculate in command line using bc non-interactive mode if needed, even convert binary/octual/hex'
    if test (count $argv) -eq 1
        echo $argv[1] | /usr/bin/bc -l
    else
        /usr/bin/bc -ql
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

function cat
    # if [ $argc != 2]
    for i in $argv
        echo -e "\\033[0;31m"\<$i\>
        echo -e ------------------------------------------------- "\\033[0;39m"
        /bin/cat $i
        echo
    end
end

function deff
    sdcv $argv | less
end
alias SDCV 'sdcv -u "WordNet" -u "牛津现代英汉双解词典" -u "朗道英汉字典5.0"'
function defc --description 'search the defnition of a word and save it into personal dict if it is the first time you search'
    ag -w $argv ~/.sdcv_history >> /dev/null
    or begin # new, not searched the dict before, save
        SDCV $argv | ag "Nothing similar" >> /dev/null
        or begin # the word found
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
    SDCV $argv
    sort -u -o ~/.sdcv_history ~/.sdcv_history
end

# count chars of lines of a file
# awk '{ print length }' | sort -n | uniq -c

# note that there is no $argv[0], the $argv[1] is the first argv after the command name, so the argc of `command argument` is 1, not 2
function man
    if test (count $argv) -eq 2
        sed -i "s/.shell/\"$argv[2]\n.shell/g" ~/.lesshst
    else
        sed -i "s/.shell/\"$argv[1]\n.shell/g" ~/.lesshst
    end
    command man $argv
end
alias ma 'man'

function wtp --description 'show the real definition of a type or struct in C code, you can find which file it is defined in around the result'
    gcc -E ~/.local/bin/type.c -I$argv[1] > /tmp/result
    if test (count $argv) -eq 2
        if test (echo $argv[1] | grep struct)
            ag -A $argv[2] "^$argv[1]" /tmp/result
        else
            ag -B $argv[2] $argv[1] /tmp/result
        end
    else
        ag $argv[1] /tmp/result
    end
end

function ut -d 'toggle -- use data network sharing through Android device throught USB'
    if not test (ip link | grep usb0) # ()=1, not plugged or enabled in Android device
        echo Android device is not plugged or data network sharing is not enabled!
    else          # ()=0
        timeout 1 ping -c 1 www.baidu.com ^ /dev/null > /dev/null # NOTE: stdout and stderr redirect
        if test $status != 0
            echo Network is off!
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
            # timeout 2 ping -c 2 www.baidu.com ^ /dev/null > /dev/null # NOTE: stdout and stderr redirect
            # if test $status != 0
            #     echo Network is still off.
            # else
            #     echo Network is on!
            # end
        else
            echo Network is already on!
        end
        if test (pgrep dhclient | wc -l) != 0
            sudo pkill dhclient  # this has no effect on the network, just make next usbt quicker
        end
    end
end

alias um 'pumount /run/media/chz/UDISK'
alias mo 'pmount /dev/sdb4 /run/media/chz/UDISK'


alias ytd 'youtube-dl -citw '

# return tmux
alias t 'tmux a'
alias tl 'tmux ls'
alias tl 'tmux ls'
alias tls 'tmux list-panes -s'
function tk -d 'tmux kill-session single/multiple sessions'
    if test (count $argv) -gt 0
        for i in $argv
            tmux kill-session -t $i
        end
    else
        echo "Need target sessions"
    end
end
function tka -d 'tmux kill-session except given session[s]'
    if test (count $argv) -gt 0
        set -l sid (tl | nl | awk '{print $2}' | sed 's/://g')
        for i in $sid
            if not contains $i $argv
                tmux kill-session -t $i
                echo Tmux session $i is killed
            end
        end
        echo \n--------------\n
        echo Left sessions:
        tmux ls
    else
        read -l -p 'echo "Kill all tmux sessions including this one? [y/N]"' anwser
        if test "$answer" = "y"
            tmux kill-server        # kill all sessions (including current one)
        end
    end
end
# or just use 'M-c r', it is defiend in ~/.tmux.conf
alias tsr 'tmux source-file ~/.tmux.conf; echo ~/.tmux.conf reloaded!'
# this line will make the indentation of lines below it wrong, TODO: weird
# alias tt 'tmux switch-client -t'
function twp -d 'tmux swap-pane to current pane to the target pane'
    tmux display-panes "'%%'"
    read -n 1 -p 'echo "Target pane number? "' -l num
    tmux swap-pane -s $num
end

alias ag "ag --pager='less -RM -FX -s'"
# ag work with less with color and scrolling
function ag
    sed -i "s/.shell/\"$argv[1]\n.shell/g" ~/.lesshst
    if test -f /usr/bin/ag
        /usr/bin/ag --ignore '*~' --ignore '#?*#' --ignore '.#?*' --ignore '*.swp' --ignore -s --pager='less -RM -FX -s' $argv
    else
        grep -n --color=always $argv | more
        echo -e "\n...ag is not installed, use grep instead..."
    end
end
function age --description 'ag sth. in ~/.emacs.d/init.el'
    ag $argv[1] ~/.emacs.d/init.el
end
function agf --description 'ag sth. in ~/.fishrc'
    ag $argv[1] ~/.fishrc
end
function agt --description 'ag sth. in ~/.tmux.conf'
    ag $argv[1] ~/.tmux.conf
end
function ag2 --description 'ag sth. in ~/Recentchange/TODO'
    ag $argv[1] ~/Recentchange/TODO
end

# ls; and ll -- if ls succeed then ll, if failed then don't ll
# ls; or ll -- if ls succeed then don't ll, if failed then ll

# such as:
# alias sp 'svn update; and echo "---status---"; svn status'

# if test $status -eq 0; ... else ... # success
# to
# and begin ... end; or ...

# if test $status -eq 1; ... else ... # failure
# to
# or begin ... end; or ...

function bak -d 'backup(copy) a file from abc to abc.bak'
    set ori $argv[1]
    if test "/" = (echo (string sub --start=-1 $argv[1])) # for dir ending with "/"
        set ori (echo (string split -r -m1 / $argv[1])[1])
    end
    cp -v $ori{,.bak}
end
function bakm -d 'backup(move) a file from abc to abc.bak'
    set ori $argv[1]
    if test "/" = (echo (string sub --start=-1 $argv[1])) # for dir ending with "/"
        set ori (echo (string split -r -m1 / $argv[1])[1])
    end
    if test -d $ori.bak
        echo The destination is alread existed.
    else
        mv -v $ori{,.bak}
    end
end
function bak2c -d 'copy backup file from abc.bak to abc'
    if test -d (echo (string split -r -m1 . $argv[1])[1])
        echo The destination is alread existed.
    else
        cp -v $argv[1] (echo (string split -r -m1 . $argv[1])[1])
    end
end
function bak2m -d 'move backup file from abc.bak to abc'
    if test -d (echo (string split -r -m1 . $argv[1])[1])
        echo The destination is alread existed.
    else
        mv -v $argv[1] (echo (string split -r -m1 . $argv[1])[1])
    end
end

function d --description "Choose one from the list of recently visited dirs"
    set -l letters - b c d e f h i j k l m n o p q r s t u v w x y z
    set -l all_dirs $dirprev $dirnext
    if not set -q all_dirs[1]
        echo 'No previous directories to select. You have to cd at least once.'
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

    set -l dirc (count $uniq_dirs)
    if test $dirc -gt (count $letters)
        set -l msg 'This should not happen. Have you changed the cd function?'
        printf (_ "$msg\n")
        set -l msg 'There are %s unique dirs in your history' \
        'but I can only handle %s'
        printf (_ "$msg\n") $dirc (count $letters)
        return 1
    end

    set -l pwd_existed 0
    # already_pwd avoid always print the bottom line *pwd:...
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
    read -l -p 'echo "Goto: "' choice
    if test "$choice" = ""
        return 0
    else if string match -q -r '^[\-|b-z]$' $choice
        set choice (contains -i $choice $letters)
    end

    if string match -q -r '^\d+$' $choice
        if test $choice -ge 1 -a $choice -le $dirc
            cd $uniq_dirs[$choice]
            return
        else
            echo Error: expected a number between 1 and $dirc, got \"$choice\"
            return 1
        end
    else
        echo Error: expected a number between 1 and $dirc or letter in that range, got \"$choice\"
        return 1
    end
end

#### ---------------- anaconda starts -----------------------
# anaconda
function condalist -d 'List conda environments.'
    for dir in (ls $HOME/anaconda3/envs)
        echo $dir
    end
end

function condactivate -d 'Activate a conda environment' -a cenv
    if test -z $cenv
        echo 'Usage: condactivate <env name>'
        return 1
    end

    # condabin will be the path to the bin directory
    # in the specified conda environment
    set condabin $HOME/anaconda3/envs/$cenv/bin

    # check whether the condabin directory actually exists and
    # exit the function with an error status if it does not
    if not test -d $condabin
        echo 'Environment not found.'
        return 1
    end

    # deactivate an existing conda environment if there is one
    if set -q __CONDA_ENV_ACTIVE
        deactivate
    end

    # save the current path
    set -xg DEFAULT_PATH $PATH

    # put the condabin directory at the front of the PATH
    set -xg PATH $condabin $PATH

    # this is an undocumented environmental variable that influences
    # how conda behaves when you don't specify an environment for it.
    # https://github.com/conda/conda/issues/473
    set -xg CONDA_DEFAULT_ENV $cenv

    # set up the prompt so it has the env name in it
    functions -e __original_fish_prompt
    functions -c fish_prompt __original_fish_prompt
    function fish_prompt
        set_color blue
        echo -n '('$CONDA_DEFAULT_ENV') '
        set_color normal
        __original_fish_prompt
    end

    # flag for whether a conda environment has been set
    set -xg __CONDA_ENV_ACTIVE 'true'
end

function deactivate -d 'Deactivate a conda environment'
    if set -q __CONDA_ENV_ACTIVE
        # set PATH back to its default before activating the conda env
        set -xg PATH $DEFAULT_PATH
        set -e DEFAULT_PATH

        # unset this so that conda behaves according to its default behavior
        set -e CONDA_DEFAULT_ENV

        # reset to the original prompt
        functions -e fish_prompt
        functions -c __original_fish_prompt fish_prompt
        functions -e __original_fish_prompt
        set -e __CONDA_ENV_ACTIVE
    end
end

# aliases so condactivate and deactivate can have shorter names
function ca -d 'Activate a conda environment'
    condactivate $argv
end

function cda -d 'Deactivate a conda environment'
    deactivate $argv
end

# complete conda environment names when activating
complete -c condactivate -xA -a "(condalist)"
complete -c ca -xA -a "(condalist)"

function con --description 'Activate a conda environment.'
    if test (count $argv) -eq 0
        conda info -e
        return 0
    end

    if test (count $argv) -ne 1
        echo 'Too many args -- expected at most one conda environment name.'
        return 1
    end

    set -l conda_env $argv[1]

    if not command conda '..checkenv' fish $conda_env
        return 1
    end

    # Deactivate the currently active environment if set.
    if set -q CONDA_DEFAULT_ENV
        coff
    end

    # Try to activate the environment.
    set -l new_path (command conda '..activate' fish $conda_env)
    or return $status

    set -g CONDA_PATH_BACKUP $PATH
    set -gx PATH $new_path $PATH
    set -gx CONDA_DEFAULT_ENV $conda_env
end
function coff --description 'Deactivate a conda environment.'
    if set -q argv[1]
        echo "Too many args -- expected no args, got: $argv" >&2
        return 1
    end

    if not set -q CONDA_DEFAULT_ENV
        echo "There doesn't appear to be any conda env in effect." >&2
        return 1
    end

    # Deactivate the environment.
    set -gx PATH $CONDA_PATH_BACKUP
    set -e CONDA_PATH_BACKUP
    set -e CONDA_DEFAULT_ENV
end
#### ---------------- anaconda ends -----------------------
