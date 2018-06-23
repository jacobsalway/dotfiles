#!/bin/bash
FULL=$1
BACKUPDIR=/media/backup

if [[ "$FULL" == "full" ]]; then
    NEW="fullbackup-$(date +\%d\%m\%Y_T\%H\%M\%S)"
else
    NEW="backup-$(date +\%d\%m\%Y_T\%H\%M\%S)"
fi

OLD=$(ls -1 $BACKUPDIR | sort -t_ -k2.5nr,2 -k2.3nr,2 -k2.1nr,2 -k3r | head -1)

mkdir $BACKUPDIR/$NEW

if [[ -n "$OLD" && -d "$BACKUPDIR/$OLD" && "$FULL" != "full" ]]; then
    sudo rsync -av --delete /home/$USER /etc $BACKUPDIR/$NEW --exclude Music --exclude .cache --link-dest=$BACKUPDIR/$OLD
else
    sudo rsync -av --delete /home/$USER /etc $BACKUPDIR/$NEW --exclude Music --exclude .cache
fi

pacman -Q > $BACKUPDIR/$NEW/packages.txt
