FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy

# set labels
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version: ${VERSION} Build-date: ${BUILD_DATE}"
LABEL maintainer="tibor309"
LABEL org.opencontainers.image.title=Webtop
LABEL org.opencontainers.image.description=Lubuntu desktop accessible trough a web browser.
LABEL org.opencontainers.image.source=https://github.com/tibor309/webtop
LABEL org.opencontainers.image.url=https://github.com/tibor309/webtop/packages
LABEL org.opencontainers.image.licenses=GPL-3.0

# environment
ENV TITLE="Lubuntu"
ARG DEBIAN_FRONTEND="noninteractive"

# prevent Ubuntu's firefox stub from being installed
COPY /root/etc/apt/preferences.d/firefox-no-snap /etc/apt/preferences.d/firefox-no-snap

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /kclient/public/icon.png \
    https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/webtop-logo.png && \
  echo "**** install packages ****" && \
  add-apt-repository -y ppa:mozillateam/ppa && \
  apt-get update -y && \
  apt-get install --no-install-recommends -y \
    firefox \
    lubuntu-artwork \
    lubuntu-desktop \
    lubuntu-default-settings \
    sddm \
    sddm-theme-lubuntu \
    openbox \
    obconf \
    stterm \
    lxqt-core \
    papirus-icon-theme \
    adwaita-icon-theme-full \
    mime-support \
    qt5-gtk-platformtheme \
    htop \
    qterminal \
    lxqt-archiver \
    featherpad \
    lximage-qt \
    qlipper&& \
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