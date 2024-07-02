FROM ghcr.io/linuxserver/baseimage-kasmvnc:fedora40

# set labels
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version: ${VERSION} Build-date: ${BUILD_DATE}"
LABEL maintainer="tibor309"
LABEL org.opencontainers.image.description="Linux desktop acessible trough a web browser."
LABEL org.opencontainers.image.source=https://github.com/tibor309/webtop
LABEL org.opencontainers.image.url=https://github.com/tibor309/webtop/packages
LABEL org.opencontainers.image.licenses=GPL-3.0

# title
ENV TITLE="Fedora XFCE"

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /kclient/public/icon.png \
    https://raw.githubusercontent.com/tibor309/icons/main/icons/fedora/fedora_logo_256x251.png && \
  curl -o \
    /kclient/public/favicon.ico \
    https://raw.githubusercontent.com/tibor309/icons/main/icons/fedora/fedora_icon_48x48.ico && \
  echo "**** install packages ****" && \
  dnf install -y --setopt=install_weak_deps=False --best \
    firefox \
    mousepad \
    Thunar \
    galculator \
    xarchiver \
    ristretto \
    parole \
    claws-mail \
    xdg-user-dirs \
    desktop-backgrounds-compat \
    greybird-dark-theme \
    greybird-xfwm4-theme \
    adwaita-gtk2-theme \
    adwaita-icon-theme \
    adwaita-cursor-theme \
    gtk-xfce-engine \
    fedora-release-xfce \
    fedora-logos \
    xfce4-about \
    xfce4-appfinder \
    xfce4-datetime-plugin \
    xfce4-panel \
    xfce4-places-plugin \
    xfce4-pulseaudio-plugin \
    xfce4-session \
    xfce4-settings \
    xfce4-terminal \
    xfce4-taskmanager \
    xfce4-screenshooter \
    xfce4-screenshooter-plugin \
    xfconf \
    xfdesktop \
    xfwm4 \
    xfwm4-themes && \
  echo "**** xfce tweaks ****" && \
  rm -f \
    /etc/xdg/autostart/xfce-polkit.desktop && \
  echo "**** cleanup ****" && \
  dnf autoremove -y && \
  dnf clean all && \
  rm -rf \
    /config/.cache \
    /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000
VOLUME /config