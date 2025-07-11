FROM ghcr.io/linuxserver/baseimage-selkies:fedora42

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
LABEL org.opencontainers.image.base.name="ghcr.io/linuxserver/baseimage-selkies:fedora42"
LABEL org.opencontainers.image.base.documentation="https://github.com/linuxserver/docker-baseimage-selkies/blob/master/README.md"

# branding
ENV LSIO_FIRST_PARTY=false

# title
ENV TITLE="Fedora KDE"

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /usr/share/selkies/www/icon.png \
    https://raw.githubusercontent.com/tibor309/icons/main/icons/fedora/fedora_logo_256x251.png && \
  curl -o \
    /usr/share/selkies/favicon.ico \
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
