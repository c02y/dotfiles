#!/usr/bin/env bash

pgrep xidlehook && pkill xidlehook

# dim the screen
PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"
~/.cargo/bin/xidlehook --detect-sleep --not-when-audio --not-when-fullscreen \
	--timer 1800 "xrandr --output $PRIMARY_DISPLAY --brightness 0" "xrandr --output $PRIMARY_DISPLAY --brightness 1" \
	--timer 7200 "systemctl hibernate" "xrandr --output $PRIMARY_DISPLAY --brightness 1" &
