FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy

# set labels
ARG IMAGE_BUILD_DATE
LABEL maintainer="tibor309"
LABEL org.opencontainers.image.authors="tibor309"
LABEL org.opencontainers.image.created="${IMAGE_BUILD_DATE}"
LABEL org.opencontainers.image.title="Webtop"
LABEL org.opencontainers.image.description="Linux desktop accessible trough a web browser."
LABEL org.opencontainers.image.source=https://github.com/tibor309/webtop
LABEL org.opencontainers.image.url=https://github.com/tibor309/webtop/packages
LABEL org.opencontainers.image.licenses=GPL-3.0
LABEL org.opencontainers.image.base.name="ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy"

# title
ENV TITLE="Zorin OS Core"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

# prevent Ubuntu's firefox from being installed and prioritize zorin packages
COPY /root/etc/apt/preferences.d/firefox-no-snap /etc/apt/preferences.d/firefox-no-snap
COPY /root/etc/apt/preferences.d/zorin-os-patches.pref /etc/apt/preferences.d/zorin-os-patches.pref
COPY /root/etc/apt/preferences.d/zorinos-patches.pref /etc/apt/preferences.d/zorinos-patches.pref

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /kclient/public/icon.png \
    https://raw.githubusercontent.com/tibor309/icons/main/icons/zorin/zorin_blue.png && \
  curl -o \
    /kclient/public/favicon.ico \
    https://raw.githubusercontent.com/tibor309/icons/main/icons/zorin/zorin_blue_favicon.ico && \
  echo "**** add package sources ****" && \
  add-apt-repository -y ppa:mozillateam/ppa && \
  add-apt-repository ppa:zorinos/patches && \
  add-apt-repository ppa:zorinos/stable && \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install --no-install-recommends -y \
    dbus-x11 \
    fonts-zorin-os-core \
    language-pack-en-base \
    language-pack-gnome-en \
    mesa-utils \
    xdg-desktop-portal \
    zorin-os-desktop \
    zorin-os-default-settings \
    zorin-os-wallpapers \
    zorin-icon-themes \
    zorin-desktop-themes \
    zorin-sound-theme \
    adwaita-icon-theme \
    gnome-shell \
    gnome-shell-extensions-zorin-desktop \
    gnome-control-center \
    gnome-online-accounts \
    gnome-system-monitor \
    gnome-terminal \
    gnome-calculator \
    gnome-clocks \
    gnome-calendar \
    nautilus \
    nautilus-extension-gnome-terminal \
    zorin-appearance \
    zorin-appearance-layouts-shell-core \
    alacarte \
    firefox \
    rhythmbox \
    gedit \
    eog \
    evince \
    totem && \
  echo "**** remove un-needed packages ****" && \
  apt-get remove -y \
    gnome-software \
    gnome-software-common \
    power-profiles-daemon \
    snapd && \
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /config/.cache \
    /config/.launchpadlib \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000
VOLUME /config
