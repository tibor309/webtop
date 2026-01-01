FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntunoble

# set labels
ARG IMAGE_BUILD_DATE
LABEL maintainer="tibynx"
LABEL org.opencontainers.image.authors="tibynx"
LABEL org.opencontainers.image.created="${IMAGE_BUILD_DATE}"
LABEL org.opencontainers.image.description="Linux desktop accessible through a web browser."
LABEL org.opencontainers.image.documentation="https://github.com/tibynx/webtop/blob/main/README.md"
LABEL org.opencontainers.image.licenses="GPL-3.0-only"
LABEL org.opencontainers.image.source="https://github.com/tibynx/webtop"
LABEL org.opencontainers.image.title="Webtop"
LABEL org.opencontainers.image.url="https://github.com/tibynx/webtop/packages"
LABEL org.opencontainers.image.vendor="tibynx"
LABEL org.opencontainers.image.base.name="ghcr.io/linuxserver/baseimage-kasmvnc:ubuntunoble"
LABEL org.opencontainers.image.base.documentation="https://github.com/linuxserver/docker-baseimage-kasmvnc/blob/master/README.md"

# branding
ENV LSIO_FIRST_PARTY=false

# title
ENV TITLE="Kubuntu"

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
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install --no-install-recommends -y \
    dbus-x11 \
    xdg-desktop-portal \
    kubuntu-desktop \
    kubuntu-settings-desktop \
    kubuntu-wallpapers \
    breeze-gtk-theme \
    kde-config-gtk-style \
    breeze-icon-theme \
    qml-module-qt-labs-platform \
    plasma-desktop \
    plasma-workspace \
    kwin-addons \
    kwin-x11 \
    plasma-browser-integration \
    kdialog \
    kio-extras \
    knewstuff-dialog \
    khotkeys \
    systemsettings \
    ksystemstats \
    konsole \
    dolphin \
    firefox && \
  echo "**** kde tweaks ****" && \
  sed -i \
    's/applications:org.kde.discover.desktop,/applications:org.kde.konsole.desktop,/g' \
    /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml && \
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
