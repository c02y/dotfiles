#!/usr/bin/env bash

# bluetoothctl trust 60:AB:D2:0F:72:EB
# bluetoothctl disconnect 60:AB:D2:0F:72:EB

# Simple version to toggle one specific mac of device
function toggle_one() {
	device="60:AB:D2:0F:72:EB"
	if bluetoothctl info "$device" | grep 'Connected: yes' -q; then
		bluetoothctl disconnect "$device"
	else
		timeout 0.1s bluetoothctl connect "$device"
	fi
}

function toggle_all() {
	devices=$(bluetoothctl devices | awk '{print $2}')
	for device in $devices; do
		if bluetoothctl info "$device" | grep 'Connected: yes' -q; then
			bluetoothctl disconnect "$device"
		else
			timeout 0.1s bluetoothctl connect "$device"
			# when device is unavailable, return 1
			# otherwise, it will connect with return code 124
			if [[ $? -eq 124 ]]; then
				# once connect the first device, skip the rest
				break
			fi
		fi
	done
}

toggle_one
