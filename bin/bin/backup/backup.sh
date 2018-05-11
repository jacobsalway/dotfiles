#!/bin/bash

BACKUPDIR=/media/hdd/backups
NEW="backup-$(date +\%d\%m\%Y_T\%H\%M\%S)"
OLD=$(ls -1 $BACKUPDIR | sort -t_ -k2.5nr,2 -k2.3nr,2 -k2.1nr,2 -k3r | head -1)

mkdir $BACKUPDIR/$NEW

if [[ -n "$OLD" && -d "$BACKUPDIR/$OLD" ]]; then
    sudo rsync -av --delete /home/$USER /etc/X11 /etc/systemd /media/hdd/backups/$NEW --exclude Music --exclude .cache --link-dest=$BACKUPDIR/$OLD
else
    sudo rsync -av --delete /home/$USER /etc/X11 /etc/systemd /media/hdd/backups/$NEW --exclude Music --exclude .cache
fi

pacman -Q > /media/hdd/backups/$NEW/packages.txt
