#!/usr/bin/env bash

source ~/Dotfiles.d/misc/bash_aliases
pgrep xidlehook && pkill xidlehook

PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"

xidlehook --detect-sleep --not-when-audio \
	--timer 1800 "xrandr --output $PRIMARY_DISPLAY --brightness .1" "xrandr --output $PRIMARY_DISPLAY --brightness 1" \
	--timer 7200 "systemctl hibernate" "" &
