#!/bin/bash

setterm blank 0
setterm powerdown 0

# change gnome settings
gsettings set org.gnome.desktop.lockdown disable-lock-screen true
gsettings set org.gnome.desktop.lockdown disable-log-out true
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 0

# set session
export XDG_SESSION_TYPE=x11
export DESKTOP_SESSION=zorin-xorg
export XDG_CURRENT_DESKTOP=zorin:GNOME
export XDG_DATA_DIRS=/usr/local/share:/usr/share
export $(dbus-launch)

# set user folders
mkdir -p /config/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos}

export XDG_DESKTOP_DIR=/config/Desktop
export XDG_DOCUMENTS_DIR=/config/Documents
export XDG_DOWNLOAD_DIR=/config/Downloads
export XDG_MUSIC_DIR=/config/Music
export XDG_PICTURES_DIR=/config/Pictures
export XDG_PUBLICSHARE_DIR=/config/Public
export XDG_TEMPLATES_DIR=/config/Templates
export XDG_VIDEOS_DIR=/config/Videos
xdg-user-dirs-update

# launch DE
/usr/bin/gnome-shell --x11 -r > /dev/null 2>&1
