FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy

# set labels
ARG IMAGE_BUILD_DATE
LABEL maintainer="tibor309"
LABEL org.opencontainers.image.authors="Tibor (https://github.com/tibor309)"
LABEL org.opencontainers.image.created="${IMAGE_BUILD_DATE}"
LABEL org.opencontainers.image.title="Webtop"
LABEL org.opencontainers.image.description="Linux desktop accessible trough a web browser."
LABEL org.opencontainers.image.source="https://github.com/tibor309/webtop"
LABEL org.opencontainers.image.url="https://github.com/tibor309/webtop/packages"
LABEL org.opencontainers.image.licenses="GPL-3.0"
LABEL org.opencontainers.image.documentation="https://github.com/tibor309/webtop/blob/main/README.md"
LABEL org.opencontainers.image.base.name="ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy"
LABEL org.opencontainers.image.base.documentation="https://github.com/linuxserver/docker-baseimage-kasmvnc/blob/master/README.md"

# branding
ENV LSIO_FIRST_PARTY=false

# title
ENV TITLE="Ubuntu Cinnamon"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

# prevent Ubuntu's firefox stub from being installed
COPY /root/etc/apt/preferences.d/mozilla /etc/apt/preferences.d/mozilla

RUN \
  echo "**** add package sources ****" && \
  curl -vSLo \
    /etc/apt/keyrings/packages.mozilla.org.asc \
    https://packages.mozilla.org/apt/repo-signing-key.gpg && \
  echo \
    "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" \
    > /etc/apt/sources.list.d/mozilla.list && \
  add-apt-repository -y ppa:ubuntucinnamonremix/all && \
  echo "**** install packages ****" && \
  apt-get update -y && \
  apt-get install --no-install-recommends -y \
    fonts-ubuntu \
    dbus-x11 \
    xdg-desktop-portal \
    ubuntucinnamon-environment \
    ubuntucinnamon-wallpapers \
    yaru-cinnamon-theme-gtk \
    yaru-cinnamon-theme-icon \
    yaru-theme-icon \
    yaru-theme-sound \
    adwaita-icon-theme \
    gnome-system-monitor \
    gnome-terminal \
    nemo \
    firefox && \
  echo "**** remove un-needed packages ****" && \
  apt-get remove -y \
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