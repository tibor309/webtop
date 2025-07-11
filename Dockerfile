FROM ghcr.io/linuxserver/baseimage-kasmvnc:fedora41

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
LABEL org.opencontainers.image.base.name="ghcr.io/linuxserver/baseimage-kasmvnc:fedora41"
LABEL org.opencontainers.image.base.documentation="https://github.com/linuxserver/docker-baseimage-kasmvnc/blob/master/README.md"

# branding
ENV LSIO_FIRST_PARTY=false

# title
ENV TITLE="Fedora XFCE"

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /kclient/public/icon.png \
    https://raw.githubusercontent.com/tibor309/icons/refs/heads/main/fedora/icon.png && \
  curl -o \
    /kclient/public/favicon.ico \
    https://raw.githubusercontent.com/tibor309/icons/refs/heads/main/fedora/favicon.ico && \
  echo "**** install packages ****" && \
  dnf install -y --setopt=install_weak_deps=False --best \
    xdg-user-dirs \
    fedora-release-xfce \
    fedora-logos \
    desktop-backgrounds-compat \
    gtk-xfce-engine \
    greybird-dark-theme \
    greybird-xfwm4-theme \
    adwaita-gtk2-theme \
    adwaita-icon-theme \
    adwaita-cursor-theme \
    xfconf \
    xfdesktop \
    xfwm4 \
    xfwm4-themes \
    xfce4-session \
    xfce4-pulseaudio-plugin \
    xfce4-panel \
    xfce4-settings \
    xfce4-taskmanager \
    xfce4-terminal \
    xfce4-screenshooter \
    xfce4-screenshooter-plugin \
    xfce4-appfinder \
    xfce4-datetime-plugin \
    xfce4-places-plugin \
    xfce4-about \
    Thunar \
    firefox \
    mousepad \
    galculator \
    ristretto \
    parole && \
  echo "**** xfce tweaks ****" && \
  rm -f \
    /etc/xdg/autostart/xfce-polkit.desktop && \
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