#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# mpd daemon start
# [ ! -s ~/.config/mpd/pid ] && mpd

# restore background from previous session
exec ~/.fehbg &

if [ -s ~/.Xmodmap ]; then
    xmodmap ~/.Xmodmap
fi

#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=ibus
#export QT_IM_MODULE=ibus

#ibus-daemon -drx

# keyboard repeat rate and screen timeout
xset r rate 220 32
xset s 3600 3600
xset dpms 3600 3600 3600

# restore wal colour scheme
wal -a "78" -b "#000000" -R

# start i3
exec i3
