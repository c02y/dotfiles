# alias/function definitions.
# Make sure the following line is in ~/.bashrc to use this file
# [ -f ~/.bash_aliases ] && . ~/.bash_aliases

######################################## start
# ingnore duplicates(continuous occurrences od a command) in history
export HISTCONTROL=ignoredups
# ignore some commands showing in history
# export HISTIGNORE="pwd:ls:la:ll:kill:killall:more:cd:"
# Enable huge history
export HISTFILESIZE=9999999999
export HISTSIZE=9999999999
# Save timestamp info for every command
export HISTTIMEFORMAT="[%F %T] ~~~ "
# Dump the history file after every command
shopt -s histappend
export PROMPT_COMMAND="history -a;"
# Preload the working directory history list from the directory history
if type -t hd >/dev/null && type -t cd_func >/dev/null; then
	for x in `hd 20` `pwd`; do cd_func $x ; done
fi

# export PATH=~/.local/bin:~/anaconda3/bin:$PATH
# or
export PATH=$PATH:~/.local/bin:~/anaconda3/bin

export PAGER='less -iXFR -x4 -M'
export EDITOR='vim'
# disable Ctrl-d to EXIT
set -o ignoreeof # 10 times until exiting

alias x='exit'
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

# User specific aliases and functions
# alias ima='gwenview'
alias ima='ristretto '
alias ka='killall'
alias his='history'
# alias bw='ssh -qTfnN -D 7070 -p 443 hei1000@216.194.70.6'
alias bw='ssh -qTfnN -D 7070 hei1000@216.194.70.6'

alias rm='rm -vir'
alias cp='cp -vi'
alias mv='mv -vi'

alias less='less -iXFR -x4 -M'
alias grep='grep --color=auto'
alias findt='find ./* -name "*~"; find ./* -name "\#*"'
alias ftr='find ./* -name "*~" | xargs rm -rfv; find ./* -name "\#*" | xargs rm -rfv'

# ps
alias psg='ps -ef | grep -v grep | grep '

alias du='du -h'
alias dus='du --summarize'
alias duS='du -sk * | sort -n'
alias watd='watch -d du --summarize'
alias df='df -h'

# git
alias gg='tig'
alias ggl='tig log'
alias ggs='tig status'
alias ggr='tig refs'
alias gits='git status' # gs is original Ghostscript app
alias gitpl='git pull'
alias gitpu='git push -v'
alias gitl='git log --stat'
alias gitd='git diff'           # show unstaged local modification
alias gitdc='git diff --cached' # show staged bu unpushed local modification
alias gitlp='git log -p --' # [+ file] to how entire all/[file(even renamed)] history
alias gitsh='git show' # [+ COMMIT] to show the modifications in a last/[specific] commit
alias gitlo='git log --oneline'
alias gitb='git branch -vv'
alias gitbl='git ls-remote'
alias gitblg='git ls-remote | grep -i'
alias gitcl='git config -l'
alias gitcp='git checkout HEAD^1' # git checkout previous/old commit
alias gitcn='git log --reverse --pretty=%H master | grep -A 1 (git rev-parse HEAD) | tail -n1 | xargs git checkout' # git checkout next/new commit
alias gitcm='git commit -m'
alias gitcma='git commit -amend -m'
alias gitt='git tag'
alias gitft='git ls-files --error-unmatch' # Check if file/dir is git-tracked

# gcc
alias gcc-w='gcc -Wall -W'
alias gcc-a='gcc -ansi -pedantic -Wall -W -Wconversion -Wshadow -Wcast-qual -Wwrite-strings'

alias emq='emacs -q'
alias emx='emacs -nw'
alias emd='rm -rf ~/.emacs.elc && emacs --debug-init'
alias emn='emacs --no-desktop'

# j for .bz2, z for .gz, J for xz, a for auto determine
alias t-ta='tar tvfa' # show the content
alias t-xa='tar xvfa' # extract the content
alias t-ca='tar cvfa' # create a tar.xxx

alias wgets='wget --mirror -p --html-extension --convert-links'
alias wt='wget -P /tmp/  http://softdownload.hao123.com/hao123-soft-online-bcs/soft/Q/2013-11-01_QQ2013SP4.exe'

# systemd-analyze
alias sab='systemd-analyze blame; systemd-analyze time'

function mkcd () { mkdir -p "$@" ; eval cd "\"\$$#\"";}

alias diff-s='diff -y --suppress-common-line '
# function diff-s () { diff -s --suppress-common-line "$@" | more -N;}
function diff-y () { diff -y "$@" | more -N;}

vim_version=$(/bin/vim --version | head -1 | grep -o '[0-9]\.[0-9]')
if [ 1 -eq "$(echo "${vim_version} >= 8" | bc)" ]; then
	alias vim='nvim'
fi

function zz()
{
	if [ -f ~/.config/fish/functions/z.lua ]; then
		eval "$(lua ~/.config/fish/functions/z.lua --init bash once echo fzf)"
		if hash fzf 2>/dev/null; then
			if [ $# -eq 0 ]; then
				z -I .
			else
				z -I $@
			fi
		else
			if [ $# -eq 0 ]; then
				z -i .
			else
				z -i $@
			fi
		fi
	else
		echo "z.lua is not installed!"
		exit
	fi
}

function lls()
{
	if [ $# -eq 0 ]; then
		ls -lhA --color=yes . --sort=time --time=ctime | nl -v 0 | sort -nr | tail -20
	else
		ls -lhA --color=yes $@ --sort=time --time=ctime | nl -v 0 | sort -nr | tail -20
	fi
}

function finds()
{
	if [ $# -eq 2 ]; then
		find $1 -iname "*$2*"
	else
		find . -iname "*$1*"
	fi
}

function lsx()
{
	if test $DISPLAY; then
		if [ -f $@ ] || [ -d $@ ]; then
			readlink -fn $@ | xclip -selection c
			readlink -f $@
			echo ---- Path copied to Clipbaord! ----
		fi
	else
		readlink -f $@
	fi
}

######################################## end
