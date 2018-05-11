#!/bin/bash

TIME="backup-$(date -I)"

mkdir /media/hdd/backups/$TIME
sudo rsync -avr -o -g --delete /home/$USER /etc/X11 /etc/systemd /media/hdd/backups/$TIME --exclude Music --exclude .cache
pacman -Q > /media/hdd/backups/$TIME/packages.txt
