#!/bin/bash

folder=$1
orig=$HOME/wallpapers
des=$HOME/.wallpapers

if [[ -n "$folder" ]]; then
    rm -f $des/*.jpg
    rm -f $des/*.png
    cp $orig/$folder/* $des
else
    echo "argument error"
fi
