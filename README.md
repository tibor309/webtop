# 🖥️ Webtop

Linux containers with full desktop environments accessible trough any modern web browser using KasmVNC.

## Desktops

To use a desktop, simply change the Docker image tag.

| Base Distro | Desktop Environment | Docker image tag |
| :--- | :--- | :---: |
| Debian 12 | KDE Plasma | `latest` |
| Ubuntu 24.04 | Ubuntu Desktop | `ubuntu` |
| Ubuntu 24.04 | KDE Plasma | `kubuntu` |
| Ubuntu 24.04 | Zorin OS Desktop | `zorinos-core` |

## Setup
To set up the container, you can use docker-compose or the docker cli. Unless a parameter is flagged as 'optional', it is *mandatory* and a value must be provided. This container is using a linuxserver.io base, so you can use their [mods](https://github.com/linuxserver/docker-mods) and configurations to enable additional functionality within the container.

### [docker-compose](https://docs.linuxserver.io/general/docker-compose) (recommended)

```yaml
---
services:
  webtop:
    image: ghcr.io/tibynx/webtop:latest
    container_name: webtop
    security_opt:
      - seccomp:unconfined #optional
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
      - SUBFOLDER=/ #optional
      - TITLE=Webtop #optional
    volumes:
      - /path/to/data:/config
      - /var/run/docker.sock:/var/run/docker.sock #optional
    ports:
      - 3000:3000
      - 3001:3001
    devices:
      - /dev/dri:/dev/dri #optional
    shm_size: "1gb" #optional
    restart: unless-stopped
```

### [docker-cli](https://docs.docker.com/engine/reference/commandline/cli/)

```bash
docker run -d \
  --name=webtop \
  --security-opt seccomp=unconfined `#optional` \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -e SUBFOLDER=/ `#optional` \
  -e TITLE=Webtop `#optional` \
  -p 3000:3000 \
  -p 3001:3001 \
  -v /path/to/data:/config \
  -v /var/run/docker.sock:/var/run/docker.sock `#optional` \
  --device /dev/dri:/dev/dri `#optional` \
  --shm-size="1gb" `#optional` \
  --restart unless-stopped \
  ghcr.io/tibynx/webtop:latest
```

## Security

By default, this container has no authentication. Configure the optional environment variables `CUSTOM_USER` and `PASSWORD` to enable basic HTTP auth. This should only be used to locally secure the container on a local network. If you're exposing this container to the internet, it's recommended to use a reverse proxy or a VPN such as [SWAG](https://github.com/linuxserver/docker-swag) or Tailscale.

## Config

Containers are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container. Further options can be found on the [Selkies Base Images](https://github.com/linuxserver/docker-baseimage-selkies#options) or the [KasmVNC Base Images](https://github.com/linuxserver/docker-baseimage-kasmvnc#options) repo.


| Parameter | Function |
| :----: | --- |
| `-p 3000:3000` | Web Desktop GUI HTTP, must be proxied |
| `-p 3001:3001` | Web Desktop GUI HTTPS |
| `-e PUID=1000` | for UserID |
| `-e PGID=1000` | for GroupID |
| `-e TZ=Etc/UTC` | Specify a timezone to use, see this [list](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List). |
| `-e SUBFOLDER=/` | Specify a subfolder to use with reverse proxies, IE `/subfolder/` |
| `-e TITLE=Webtop` | String which will be used as page/tab title in the web browser. |
| `-v /config` | abc user's home directory, stores local files and settings |
| `-v /var/run/docker.sock` | Docker Socket on the system, if you want to use Docker in the container |
| `--device /dev/dri` | Add this for GL support (Linux hosts only) |
| `--shm-size=` | We set this to 1 gig to prevent modern web browsers from crashing |
| `--security-opt seccomp=unconfined` | For Docker Engine only, many modern gui apps need this to function on older hosts as syscalls are unknown to Docker. |

## Updating

This image is not always up to date. To update or install packages, use the desktop's package manager. You can read more about persistent apps below. It is recommended to pull the latest image and redeploy the container once in a while to update your configured mods.

## Applications

There are two methods for installing applications inside the container: PRoot Apps (recommended for persistence) and Native Apps.

#### PRoot Apps

Natively installed packages (e.g., via `apt-get install`) will not persist if the container is recreated. To retain applications and their settings across container updates, use [proot-apps](https://github.com/linuxserver/proot-apps). These are portable applications installed to the user's persistent `$HOME` directory.

To install an application, use the command line inside the container, or the Apps menu in the Selkies sidebar. A list of supported applications is available [here](https://github.com/linuxserver/proot-apps?tab=readme-ov-file#supported-apps).

```
proot-apps install filezilla
```

#### Native Apps

You can install packages from the system's native repository using the [universal-package-install](https://github.com/linuxserver/docker-mods/tree/universal-package-install) mod. This method will increase the container's start time and is not persistent. Add the following to your `compose.yaml`:

```yaml
  environment:
    - DOCKER_MODS=linuxserver/mods:universal-package-install
    - INSTALL_PACKAGES=libfuse2|git|gdb
```

## Usage

To access the container, navigate to the IP address for your machine with the port you provided at the setup.

* [http://yourhost:3000/](https://www.youtube.com/watch?v=dQw4w9WgXcQ)
* [https://yourhost:3001/](https://www.youtube.com/watch?v=dQw4w9WgXcQ)
