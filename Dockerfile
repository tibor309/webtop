FROM ghcr.io/linuxserver/baseimage-kasmvnc:fedora40

# set labels
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version: ${VERSION} Build-date: ${BUILD_DATE}"
LABEL maintainer="tibor309"
LABEL org.opencontainers.image.description="Linux desktop accessible trough a web browser."
LABEL org.opencontainers.image.source=https://github.com/tibor309/webtop
LABEL org.opencontainers.image.url=https://github.com/tibor309/webtop/packages
LABEL org.opencontainers.image.licenses=GPL-3.0

# title
ENV TITLE="Fedora KDE"

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
    xdg-user-dirs \
    plasma-breeze \
    plasma-desktop \
    plasma-workspace-xorg \
    qt5-qtscript \
    breeze-gtk-gtk3 \
    breeze-gtk-gtk4 \
    kde-gtk-config \
    breeze-icon-theme \
    kde-wallpapers \
    kdeplasma-addons \
    plasma-browser-integration \
    kde-settings-pulseaudio \
    kdialog \
    kfind \
    kmenuedit \
    ksystemstats \
    kwrite \
    plasma-systemmonitor \
    konsole5 \
    kcalc \
    dolphin \
    gwenview \
    dragon \
    spectacle \
    firefox && \
  echo "**** kde tweaks ****" && \
  sed -i \
    's/applications:org.kde.discover.desktop,/applications:org.kde.konsole.desktop,/g' \
    /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml && \
  rm -f \
    /etc/xdg/autostart/at-spi-dbus-bus.desktop \
    /etc/xdg/autostart/gmenudbusmenuproxy.desktop \
    /etc/xdg/autostart/polkit-kde-authentication-agent-1.desktop \
    /etc/xdg/autostart/powerdevil.desktop && \
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
