#!/bin/bash

cur=$(i3-msg -t get_workspaces \
  | jq '.[] | select(.focused==true).name' \
  | cut -d"\"" -f2)

if [ "$2" == "up" ]; then
    final=$(($cur+3))
elif [ "$2" == "down" ]; then
    final=$(($cur-3))
else
    floor=`echo "($cur-1)/3" | bc`
    max=$(($floor > 0 ? $floor : 0))
    mult=$(($max*3))
    final=$(($mult+$2))
fi

if [ "$1" == "go" ]; then
    i3-msg workspace $final
elif [ "$1" == "move" ]; then
    i3-msg move container to workspace $final  
    i3-msg workspace $final
fi
