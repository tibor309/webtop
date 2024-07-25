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
export DESKTOP_SESSION=ubuntu
export GNOME_SHELL_SESSION_MODE=ubuntu
export XDG_CURRENT_DESKTOP=ubuntu:GNOME

# Enable Nvidia GPU support if detected
if which nvidia-smi; then
  export LIBGL_KOPPER_DRI2=1
  export MESA_LOADER_DRIVER_OVERRIDE=zink
  export GALLIUM_DRIVER=zink
fi

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
export XDG_DATA_DIRS=/var/lib/flatpak/exports/share:/config/.local/share/flatpak/exports/share:/usr/local/share:/usr/share


/usr/bin/gnome-shell --x11 -r > /dev/null 2>&1
