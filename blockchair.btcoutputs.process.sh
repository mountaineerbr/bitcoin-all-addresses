#!/bin/bash
# sep/2021  by mountaineerbr
# Process blockchair dumps and grep bitcoin addresses.
# Change accordingly. Tested with GNU coreutils.

#blockchair dump files directory
DIRIN="/media/primary/blockchair.outputs.dumps"
#final output directory
DIROUT="/media/primary/blockchair.outputs.dumps/out"
#large temp dir (for `sort`)
export TMPDIR="/media/primary/tmp"

#set C locale (tools work faster)
export LC_ALL=C LANG=C


#pipeline
cd "$DIROUT" || exit
ls -1v "$DIRIN"/*.tsv.gz | xargs -- gunzip -vc | cut -f7 \
	| nl | sort --parallel=3 -k2 -u | sort --parallel=3 -n | cut -f2 \
	| split -C 94000000


#NOTES
#First line of blockchair dumps is header, 7th field is `recipient`.


##extra functions
##sum first column
#sum() { awk '{sum += $1} END {print sum}' ;}

##produce address stats
#IFS=$'\t\n'  #mind blank spaces in file paths
#files=( "$DIROUT"/[a-z][a-z][a-z] )
#IFS=$' \t\n'
#
#uni=$(wc -l "${files[@]}" | awk 'END{ print $1 - 1 }')  #mind one header value (`recipient`)
#a1=$(grep -hc '^1' "${files[@]}" | sum)
#a3=$(grep -hc '^3' "${files[@]}" | sum)
#bc=$(grep -hc '^bc1' "${files[@]}" | sum)
#nn=$(grep -hcF '-' "${files[@]}" | sum)
#
#echo "unique: $uni
#1*: $a1
#3*: $a3
#bc1*: $bc
#*-*: $nn
#check: $((a1+a3+bc+nn)) must be equal to $uni"

