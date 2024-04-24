FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy

# set labels
LABEL maintainer="tibor309"
LABEL org.opencontainers.image.description="Browser accessible Ubuntu Cinnamon desktop."
LABEL org.opencontainers.image.source=https://github.com/tibor309/webtop
LABEL org.opencontainers.image.licenses=GPL-3.0

# environment
ENV TITLE="Ubuntu Cinnamon"
ARG  DEBIAN_FRONTEND="noninteractive"

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
  add-apt-repository -y ppa:ubuntucinnamonremix/all && \
  apt-get update -y && \
  apt-get install --no-install-recommends -y \
    firefox \
    ubuntucinnamon-environment \
    ubuntucinnamon-wallpapers \
    yaru-cinnamon-theme-icon \
    yaru-cinnamon-theme-gtk && \
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