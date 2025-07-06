#!/bin/bash

# Enable Nvidia GPU support if detected
if which nvidia-smi && [ "${DISABLE_ZINK}" == "false" ]; then
  export LIBGL_KOPPER_DRI2=1
  export MESA_LOADER_DRIVER_OVERRIDE=zink
  export GALLIUM_DRIVER=zink
fi

# Disable sleep and power off
setterm blank 0
setterm powerdown 0

# Disable screen lock
if [ ! -f $HOME/.config/kscreenlockerrc ]; then
  kwriteconfig6 --file $HOME/.config/kscreenlockerrc --group Daemon --key Autolock false
fi
if [ ! -f $HOME/.config/kdeglobals ]; then
  kwriteconfig6 --file $HOME/.config/kdeglobals --group KDE --key LookAndFeelPackage org.fedoraproject.fedora.desktop
fi

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

# Background perm loop
if [ ! -d $HOME/.config/kde.org ]; then
  (
    loop_end_time=$((SECONDS + 30))
    while [ $SECONDS -lt $loop_end_time ]; do
        find "$HOME/.cache" "$HOME/.config" "$HOME/.local" -type f -perm 000 -exec chmod 644 {} + 2>/dev/null
        sleep .1
    done
  ) &
fi

# Create startup script if it does not exist (keep in sync with openbox)
STARTUP_FILE="${HOME}/.config/autostart/autostart.desktop"
if [ ! -f "${STARTUP_FILE}" ]; then
  echo "[Desktop Entry]" > $STARTUP_FILE
  echo "Exec=bash /config/.config/openbox/autostart" >> $STARTUP_FILE
  echo "Icon=dialog-scripts" >> $STARTUP_FILE
  echo "Name=autostart" >> $STARTUP_FILE
  echo "Path=" >> $STARTUP_FILE
  echo "Type=Application" >> $STARTUP_FILE
  echo "X-KDE-AutostartScript=true" >> $STARTUP_FILE
  chmod +x $STARTUP_FILE
fi

# Stat DE
unset LD_PRELOAD
/usr/bin/startplasma-x11 > /dev/null 2>&1
