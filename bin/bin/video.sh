#!/bin/bash

if [[ -f ~/output.mp4 ]]
    then
        n=1
        while [[ -f $HOME/output_$n.mp4 ]]
        do
            n=$((n+1))
        done
        filename="$HOME/output_$n.mp4"
    else
        filename="$HOME/output.mp4"
fi

# ffmpeg -y \
# -loglevel debug \
# -f x11grab \
# -s 1920x1080 \
# # -s 3840x1080 \
# # -s $(xdpyinfo | grep dimensions | awk '{print $2;}') \
# -i :0.0 \
# -c:v h264_nvenc $filename

# records the main screen
ffmpeg -loglevel debug -f x11grab -s 1920x1080 -i :0.0+1920,0 -c:v h264_nvenc $filename

# cant encode full screen
