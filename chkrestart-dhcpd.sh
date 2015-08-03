#!/bin/sh

# Author: paalsteek
# This script restarts isc-dhcp-server if the static config changed

if [ -z "$1" ];
then
	echo "Usage: $0 <file>"
	exit 1
fi
FILENAME=$1

# read mtime from last run
OLDMTIME=`< "$FILENAME".stat`

# get current mtime
NEWMTIME=`stat -L -c '%Y' "$FILENAME"`

if [ $NEWMTIME -gt $OLDMTIME ];
then
	/etc/init.d/isc-dhcp-server restart
	echo "$NEWMTIME" > "$FILENAME".stat
fi
