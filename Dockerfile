FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntunoble

# set labels
ARG IMAGE_BUILD_DATE
LABEL maintainer="tibor309"
LABEL org.opencontainers.image.authors="Tibor (https://github.com/tibor309)"
LABEL org.opencontainers.image.created="${IMAGE_BUILD_DATE}"
LABEL org.opencontainers.image.title="Webtop"
LABEL org.opencontainers.image.description="Linux desktop accessible trough a web browser."
LABEL org.opencontainers.image.source="https://github.com/tibor309/webtop"
LABEL org.opencontainers.image.url="https://github.com/tibor309/webtop/packages"
LABEL org.opencontainers.image.vendor="tibor309"
LABEL org.opencontainers.image.base.name="ghcr.io/linuxserver/baseimage-kasmvnc:ubuntunoble"
LABEL org.opencontainers.image.base.documentation="https://github.com/linuxserver/docker-baseimage-kasmvnc/blob/master/README.md"

# branding
ENV LSIO_FIRST_PARTY=false

# title
ENV TITLE="Zorin OS Core"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"

# prevent Ubuntu's firefox stub from being installed
COPY /root/etc/apt/preferences.d/mozilla /etc/apt/preferences.d/mozilla

# add zorin patches
COPY /root/etc/apt/preferences.d/zorin-os-patches.pref /etc/apt/preferences.d/zorin-os-patches.pref
COPY /root/etc/apt/preferences.d/zorinos-patches.pref /etc/apt/preferences.d/zorinos-patches.pref

RUN \
  echo "**** add zorin os package sources ****" && \
  curl -vSL \
    "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xb2228b8cca5c00a2c59d35e530fcf8f64f71b61c" | \
    gpg --dearmor | \
    tee -a /usr/share/keyrings/zorinos-archive-keyring.gpg && \
  echo \
    "deb [signed-by=/usr/share/keyrings/zorinos-archive-keyring.gpg] https://ppa.launchpadcontent.net/zorinos/stable/ubuntu noble main" \
    > /etc/apt/sources.list.d/zorinos-stable.list && \
  echo \
    "deb-src [signed-by=/usr/share/keyrings/zorinos-archive-keyring.gpg] https://ppa.launchpadcontent.net/zorinos/stable/ubuntu noble main" \
    >> /etc/apt/sources.list.d/zorinos-stable.list && \
  echo \
    "deb [signed-by=/usr/share/keyrings/zorinos-archive-keyring.gpg] https://ppa.launchpadcontent.net/zorinos/patches/ubuntu noble main" \
    > /etc/apt/sources.list.d/zorinos-patches.list && \
  echo \
    "deb-src [signed-by=/usr/share/keyrings/zorinos-archive-keyring.gpg] https://ppa.launchpadcontent.net/zorinos/patches/ubuntu noble main" \
    >> /etc/apt/sources.list.d/zorinos-patches.list && \
  echo "**** add mozilla package sources ****" && \
  curl -vSLo \
    /etc/apt/keyrings/packages.mozilla.org.asc \
    https://packages.mozilla.org/apt/repo-signing-key.gpg && \
  echo \
    "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" \
    > /etc/apt/sources.list.d/mozilla.list && \
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
    nautilus \
    nautilus-extension-gnome-terminal \
    zorin-appearance \
    zorin-appearance-layouts-shell-core \
    firefox && \
  echo "**** remove un-needed packages ****" && \
  apt-get remove -y \
    gnome-software \
    gnome-software-common \
    power-profiles-daemon \
    yelp \
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
