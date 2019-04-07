#! /bin/bash
# This is not the perfect version, in OF variable

if [ -z "$1" ]; then
	echo usage: $0 source_dir
	exit
fi

echo NOTE: This is not the perfect version.

SRCD=$1
TGTD=/tmp/
OF=home-$(date +%Y%m%d).tar.bz2
tar cfj $TGTD$OF $SRCD

echo *****Backup done*****

echo The archive file is $TGTD$OF
