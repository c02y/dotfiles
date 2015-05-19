# ~/.fishrc linked to ~/.config/fish/config.fish
### you can use `fish_config` to config a lot of things in WYSIWYG way in browser

set -gx PATH $PATH ~/.local/share/arm-linux/bin ~/.local/bin ~/.linuxbrew/bin /sbin

# for ~/.linuxbrew/ (brew for linux to install programs)
set -gx LD_LIBRARY_PATH $LD_LIBRARY_PATH ~/.linuxbrew/Library

# do not use the format above
# http://vivafan.com/2013/03/%E3%80%8Cfish%E3%80%8D%E3%82%B7%E3%82%A7%E3%83%AB%E3%82%92%E5%AE%9F%E9%9A%9B%E3%81%AB%E4%BD%BF%E3%81%86%E3%81%9F%E3%82%81%E3%81%AB/
# for more formats

# remove the greeting message
set fish_greeting

set -gx fish_color_user magenta
set -gx fish_color_host yellow

# fix the `^[]0;fish  /home/chz^G` message in shell of Emacs
if test "$TERM" = "dumb"
    function fish_title; end
end

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
	set_color -o blue
	echo -n '➤➤ '  # ➢ ➣, ↩ ↪ ➥ ➦, ▶ ▷ ◀ ◁, ❥
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
alias ls 'ls --color=always'
alias lsp 'readlink -f'         # print the full path of a file
alias lsd 'ls -d */'            # only list unhidden directories
alias ll 'ls -lh'
alias la 'ls -d .??*'			# only list the hidden dirs
alias lla 'ls -lhA'             # list all but not . ..
alias ls. 'ls -A'
function lst
	ls --color=yes $argv[1] --sort=time -lh | less -R
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
# more detail about time
alias vad 'valgrind --tool=callgrind --dump-instr=yes --simulate-cache=yes --collect-jumps=yes '

alias ima 'gwenview'
alias ka 'killall'

alias rm 'rm -vi'
alias cp 'cp -vi'
alias mv 'mv -vi'
alias rcp 'rsync --stats --progress -rhv '
alias rmc 'rsync --stats --progress -rhv --remove-source-files ' # this will not delte the src dir, only the contents

#alias grep='grep -nr --color=auto'
alias g 'grep -F -n --color=auto'
alias egrep 'egrep --color=auto'
alias fgrep 'fgrep --color=auto'

alias fu 'functions '
# touch temporary files
alias tout 'touch ab~ .ab~ .\#ab .\#ab\# \#ab\# .ab.swp ab.swp'
# find
function f --description 'find the files by name, if no argv is passed, use the current dir'
	find $argv[1] -name $argv[2]
end
function ft --description 'find the temporary files such as a~ or #a or .a~, if no argv is passed, use the current dir'
	find $argv[1] \( -name "*~" -o -name "#?*#" -o -name "#?*#" -o -name ".#?*" -o -name "*.swp" \)

end
function ftr --description 'delete the files found by ft'
	find $argv[1] \( -name "*~" -o -name "#?*#" -o -name "#?*#" -o -name ".#?*" -o -name "*.swp" \) | xargs rm -rfv

end
function ftc --description 'find the temporary files such as a~ or #a or .a~, if no argv is passed, use the current dir, not recursively'
	find $argv[1] -maxdepth 1 \( -name "*~" -o -name "#?*#" -o -name "#?*#" -o -name ".#?*" -o -name "*.swp" \)
end
function ftcr --description 'delete the files found by ftc'
	find $argv[1] -maxdepth 1 \( -name "*~" -o -name "#?*#" -o -name "#?*#" -o -name ".#?*" -o -name "*.swp" \) | xargs rm -rfv
end
function fing --description 'find all the git projects, if no argv is passed, use the current dir'
	find $argv[1] -type d -name .git | sort
end

alias psg 'ps -ef | ag '
alias fcg 'fc-list | ag '
alias his 'history | ag '

# du
alias du 'du -h'
alias dus 'du --summarize -c'
function duS
	du --summarize -c $argv | sort -h
end
alias dul 'sudo du --summarize -h -c /var/log/* | sort -h'

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
set -gx LESSOPEN "| /usr/bin/src-hilite-lesspipe.sh %s"
# another way to do it
alias vm 'vim -u ~/.vimrc.more'
# color in man page
set -gx MANPAGER 'less -s -M +Gg'
# color in man page and less
# without this line, the LESS_TERMCAP_xxx won't work in Fedora
set -gx GROFF_NO_SGR yes
# nums are explained at
# http://www.tuxarena.com/2012/04/tutorial-colored-man-pages-how-it-works/
set -gx LESS_TERMCAP_me \e'[0m' 	# turn off all appearance modes (mb, md, so, us)
set -gx LESS_TERMCAP_se \e'[0m' 	# leave standout mode
set -gx LESS_TERMCAP_ue \e'[0m' 	# leave underline mode
set -gx LESS_TERMCAP_so \e'[01;44m' # begin standout-mode – info
set -gx LESS_TERMCAP_mb \e'[01;31m' # enter blinking mode
set -gx LESS_TERMCAP_md \e'[01;38;5;75m' # enter double-bright mode
set -gx LESS_TERMCAP_us \e'[04;38;5;200m' # enter underline mode
#########################################
# Colorcodes:
# Black       0;30     Dark Gray     1;30
# Red         0;31     Light Red     1;31
# Green       0;32     Light Green   1;32
# Brown       0;33     Yellow        1;33
# Blue        0;34     Light Blue    1;34
# Purple      0;35     Light Purple  1;35
# Cyan        0;36     Light Cyan    1;36
# Light Gray  0;37     White         1;37
#########################################

# gcc
alias gcc-w 'gcc -g -Wall -W -Wsign-conversion'
alias gcc-a 'gcc -g -ansi -pedantic -Wall -W -Wconversion -Wshadow -Wcast-qual -Wwrite-strings'
# gcc -Wall -W -Wextra -Wconversion -Wshadow -Wcast-qual -Wwrite-strings -Werror

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
alias dt 'dtrx -v '

alias wget 'wget -c '
alias wgets 'wget -c --mirror -p --html-extension --convert-links'
alias wt 'rm -rf /tmp/QQ*; wget -c -P /tmp/ http://dlsw.baidu.com/sw-search-sp/soft/3a/12350/QQ5.2.10432.0.1395280771.exe; rm -rf /tmp/QQ*'
alias rpm 'sudo rpm'

# yum
alias yum 'sudo yum -C --noplugins ' # not update cache
alias yin 'sudo yum install '
alias yr 'sudo yum remove '
alias yud 'sudo yum update --exclude=kernel\* '
alias yca 'sudo yum clean all -v'
alias yug 'sudo yum --exclude=kernel\* upgrade ' # this line will be '=kernel*' in bash
alias yuk 'sudo yum upgrade kernel\*'
alias yul 'sudo yum history undo last'
alias yl 'sudo yum history list'
alias yu 'sudo yum history undo'

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
alias cdc 'cd ~/Projects/CWork; lsh'
alias cds 'cd ~/Projects/CWork/snippets; lsh'
alias cdP 'cd ~/Projects'
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
alias dif 'icdiff'

function mkcd --description 'mkdir dir then cd dir'
	mkdir -p $argv
	cd $argv
end

# xclip, get content into clipboard, echo file | xclip
alias xp 'xclip'
alias x 'xclip -selection c'

# return tmux
alias t 'tmux a'

# use C-t to go back/in tumx/normal when using non-tmux
function fish_user_key_bindings
	bind \ct 'tmux a'
end

alias tl 'tmux ls'
# kill the specific session like: tk 1
alias tk 'tmux kill-session -t '
# kill all the sessions
alias tka 'tmux kill-server'
# reload ~/.tmux.conf to make it work after editing config file
alias tsr 'tmux source-file ~/.tmux.conf'
alias tt 'tmux switch-client -t '

alias km 'sudo kermit'

alias dusc 'dus -c ~/.config/google-chrome ~/.cache/google-chrome ~/.mozilla ~/.cache/mozilla '
alias gcp 'google-chrome --incognito'
alias ffp 'firefox -private-window'

alias cx 'chmod +x '

# netease-play, douban.fm
alias np 'netease-player '
alias db 'douban.fm '

#vim
alias v 'vim --noplugin'
alias vc 'vim ~/.cgdb/cgdbrc'
alias vf 'vim ~/.fishrc'
alias vv 'vim ~/.vimrc'
alias vb 'vim ~/.bashrc'
alias ve 'vim ~/.emacs.d/init.el'
alias vt 'vim ~/.tmux.conf'
alias v2 'vim ~/Recentchange/TODO'
# emacs
# -Q = -q --no-site-file --no-splash, which will not load something like emacs-googies
alias emq 'emacs -q --no-splash'
alias emx 'emacs -nw -q --no-splash --eval "(setq find-file-visit-truename t)"'
alias emn 'emacs --no-desktop'
function emd --description 'remove .emacs.d/init.elc then $ emacs --debug-init'
	rm -rf ~/.emacs.d/init.elc
	emacs --debug-init
end
alias e  'emx '
alias ei 'emx ~/.emacs.d/init.el'
alias ec 'emx ~/.cgdb/cgdbrc'
alias ef 'emx ~/.fishrc'
alias ev 'emx ~/.vimrc'
alias eb 'emx ~/.bashrc'
alias ee 'emx ~/.emacs.d/init.el'
# alias et 'emx ~/.tmux.conf'
alias e2 'emx ~/Recentchange/TODO'

function fsr --description 'Reload your Fish config after configuration'
	set i $PWD
	source ~/.config/fish/config.fish # fsr
	cd $i
end

# the gpl.txt can be gpl-2.0.txt or gpl-3.0.txt
alias lic 'wget -q http://www.gnu.org/licenses/gpl.txt -O LICENSE'

# git
alias gs 'git status ' # gs is original Ghostscript app
alias gp 'git pull -v'
alias gc 'git clone -v'
alias gl 'git log '
alias glp 'git log -p -- ' # how entire file(even renamed) in history
alias glo 'git log --oneline'
alias gb 'git branch'
alias gco 'git checkout'
alias gcl 'git config -l'
alias gt 'git tag'
function gpa --description 'git pull all in dir using `fing dir`'
	for i in (find $argv[1] -type d -name .git | sort | xargs realpath)
		cd $i; cd ../
		pwd
		git pull -v;
		echo -----------------------------
		echo
	end
end

alias hs 'sudo cp -v ~/Public/hosts /etc/hosts'

# okular
alias ok 'okular '

alias ag "ag --pager='less -RM -FX -s'"
function age --description 'ag sth. in ~/.emacs.d/init.el'
	ag $argv[1] ~/.emacs.d/init.el
end
function agf --description 'ag sth. in ~/.fishrc'
	ag $argv[1] ~/.fishrc
end
function ag2 --description 'ag sth. in ~/Recentchange/TODO'
	ag $argv[1] ~/Recentchange/TODO
end

alias cl 'cloc '
alias cll 'cloc --by-file-by-lang '

alias st 'stow --verbose'

# percol
set -gx CD_HISTORY_FILE $HOME/.cd_history_file
function cdd --description 'percol_cd_history'
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
# C-s goto the dir history, this doesn't work
# percol_cd_history cannot be binded into a key
function fish_user_key_bindings
	bind \cs percol_cd_history
end

echo $PWD >> $CD_HISTORY_FILE

#function percol_command_history
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

alias ptp 'ptpython'

#alias rea 'sudo ~/.local/bin/reaver -i mon0 -b $argv[1] -vv'
# function rea
# sudo ~/.local/bin/reaver -i mon0 -b $argv
# end

alias epub 'ebook-viewer --detach'
alias time 'time -p'
alias bc 'bc -lq'
