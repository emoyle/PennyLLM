#!/usr/bin/bash

if [[ $# -lt 1 ]] ; then
	echo "Usage: $0 <package>"
	exit 1
fi

if dpkg-query -W -f='${status}' $1 2>/dev/null | grep -q "install ok installed"; then
	echo "$1 is installed" >&2
	exit 0
else
	echo "$1 is NOT installed" >&2
	exit 1
fi
