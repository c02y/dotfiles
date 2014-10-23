# ~/.fishrc linked to ~/.config/fish/config.fish
### you can use `fish_config` to config a lot of things in WYSIWYG way in browser

set -gx PATH ~/.local/share/arm-linux/bin ~/.local/bin ~/.linuxbrew/bin /sbin $PATH

# for ~/.linuxbrew/ (brew for linux to install programs)
set -gx LD_LIBRARY_PATH ~/.linuxbrew/Library $LD_LIBRARY_PATH

# remove the greeting message
set fish_greeting

set -gx fish_color_user magenta
set -gx fish_color_host yellow

# modified version of prompt_pwd, full path, not short
function prompt_pwd --description 'Print the current working directory, NOT shortened to fit the prompt'
	if test "$PWD" != "$HOME"
	   printf " %s " (echo $PWD|sed -e 's|/private||' -e "s|^$HOME|~|")
	else
		echo ' ~'
	end
end

# prompt text showing at the beginning of the line
function fish_prompt --description 'Write out the prompt'
	set -l last_status $status
	# User
	set_color $fish_color_user
	echo -n (whoami)
	set_color normal

	echo -n '@'

	# Host
	set_color $fish_color_host
	echo -n (hostname -s)
	set_color normal

	echo -n ':'

	# PWD
	set_color $fish_color_cwd
	echo -n (prompt_pwd)
	set_color normal

	echo

	if not test $last_status -eq 0
		set_color $fish_color_error
	end
	# http://unicode-table.com/en/sets/arrows-symbols/
	# http://en.wikipedia.org/wiki/Arrow_(symbol)
	echo -n '➤➤ '  # ➢ ➣, ↩ ↪ ➥ ➦, ▶ ▷ ◀ ◁, ❥
	set_color normal
end

function fish_right_prompt -d "Write out the right prompt"
#	set_color -o black
	__informative_git_prompt

#	set_color $fish_color_normal
end
###################################################################

set fish_new_pager 1


# User specific aliases and functions
alias sl 'ls'
alias l 'ls'
# alias ls 'ls --color=auto'
alias lsp 'readlink -f'         # print the full path of a file
alias lsd 'ls -d */'            # only list unhidden directories
alias ll 'ls -lh'
alias la 'ls -d .??*'			# only list the hidden dirs
alias lla 'ls -lhA'             # list all but not . ..
alias ls. 'ls -A'
function lst
	ls --color=yes --sort=time -lh | less -R
end
function lsh
	ls --color=yes $argv[1] --sort=time -lh | head
end
function lls
	ll --color=yes $argv[1] --sort=size -lh | less -R
end
function llh
	ll --color=yes $argv[1] --sort=time -lh | head
end
alias llt 'll --color=yes --sort=time -lh | less -R'
alias lat 'la --color=yes --sort=time -lh | less -R'
alias lah 'la --color=yes --sort=time -lh | head'
# count the number of the files in the dir(not sub.), use tree | wc -l for subdirs
alias lsc 'ls -all | wc -l'
# valgrind
# alias va='valgrind -v --track-origins=yes'
alias va 'valgrind --track-origins=yes --leak-check=full '

alias ima 'gwenview'
alias ka 'killall'
alias his 'history | ag '
# alias bw 'ssh -qTfnN -D 7070 -p 443 hei1000@216.194.70.6'
alias bw 'bash; ssh -qTfnN -D 7070 hei1000@216.194.70.6'

alias rm 'rm -vir'
alias cp 'cp -vig'
alias mv 'mv -vig'
alias rcp 'rsync --stats --progress -rhv '
alias rmv 'rsync --stats --progress -rhv --remove-source-files ' # this will not delte the src dir, only the contents

#alias grep='grep -nr --color=auto'
alias g 'grep -F -n --color=auto'
alias egrep 'egrep --color=auto'
alias fgrep 'fgrep --color=auto'

alias fu 'functions '

# find
function f --description 'find the files by name, if no argv is passed, use the current dir'
#	find . -name $argv
	find $argv[1] -name $argv[2]
end
function ft --description 'find the temporary files such as a~ or #a or .a~, if no argv is passed, use the current dir'
	find $argv[1] -name "*~"
	find $argv[1] -name "#?*"
end
function ftr --description 'delete the files found by ft'
	find $argv[1] -name "*~" | xargs rm -rfv
	find $argv[1] -name "#?*" | xargs rm -rfv
end
function fing --description 'find all the git projects, if no argv is passed, use the current dir'
	find $argv[1] -type d -name .git | sort
end

# ps
alias psg 'ps -ef | ag '

alias du 'du -h'
alias dus 'du --summarize'
alias duS 'du --summarize * | sort -h'
alias watd 'watch -d du --summarize'
alias df 'df -h'
# stop less save search history into ~/.lesshst
# or LESSHISTFILE=-
# set -gx LESSHISTFILE /dev/null $LESSHISTFILE
alias m 'less -NR'
alias less 'less -NR'

# gcc
alias gcc-w 'gcc -g -Wall -W -Wsign-conversion'
alias gcc-a 'gcc -g -ansi -pedantic -Wall -W -Wconversion -Wshadow -Wcast-qual -Wwrite-strings'
# gcc -Wall -W -Wextra -Wconversion -Wshadow -Wcast-qual -Wwrite-strings -Werror


# mpg321 random play
alias mpg321 'mpg321 -Z -@mp3'
alias mp3 'mpg123 --loop -1 -Z '

alias emq 'emacs -Q'
alias emx 'emacs -nw'
alias emn 'emacs --no-desktop'
function emd --description 'remove .emacs~ then $ emacs --debug-init'
	rm -rf ~/.emacs.elc
	emacs --debug-init
end

alias ifw 'ifconfig wlp5s0'
#alias nl 'nload -u H p4p1'
alias nl 'nload -u H wlp5s0'
alias nh 'sudo nethogs wlp5s0'
alias tf 'traff wlan0'
alias m-c 'minicom --color=on'
alias tree 'tree -Csh'

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
alias t-cxz 'tar cvfJ' # compress
alias t-ca 'tar cvfa' # the above three can just use this one to auto choose the right one

alias wget 'wget -c '
alias wgets 'wget -c --mirror -p --html-extension --convert-links'
alias wt 'wget -c -P /tmp/ http://dlsw.baidu.com/sw-search-sp/soft/3a/12350/QQ5.2.10432.0.1395280771.exe'
alias rpm 'sudo rpm'

# yum
alias yum 'sudo yum -C --noplugins ' # not update cache
alias in 'sudo yum install '
alias yr 'sudo yum remove '
alias ud 'sudo yum update --exclude=kernel\* '
alias ca 'sudo yum clean all -v'
alias ug 'sudo yum --exclude=kernel\* upgrade ' # this line will be '=kernel*' in bash

# donnot show the other info on startup
alias gdb 'gdb -q '

# systemd-analyze
function sab --description 'systemd-analyze blame->time'
	systemd-analyze blame
	systemd-analyze time
end

# cd
#alias .. 'cd ..'
#alias ..2 'cd ../..'
#alias ..3 'cd ../../../'
#alias ..4 'cd ../../../../'
#alias ..5 'cd ../../../../../'
alias cdi 'cd /usr/include/'
alias cde 'cd ~/.emacs.d/elpa; lsh'
alias cdb 'cd ~/.vim/bundle'
alias cdp 'cd ~/Public; lsh'
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


# diff
alias diff-s 'diff -y --suppress-common-line'
alias diff-y 'diff -y '

function mkcd --description 'mkdir dir then cd dir'
	mkdir -p $argv
		  cd $argv
end

# goagent
alias ga 'python /home/chz/Downloads/goagent/local/proxy.py'

# xclip, get content into clipboard, echo file | xclip
# alias xclip 'xclip -selection c'

# return tmux
alias t 'tmux a'

# use C-t to go back/in tumx/normal when using non-tmux
function fish_user_key_bindings
	bind \ct 'tmux a'
end

alias tu 'tmux'
alias tl 'tmux ls'
# kill the specific session like: tk 1
alias tk 'tmux kill-session -t '
# kill all the sessions
alias tka 'tmux kill-server'
# reload ~/.tmux.conf to make it work after editing config file
alias tr 'tmux source-file ~/.tmux.conf'
alias ts 'tmux switch-client -t '

alias km 'sudo kermit'

alias dusc 'dus ~/.config/google-chrome ~/.cache/google-chrome ~/.mozilla ~/.cache/mozilla '

alias cx 'chmod +x '

# netease-play, douban.fm
alias np 'netease-player '
alias db 'douban.fm '

#vim
alias v 'vim '
alias vc 'vim ~/.cgdb/cgdbrc'
alias vf 'vim ~/.fishrc'
alias vv 'vim ~/.vimrc'
alias ve 'vim ~/.emacs'
alias vt 'vim ~/.tmux.conf'
alias v2 'vim ~/Recentchange/TODO'
#more
alias me 'less ~/.emacs'

function fr --description 'Reload your Fish config after configuration'
	source ~/.config/fish/config.fish
end

# the gpl.txt can be gpl-2.0.txt or gpl-3.0.txt
alias lic 'wget -q http://www.gnu.org/licenses/gpl.txt -O LICENSE'

# git
alias gs 'git status ' # gs is original Ghostscript app
alias gp 'git pull -v'
alias gc 'git clone -v'
alias gl 'git log '
alias glp 'git log -p -- ' # how entire file int history
alias gb 'git branch'
alias gco 'git checkout'
alias gt 'git tag'

# HostsTool
alias hs 'cd ~/Public/HostsTool-x11-gpl-1.9.8-SE/; sudo python ./hoststool.py;'
alias hsc 'sudo cp -v ~/Public/HostsTool-x11-gpl-1.9.8-SE/hosts_2014-09-30-234541.bak /etc/hosts'
alias hss 'sudo cp -v ~/Public/HostsTool-x11-gpl-1.9.8-SE/hosts /etc/hosts'

# okular
alias ok 'okular '

function age --description 'ag sth. in ~/.emacs'
	ag $argv[1] ~/.emacs
end
function agf --description 'ag sth. in ~/.fishrc'
	ag $argv[1] ~/.fishrc
end

alias cl 'cloc '
alias cll 'cloc --by-file-by-lang'

alias st 'stow --verbose'

# percol
# percol_cd_history not work
set CD_HISTORY_FILE $HOME/.cd_history_file
function percol_cd_history
	sort $CD_HISTORY_FILE | uniq -c | sort -r | sed -e 's/^[ ]*[0-9]*[ ]*//' | percol | read -l percolCDhistory
	if [ $percolCDhistory ]
	  # commandline 'cd '
	  # commandline -i $percolCDhistory
	  echo 'cd' $percolCDhistory
	  cd $percolCDhistory
	  echo $percolCDhistory
	  commandline -f repaint
	else
		commandline ''
	end
end
# C-s goto the dir history
function fish_user_key_bindings
	bind \cs percol_cd_history
end

function percol_command_history
	history | percol | read foo
	if [ $foo ]
	   commandline $foo
	else
		commandline ''
	end
end
# C-r to search the history
function fish_user_key_bindings
	bind \cr percol_command_history
end
