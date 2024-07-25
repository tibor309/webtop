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
export DESKTOP_SESSION=gnome-xorg
export XDG_CURRENT_DESKTOP=GNOME

# create user folders
if [ ! -f "/config/.firstsetup" ]; then
    mkdir -p /config/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos}
    chown abc:abc /config/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos}

    xdg-user-dirs-update --set DESKTOP /config/Desktop
    xdg-user-dirs-update --set DOCUMENTS /config/Documents
    xdg-user-dirs-update --set DOWNLOAD /config/Downloads
    xdg-user-dirs-update --set MUSIC /config/Music
    xdg-user-dirs-update --set PICTURES /config/Pictures
    xdg-user-dirs-update --set PUBLICSHARE /config/Public
    xdg-user-dirs-update --set TEMPLATES /config/Templates
    xdg-user-dirs-update --set VIDEOS /config/Videos

    touch /config/.firstsetup
fi

export $(dbus-launch)
export XDG_DATA_DIRS=/var/lib/flatpak/exports/share:/config/.local/share/flatpak/exports/share:/usr/local/share:/usr/share

dconf load / < /defaults/gnome.conf

/usr/bin/gnome-shell --x11 -r > /dev/null 2>&1
