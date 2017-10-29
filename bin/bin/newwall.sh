#!/bin/bash

orig=$HOME/wallpapers
des=$HOME/.wallpapers

while getopts ":f:" opt; do
	case $opt in
		f)
			rm -f $des/*.jpg
			rm -f $des/*.png
			cp $OPTARG $des >&2
			;;
		\?)
			echo "invalid option: -$OPTARG" >&2
			exit 1
			;;
		:)
			echo "option -$OPTARG requires an argument" >&2
			exit 1
			;;
	esac
done
