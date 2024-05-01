#!/bin/bash

setterm blank 0
setterm powerdown 0

# change gnome settings
gsettings set org.gnome.desktop.lockdown disable-lock-screen true
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 0

# set session
export XDG_SESSION_TYPE=x11
export DESKTOP_SESSION=ubuntu
export GNOME_SHELL_SESSION_MODE=ubuntu
export XDG_CURRENT_DESKTOP=ubuntu:GNOME

# set folder locations
xdg-user-dirs-update --set DESKTOP /config/Desktop
xdg-user-dirs-update --set DOCUMENTS /config/Documents
xdg-user-dirs-update --set DOWNLOAD /config/Downloads
xdg-user-dirs-update --set MUSIC /config/Music
xdg-user-dirs-update --set PICTURES /config/Pictures
xdg-user-dirs-update --set PUBLICSHARE /config/Public
xdg-user-dirs-update --set TEMPLATES /config/Templates
xdg-user-dirs-update --set VIDEOS /config/Videos

export $(dbus-launch)
export XDG_DATA_DIRS=/var/lib/flatpak/exports/share:/config/.local/share/flatpak/exports/share:/usr/local/share:/usr/share

dconf load / < /defaults/gnome.conf

/usr/bin/gnome-shell --x11 -r > /dev/null 2>&1
