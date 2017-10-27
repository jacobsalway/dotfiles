#!/bin/bash

folder=$1
dir=$HOME/wallpapers

if [[ -n "$folder" ]]; then
    rm -f $dir/*.jpg
    rm -f $dir/*.png
    cp $dir/$folder/* $dir
else
    echo "argument error"
fi
