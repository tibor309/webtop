#!/bin/bash

setterm blank 0
setterm powerdown 0

# Enable Nvidia GPU support if detected
if which nvidia-smi; then
  export LIBGL_KOPPER_DRI2=1
  export MESA_LOADER_DRIVER_OVERRIDE=zink
  export GALLIUM_DRIVER=zink
fi

# disable screen lock
if [ ! -f $HOME/.config/kscreenlockerrc ]; then
  kwriteconfig5 --file $HOME/.config/kscreenlockerrc --group Daemon --key Autolock false
fi

# set folder locations
xdg-user-dirs-update --set DESKTOP /config/Desktop
xdg-user-dirs-update --set DOCUMENTS /config/Documents
xdg-user-dirs-update --set DOWNLOAD /config/Downloads
xdg-user-dirs-update --set MUSIC /config/Music
xdg-user-dirs-update --set PICTURES /config/Pictures
xdg-user-dirs-update --set PUBLICSHARE /config/Public
xdg-user-dirs-update --set TEMPLATES /config/Templates
xdg-user-dirs-update --set VIDEOS /config/Videos

# launch de
/usr/bin/dbus-launch /usr/bin/startplasma-x11 > /dev/null 2>&1
