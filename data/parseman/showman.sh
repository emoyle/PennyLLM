#/usr/bin/bash

#set -o pipefail

if [ $# -lt 1 ] ; then
	echo "Usage: $0 <package>" >&2
	exit 22 # "Errno 22 is "Invalid Argument"
fi

for package in "$@" ; do
	if ! isinstalled $package >/dev/null 2>&1  ; then
		echo "Package not installed.  Installing..."
		sudo apt install $package -y
		echo "-------------------INSTALLATION COMPLETE------------------"
	fi
	dpkg -L $package | grep "/usr/share/man" | sed "s/(.*//"
done

	
