#!/bin/bash

folder=$1
orig=$HOME/Wallpapers
des=$HOME/.wallpapers

if [[ -n "$folder" ]]; then
    rm -r $des
    #rm -f $des/*.jpg
    #rm -f $des/*.png
    #cp $orig/$folder/* $des
    ln -s $orig/$folder $des
else
    echo "argument error"
fi
