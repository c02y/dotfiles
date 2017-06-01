# .bashrc
# https://gist.github.com/redguardtoo/01868d7a13817c9845e8 for more

# disable Ctrl-d to EXIT
set -o ignoreeof # 10 times until exiting

# z -- https://github.com/rupa/z
#. `brew --prefix`/opt/z/etc/profile.d/z.sh

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Python complete
#export PYTHONSTARTUP=~/.pythonrc

# java & Android Studio environment setting
export JAVA_HOME=/usr/lib/jvm/jdk1.7.0_40
export JRE_HOME=${JAVA_HOME}/jre
export CLASSPATH=.:/{JAVA_HOME}/lib:${JRE_HOME}/lib
export PATH=${JAVA_HOME}/bin:$PATH
export PATH=/opt/android-studio/bin:$PATH
export PATH=.local/share/arm-linux/bin:.local/bin:$PATH

# User specific aliases and functions
alias sl='ls'
alias ls='ls --color=auto'
alias lsp='readlink -f' # print the full path of a file
alias lsd='ls -d */' 	# only list directories
alias ll='ls -lh'
alias la='ls -d .??*'
alias lla='ls -lhA'
alias l.='ls -A'
alias lst='clear; ls --sort=time | less'
alias llt='ll --sort=time | less'
alias lat='la --sort=time | less'

#cdls, cdll, cdla
function cdls () { cd "$@" ; eval ls "\"\$$#\"";}
function cdll () { cd "$@" ; eval ll "\"\$$#\"";}
function cdla () { cd "$@" ; eval la "\"\$$#\"";}

# valgrind
# alias va='valgrind -v --track-origins=yes'
alias va='valgrind --track-origins=yes'

# alias ima='gwenview'
alias ima='ristretto '
alias ka='killall'
alias his='history'
# alias bw='ssh -qTfnN -D 7070 -p 443 hei1000@216.194.70.6'
alias bw='ssh -qTfnN -D 7070 hei1000@216.194.70.6'

alias rm='rm -vir'
alias cp='cp -vi'
alias mv='mv -vi'

#alias grep='grep -nr --color=auto'
alias g='grep -F -n --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias findt='find ./* -name "*~"; find ./* -name "\#*"'
alias ftr='find ./* -name "*~" | xargs rm -rfv; find ./* -name "\#*" | xargs rm -rfv'

# ps
alias psg='ps -ef | g '

alias du='du -h'
alias dus='du --summarize'
alias duS='du -sk * | sort -n'
alias watd='watch -d du --summarize'
alias df='df -h'
alias m='more'
alias more='less'
alias less='less -NgmM'

# gcc
alias gcc-w='gcc -Wall -W'
alias gcc-a='gcc -ansi -pedantic -Wall -W -Wconversion -Wshadow -Wcast-qual -Wwrite-strings'

# mpg321 random play
alias mpg321='mpg321 -Z -@mp3'

alias emq='emacs -q'
alias emx='emacs -nw'
alias emd='rm -rf ~/.emacs.elc && emacs --debug-init'
alias emn='emacs --no-desktop'

alias ifw='ifconfig wlan0'
alias nl='nload -u H wlp5s0'
alias tf='traff wlan0'
alias m-c='minicom --color=on'
#alias tree='tree -sh'

# j for .bz2, z for .gz, J for xz, a for auto determine
alias t-tbz2='tar tvfj'
alias t-tgz='tar tvfz'
alias t-txz='tar tvfJ' # show the contents
alias t-ta='tar tvfa' # the above three can just use this one to auto choose the right one
alias t-xbz2='tar xvfj'
alias t-xgz='tar xvfz'
alias t-xxz='tar xvfJ' # extract
alias t-xa='tar xvfa' # the above three can jsut use this one to auto choose the right one
alias t-cbz2='tar cvfj'
alias t-cgz='tar cvfz'
alias t-cxz='tar cvfJ' # compress
alias t-ca='tar cvfa' # the above three can just use this one to auto choose the right one

alias wgets='wget --mirror -p --html-extension --convert-links'
alias wt='wget -P /tmp/  http://softdownload.hao123.com/hao123-soft-online-bcs/soft/Q/2013-11-01_QQ2013SP4.exe'
alias rpm='sudo rpm'

# yum
alias yum='sudo yum -C --noplugins' # not update cache
alias in='sudo yum install '
alias ug='sudo yum upgrade '
alias ud='sudo yum update '
alias ca='sudo yum clean all'
alias uk='sudo yum --exclude=kernel\* upgrade' # this line will be '=kernel*' in bash

# donnot show the other info on startup
alias gdb='gdb -q'

# systemd-analyze
alias sab='systemd-analyze blame; systemd-analyze time'

# cd
alias b='cd'
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../../'
alias ..4='cd ../../../../'
alias ..5='cd ../../../../../'
alias cdi='cd /usr/include/'

alias ex='exit'

# Recursive directory listing
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'''

# function mkcd to mkdir a directory and then cd it
function mkcd () { mkdir -p "$@" ; eval cd "\"\$$#\"";}

#diff-y
alias diff-s='diff -y --suppress-common-line '
# function diff-s () { diff -s --suppress-common-line "$@" | more -N;}
function diff-y () { diff -y "$@" | more -N;}


# export CDPATH=.:~/real6410/uboot/s3c-u-boot-1.1.6-Real6410/:~/real6410/uboot/:~/real6410/:~:

# ingnore duplicates(continuous occurrences od a command) in history
export HISTCONTROL=ignoredups
# ignore some commands showing in history
#export HISTIGNORE="pwd:ls:la:ll:kill:killall:more:cd:"


####################################################################################
## All the following snippet of code is for bash dirs history
# http://nodsw.com/blog/leeland/2012/03/07-all-bash-history-revisited-load-time-solved-plus-directory-history
# this code need ~/.local/bin/acd_func.sh and a_loghistory_func.sh
# created ~/.history-localhost and .history_log.localhost
# USAGE: in a_loghistory_func.sh and acd_func.sh
# 1. cd -- to list the dirs visited
# 2. cd -N to go to the dir, the N is the number signed to the specific dir
# 3. # dump regular history log
# alias h='history'
# 4. # dump enhanced history log
# alias hh="cat ${HOME}/.history_log.${HOSTNAME}"
# 5. # dump history of directories visited
# alias hd="cat ${HOME}/.history_log.${HOSTNAME} | awk -F ' ~~~ ' '{print \$2}' | uniq"
#
# are we an interactive shell?
if [ "$PS1" ]; then

	HOSTNAME=`hostname -s || echo unknown`

	# add cd history function
	[[ -f ${HOME}/.local/bin/acd_func.sh ]] && . ${HOME}/.local/bin/acd_func.sh
	# make bash autocomplete with up arrow
	bind '"\e[A":history-search-backward'
	bind '"\e[B":history-search-forward'
	##################################
	# BEG History manipulation section

	# Don't save commands leading with a whitespace, or duplicated commands
	export HISTCONTROL=ignoredups

	# Enable huge history
	export HISTFILESIZE=9999999999
	export HISTSIZE=9999999999

	# Ignore basic "ls" and history commands
	export HISTIGNORE="ls:ls -al:ll:history:h:h[dh]:h [0-9]*:h[dh] [0-9]*"

	# Save timestamp info for every command
	export HISTTIMEFORMAT="[%F %T] ~~~ "

	# Dump the history file after every command
	shopt -s histappend
	export PROMPT_COMMAND="history -a;"
	[[ -f ${HOME}/.local/bin/a_loghistory_func.sh ]] && . ${HOME}/.local/bin/a_loghistory_func.sh

	# Specific history file per host
	export HISTFILE=$HOME/.history-$HOSTNAME

	save_last_command () {
		# Only want to do this once per process
		if [ -z "$SAVE_LAST" ]; then
			EOS=" # end session $USER@${HOSTNAME}:`tty`"
			export SAVE_LAST="done"
			if type _loghistory >/dev/null 2>&1; then
				_loghistory
				_loghistory -c "$EOS"
			else
				history -a
			fi
			/bin/echo -e "#`date +%s`\n$EOS" >> ${HISTFILE}
		fi
	}
	trap 'save_last_command' EXIT

	# END History manipulation section
	##################################

	# Preload the working directory history list from the directory history
	if type -t hd >/dev/null && type -t cd_func >/dev/null; then
		for x in `hd 20` `pwd`; do cd_func $x ; done
	fi
fi

# added by Anaconda3 4.3.1 installer
export PATH="/home/chz/anaconda3/bin:$PATH"
