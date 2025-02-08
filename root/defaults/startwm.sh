#!/bin/bash

# Enable Nvidia GPU support if detected
if which nvidia-smi; then
  export LIBGL_KOPPER_DRI2=1
  export MESA_LOADER_DRIVER_OVERRIDE=zink
  export GALLIUM_DRIVER=zink
fi

setterm blank 0
setterm powerdown 0

# disable screen lock
if [ ! -f /config/.config/kscreenlockerrc ]; then
  kwriteconfig5 --file /config/.config/kscreenlockerrc --group Daemon --key Autolock false
fi

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

# launch de
/usr/bin/dbus-launch /usr/bin/startplasma-x11 > /dev/null 2>&1
