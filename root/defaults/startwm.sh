#!/bin/bash

setterm blank 0
setterm powerdown 0

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


# launch de
/usr/bin/cinnamon-session > /dev/null 2>&1
