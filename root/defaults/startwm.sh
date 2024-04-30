#!/bin/bash

setterm blank 0
setterm powerdown 0

gsettings set org.gnome.desktop.lockdown disable-lock-screen true
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 0

export XDG_SESSION_TYPE=x11
export DESKTOP_SESSION=ubuntu
export GNOME_SHELL_SESSION_MODE=ubuntu
export XDG_CURRENT_DESKTOP=ubuntu:GNOME

sudo service dbus start
export $(dbus-launch)
export XDG_DATA_DIRS=/var/lib/flatpak/exports/share:/config/.local/share/flatpak/exports/share:/usr/local/share:/usr/share

dconf load / < /defaults/gnome.conf

gnome-shell --x11 -r > /dev/null 2>&1
