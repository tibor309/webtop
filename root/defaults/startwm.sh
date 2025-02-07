#!/bin/bash

# Enable Nvidia GPU support if detected
if which nvidia-smi; then
  export LIBGL_KOPPER_DRI2=1
  export MESA_LOADER_DRIVER_OVERRIDE=zink
  export GALLIUM_DRIVER=zink
fi

setterm blank 0
setterm powerdown 0

# change cinnamon settings
gsettings set org.cinnamon.desktop.lockdown disable-lock-screen true
gsettings set org.cinnamon.desktop.lockdown disable-log-out true
gsettings set org.cinnamon.desktop.screensaver lock-enabled false
gsettings set org.cinnamon.desktop.session idle-delay 0

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


/usr/bin/cinnamon-session > /dev/null 2>&1