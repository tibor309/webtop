FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntunoble

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
ENV TITLE="Ubuntu"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

# prevent Ubuntu's firefox stub from being installed
COPY /root/etc/apt/preferences.d/firefox-no-snap /etc/apt/preferences.d/firefox-no-snap

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /kclient/public/icon.png \
    https://raw.githubusercontent.com/tibor309/icons/main/icons/ubuntu/ubuntu_cof_logo_256x256.png && \
  curl -o \
    /kclient/public/favicon.ico \
    https://raw.githubusercontent.com/tibor309/icons/main/icons/ubuntu/ubuntu_cof_icon_32x32.ico && \
  echo "**** install packages ****" && \
  add-apt-repository -y ppa:mozillateam/ppa && \
  apt-get update && \
  apt-get install --no-install-recommends -y \
    dbus-x11 \
    fonts-cantarell \
    language-pack-en-base \
    language-pack-gnome-en \
    mesa-utils \
    xdg-desktop-portal \
    vanilla-gnome-desktop \
    vanilla-gnome-default-settings \
    gnome-backgrounds \
    adwaita-icon-theme \
    gnome-shell \
    gnome-control-center \
    gnome-online-accounts \
    gnome-text-editor \
    gnome-system-monitor \
    gnome-console \
    gnome-calculator \
    gnome-clocks \
    gnome-calendar \
    gnome-music \
    nautilus \
    firefox \
    loupe \
    evince \
    totem && \
  echo "**** remove un-needed packages ****" && \
  apt-get remove -y \
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
