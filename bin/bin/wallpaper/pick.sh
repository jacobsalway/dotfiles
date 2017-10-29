#!/bin/bash

#wal -e -a "90" -b "#000000" -i $HOME/.wallpapers

# get random file
feh --bg-fill $(shuf -n1 -e $HOME/.wallpapers/*)
