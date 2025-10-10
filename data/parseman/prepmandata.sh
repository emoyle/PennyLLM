#!/usr/bin/bash

set -euo pipefail

if [ $# -lt 1 ] ; then # Test for list of packages to parse
	echo "Usage: $0 <filename> [directory]" >&2
	echo "filename - list of packages to extract manual entries" >&2
	echo "directory - OPTIONAL output directory to use for generated data" >&2
	exit 22 #Errno 22 is "Invalid Argument"
fi

# Check imports
IMPORTS="jq mktemp date"
for cmd in $IMPORTS; do
	if ! command -v "$cmd" >/dev/null 2>&1; then
		echo "Error.  Script \"$0\" requires command \"$cmd\" to operate."
		exit 3 #Errno 3 is "No such process"
	fi
done

SOURCE=$1
OUTPUTDIR="manuals"
if [ -f $SOURCE ] ; then # Test if file exists
	echo "Using file $SOURCE for package manifest" >&2
else
	echo "File does not exist.  Aborting" >&2
	exit 2 #Errno 2 is "No such file or directory
fi

if [ $# -eq 2 ] ; then # Seems like they gave us an output directory to work with
	if [ ! -d $2 ] ; then #It doesn't exist. Create it
		echo "Directory $2 doesn't exist.  Creating" >&2
		mkdir $2
	fi
	echo "Using output directory \"$2\" for manual contents." >&2
	OUTPUTDIR=$2

fi

now(){ date -u +"%Y-%m-%dT%H:%M:%SZ"; } #used for timestamps


echo "Iterating through contents of $SOURCE..." >&2
MANIFEST="$OUTPUTDIR/manifext.txt"
while IFS= read -r pkg || [ -n "$pkg" ]; do
	NOW=$(now)
	echo "$NOW: Processing package $pkg" >&2
	OUTFILE="$OUTPUTDIR/""$NOW""_$pkg.man" 
	man $pkg > "$OUTFILE"
	#Creating manifest entry
	tmp="$(mktemp)"
	jq -n \
	  --arg name "$pkg" \
	  --arg out_file "$OUTFILE" \
	  --arg fetched_at "$NOW" \
	  '{
	  name: $name,
	  out_file: $out_file,
	  fetched_at: $fetched_at
  	   }' > "$tmp"
   cat $tmp >> $MANIFEST


done < $SOURCE


