#!/bin/bash

shopt -s dotglob 
shopt -s nullglob 

test() {
	if [[ $1 = $2 ]]
	then
		if [[ $Type = "-" ]] 
		then
			echo $1
		else
			if [ $Type "$1" ]
			then
				echo $1
			fi
		fi
	fi	
}

search() {
	for f in "$1"/*
	do
	   test "$f" "$1/$Name"	
	done
	
	for f in "$1"/*
	do
		if [[ -d "$f" ]]
		then
			search "$f"
		fi
	done
}

Dir=$1
shift

if [[ -z $Dir ]] 
then
	Dir="."
fi

Name="*"
Type="-"

while [[ $# -ne "0" ]]
do
	if [[ $1 = "-type" ]] 
	then
		shift
		Type="-$1"
	else
		if [[ $1 = "-iname" ]]
		then
			shift
			Name=$1
		fi
	fi	
	shift	
done

test $Dir "$Name"
search $Dir 


