#!/bin/bash
folder=$1
orig=$HOME/Wallpapers
des=$HOME/.wallpapers

if [[ -n "$folder" ]]; then
    rm -rf $des
    mkdir $des
    if [[ -f $folder ]]; then
        cp $folder $des
    elif [[ -d $folder ]]; then
        cp $folder/* $des
    else
        echo "not valid"
        exit 1
    fi
fi
