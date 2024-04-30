FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntunoble

# set labels
LABEL maintainer="tibor309"

# title
ENV TITLE="Ubuntu"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

# prevent Ubuntu's firefox and thunderbird stub from being installed
COPY /root/etc/apt/preferences.d/firefox-no-snap /etc/apt/preferences.d/firefox-no-snap

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /kclient/public/icon.png \
    https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/webtop-logo.png && \
  echo "**** install packages ****" && \
  add-apt-repository -y ppa:mozillateam/ppa && \
  apt-get update && \
  apt-get install --no-install-recommends -y \
    dbus-x11 \
    fonts-ubuntu \
    language-pack-en-base \
    language-pack-gnome-en \
    mesa-utils \
    xdg-desktop-portal \
    ubuntu-desktop \
    ubuntu-settings \
    ubuntu-keyring \
    ubuntu-wallpapers \
    ubuntu-docs \
    gnome-desktop \
    gnome-desktop3-data \
    gnome-shell \
    gnome-menus \
    gnome-user-docs \
    gnome-accessibility-themes \
    gnome-themes-extra \
    gnome-themes-extra-data \
    yaru-theme-gnome-shell \
    yaru-theme-gtk \
    yaru-theme-icon \
    yaru-theme-sound \
    gnome-terminal \
    nautilus-extension-gnome-terminal \
    gnome-control-center \
    gnome-online-accounts \
    gnome-text-editor \
    gnome-system-monitor \
    totem \
    gnome-calculator \
    gnome-clocks \
    gnome-calendar \
    firefox \
    eog \
    evince \
    rhythmbox \
    gnome-tweaks && \
  echo "**** remove un-needed packages ****" && \
  apt-get remove -y \
    gnome-power-manager \
    gnome-bluetooth && \
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
