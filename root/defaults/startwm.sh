#!/bin/bash

# Enable Nvidia GPU support if detected
if which nvidia-smi; then
  export LIBGL_KOPPER_DRI2=1
  export MESA_LOADER_DRIVER_OVERRIDE=zink
  export GALLIUM_DRIVER=zink
fi

# Disable sleep and power off
setterm blank 0
setterm powerdown 0

# Create user directories
for dir in Desktop Documents Downloads Music Pictures Public Templates Videos; do
  [ -d "${HOME}/$dir" ] || mkdir -p "${HOME}/$dir"
done

# Set up XDG user directories
export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_PUBLICSHARE_DIR="$HOME/Public"
export XDG_TEMPLATES_DIR="$HOME/Templates"
export XDG_VIDEOS_DIR="$HOME/Videos"
xdg-user-dirs-update

# Stat DE
/usr/bin/dbus-launch /usr/bin/xfce4-session > /dev/null 2>&1
