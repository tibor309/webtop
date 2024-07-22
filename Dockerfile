FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy

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
ENV TITLE="Ubuntu Cinnamon"

# environment settings
ARG  DEBIAN_FRONTEND="noninteractive"

# prevent Ubuntu's firefox stub from being installed
COPY /root/etc/apt/preferences.d/firefox-no-snap /etc/apt/preferences.d/firefox-no-snap

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /kclient/public/icon.png \
    https://raw.githubusercontent.com/tibor309/icons/master/icons/ubuntu-cinnamon/ubuntu_cinnamon_logo_256x256.png && \
  curl -o \
    /kclient/public/favicon.ico \
    https://raw.githubusercontent.com/tibor309/icons/master/icons/ubuntu-cinnamon/ubuntu_cinnamon_icon_32x32.ico && \
  echo "**** install packages ****" && \
  add-apt-repository -y ppa:mozillateam/ppa && \
  apt-get update -y && \
  add-apt-repository -y ppa:ubuntucinnamonremix/all && \
  apt-get update -y && \
  apt-get install --no-install-recommends -y \
    fonts-ubuntu \
    ubuntucinnamon-environment \
    ubuntucinnamon-wallpapers \
    yaru-cinnamon-theme-icon \
    yaru-cinnamon-theme-gtk \
    gnome-system-monitor \
    gnome-calculator \
    gnome-calendar \
    gnome-terminal \
    firefox \
    rhythmbox \
    eog \
    gedit \
    evince \
    file-roller \
    celluloid && \
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