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

# create user folders
if [ ! -f "$HOME/.firstsetup" ]; then
    mkdir -p $HOME/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos}
    chown abc:abc $HOME/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos}

    xdg-user-dirs-update --set DESKTOP $HOME/Desktop
    xdg-user-dirs-update --set DOCUMENTS $HOME/Documents
    xdg-user-dirs-update --set DOWNLOAD $HOME/Downloads
    xdg-user-dirs-update --set MUSIC $HOME/Music
    xdg-user-dirs-update --set PICTURES $HOME/Pictures
    xdg-user-dirs-update --set PUBLICSHARE $HOME/Public
    xdg-user-dirs-update --set TEMPLATES $HOME/Templates
    xdg-user-dirs-update --set VIDEOS $HOME/Videos

    touch $HOME/.firstsetup
fi

export $(dbus-launch)
export XDG_DATA_DIRS=/usr/local/share:/usr/share

# launch DE
/usr/bin/gnome-shell --x11 -r > /dev/null 2>&1
