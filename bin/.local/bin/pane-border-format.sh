#!/bin/bash
# Modified based on https://www.markneuburger.com/git-statuses-in-tmux-panes/

# read args
for i in "$@"
do
	case $i in
		--path=*)
			PANE_CURRENT_PATH="${i#*=}"
			shift # past argument=value
			;;
		*) # unknown option
			;;
	esac
done

# Replace full path to home directory with ~
PRETTY_PATH=$(echo $PANE_CURRENT_PATH | sed "s:^$HOME:~:")

GIT_PROMPT_PREFIX="("
GIT_PROMPT_SUFFIX=")"
if [ -z $DISPLAY ]; then        # empty, non-GUI
	GIT_PROMPT_AHEAD="A"
	GIT_PROMPT_BEHIND="B"
	GIT_PROMPT_STAGED="S"
	GIT_PROMPT_CONFLICTED='C'
	GIT_PROMPT_UNSTAGED="M"
	GIT_PROMPT_UNTRACKED="N"
	GIT_PROMPT_CLEAN="OK"
else
	GIT_PROMPT_AHEAD="↑"
	GIT_PROMPT_BEHIND="↓"
	GIT_PROMPT_STAGED="●"
	GIT_PROMPT_CONFLICTED='✖'
	GIT_PROMPT_UNSTAGED="✚"
	GIT_PROMPT_UNTRACKED="…"
	GIT_PROMPT_CLEAN="✓"
fi

git_branch () {
	ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
		ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
	echo "${ref#refs/heads/}"
}

git_status () {
	_STATUS=""

	# check status of files
	# using --no-optional-locks to prevent creating index.lock in the background
	# since this script is running in tmux pane-border-format part repeatly
	# if this is not working; set variable GIT_OPTIONAL_LOCKS to 0
	_INDEX=$(command git --no-optional-locks status --porcelain 2> /dev/null)
	if [[ -n "$_INDEX" ]]; then
		if $(echo "$_INDEX" | command grep -q '^[AMRD]. '); then
			_STATUS="$_STATUS$GIT_PROMPT_STAGED"
		fi
		if $(echo "$_INDEX" | command grep -q '^U. '); then
			_STATUS="$_STATUS$GIT_PROMPT_CONFLICTED"
		fi
		if $(echo "$_INDEX" | command grep -q '^.[MTD] '); then
			_STATUS="$_STATUS$GIT_PROMPT_UNSTAGED"
		fi
		if $(echo "$_INDEX" | command grep -q -E '^\?\? '); then
			_STATUS="$_STATUS$GIT_PROMPT_UNTRACKED"
		fi
		if $(echo "$_INDEX" | command grep -q '^UU '); then
			_STATUS="$_STATUS$GIT_PROMPT_UNMERGED"
		fi
	else
		_STATUS="$_STATUS$GIT_PROMPT_CLEAN"
	fi

	# check status of local repository
	# using --no-optional-locks to prevent creating index.lock in the background
	# since this script is running in tmux pane-border-format part repeatly
	# if this is not working; set variable GIT_OPTIONAL_LOCKS to 0
	_INDEX=$(command git --no-optional-locks status --porcelain -b 2> /dev/null)
	if $(echo "$_INDEX" | command grep -q '^## .*ahead'); then
		_STATUS="$_STATUS$GIT_PROMPT_AHEAD"
	fi
	if $(echo "$_INDEX" | command grep -q '^## .*behind'); then
		_STATUS="$_STATUS$GIT_PROMPT_BEHIND"
	fi

	echo $_STATUS
}

git_prompt () {
	local _branch=$(git_branch)
	local _status=$(git_status)
	local _result=""
	if [[ "${_branch}x" != "x" ]]; then
		_result="$GIT_PROMPT_PREFIX$_branch|"
		if [[ "${_status}x" != "x" ]]; then
			_result="$_result$_status"
		fi
		_result="$_result$GIT_PROMPT_SUFFIX"
	fi
	echo $_result
}

echo "\"$PRETTY_PATH\" $(cd $PANE_CURRENT_PATH && git_prompt)"
