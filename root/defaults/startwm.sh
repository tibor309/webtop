#!/bin/bash

# Enable Nvidia GPU support if detected
if which nvidia-smi > /dev/null 2>&1 && ls -A /dev/dri 2>/dev/null && [ "${DISABLE_ZINK}" == "false" ]; then
  export LIBGL_KOPPER_DRI2=1
  export MESA_LOADER_DRIVER_OVERRIDE=zink
  export GALLIUM_DRIVER=zink
fi

# Disable sleep and power off
setterm blank 0
setterm powerdown 0

# Change GNOME settings
gsettings set org.gnome.desktop.lockdown disable-lock-screen true
gsettings set org.gnome.desktop.lockdown disable-log-out true
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.session idle-delay 0

# Set up session
export XDG_SESSION_TYPE="x11"
export DESKTOP_SESSION="ubuntu"
export GNOME_SHELL_SESSION_MODE="ubuntu"
export XDG_CURRENT_DESKTOP="ubuntu:GNOME"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export $(dbus-launch)

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
exec dbus-launch --exit-with-session /usr/bin/gnome-shell --x11 -r > /dev/null 2>&1
