#!/bin/bash
#
# https://github.com/riboseinc/checkpatch
# dl-checkpatch.sh
#
# Use this script to fetch the latest checkpatch.pl from GitHub

readonly CHECKPATCH_SCRIPT="checkpatch.pl"
readonly SPELLING_TXT="spelling.txt"
readonly CONST_STRUCTS="const_structs.checkpatch"

readonly KERNEL_RAW_URL="https://raw.githubusercontent.com/torvalds/linux/master"
readonly CHECKPATCH_URL="${KERNEL_RAW_URL}/scripts/${CHECKPATCH_SCRIPT}"
readonly SPELLING_URL="${KERNEL_RAW_URL}/scripts/${SPELLING_TXT}"
readonly CONST_STRUCTS_URL="${KERNEL_RAW_URL}/scripts/${CONST_STRUCTS}"

for download in "${CHECKPATCH_URL}:${CHECKPATCH_SCRIPT}" "${SPELLING_URL}:${SPELLING_TXT}" "${CONST_STRUCTS_URL}:${CONST_STRUCTS}"; do
	echo "Downloading '${download##*:}'..."
	curl -f "${download%:*}" -s -S -O || \
		exit 1
done

chmod 755 "${CHECKPATCH_SCRIPT}"
