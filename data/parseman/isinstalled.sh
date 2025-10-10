#!/usr/bin/bash

if [[ $# -lt 1 ]] ; then
	echo "Usage: $0 <package>"
	exit 1
fi

# Check imports
IMPORTS="dpkg-query grep"
for cmd in $IMPORTS; do
	if ! command -v "$cmd" >/dev/null 2>&1; then
		echo "ERROR. Script \"$0\" requires command \"$cmd\" to operate."
		exit 3 # Errno 3 is "No such process"
	fi
done

if dpkg-query -W -f='${status}' $1 2>/dev/null | grep -q "install ok installed"; then
	echo "$1 is installed" >&2
	exit 0
else
	echo "$1 is NOT installed" >&2
	exit 1
fi
