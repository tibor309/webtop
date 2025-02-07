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
/usr/bin/cinnamon-session > /dev/null 2>&1