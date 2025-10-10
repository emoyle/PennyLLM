#/usr/bin/bash

#set -o pipefail

if [ $# -lt 1 ] ; then
	echo "Usage: $0 <package>" >&2
	exit 22 # "Errno 22 is "Invalid Argument"
fi

#Check imports
IMPORTS="dpkg apt"
for cmd in $IMPORTS; do
	if ! command -v "$cmd" >/dev/null 2>&1; then
		echo "ERROR.  Script \"$0\" requires command \"$cmd\" to operate."
		exit 3 #Errno 3 is "No such process"
	fi
done

for package in "$@" ; do
	if ! isinstalled $package >/dev/null 2>&1  ; then
		echo "Package not installed.  Installing..."
		sudo apt install $package -y
		echo "-------------------INSTALLATION COMPLETE------------------"
	fi
	dpkg -L $package | grep "/usr/share/man" | sed "s/(.*//"
done

