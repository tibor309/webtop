[repo]: https://github.com/tibor309/webtop

[dhub]: https://hub.docker.com/r/tibordev/brave
[dcompose]: https://docs.linuxserver.io/general/docker-compose
[dcli]: https://docs.docker.com/engine/reference/commandline/cli/
[tz]: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List
[link]: https://www.youtube.com/watch?v=dQw4w9WgXcQ

[lsmods]: https://github.com/linuxserver/docker-mods
[lsswag]: https://github.com/linuxserver/docker-swag
[lsselkies-op]: https://github.com/linuxserver/docker-baseimage-selkies#options
[lsapps]: https://github.com/linuxserver/proot-apps
[lsapps-support]: https://github.com/linuxserver/proot-apps?tab=readme-ov-file#supported-apps

[ubuntu-cinnamon-badge]: https://img.shields.io/badge/Ubuntu%20Cinnamon%20Remix-E95420?style=for-the-badge&logo=ubuntu&logoColor=white
[ubuntu-gnome-badge]: https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white
[ubuntu-vanilla-gnome-badge]: https://img.shields.io/badge/Ubuntu%20Vanilla-4A86CF?style=for-the-badge&logo=ubuntu&logoColor=white
[ubuntu-kde-badge]: https://img.shields.io/badge/Kubuntu-0079C1?style=for-the-badge&logo=kubuntu&logoColor=white
[ubuntu-xfce-badge]: https://img.shields.io/badge/Xubuntu-0044AA.svg?style=for-the-badge&logo=Xubuntu&logoColor=white
[fedora-xfce-badge]: https://img.shields.io/badge/Fedora%20xfce%20spin-51A2DA?style=for-the-badge&logo=fedora&logoColor=white
[fedora-kde-badge]: https://img.shields.io/badge/Fedora%20kde%20spin-51A2DA?style=for-the-badge&logo=fedora&logoColor=white
[zorin-core-badge]: https://img.shields.io/badge/Zorin%20OS%20Core-15A6F0.svg?style=for-the-badge&logo=Zorin&logoColor=white

[ubuntu-cinnamon-repo]: https://github.com/tibor309/webtop/tree/ubuntu-cinnamon
[ubuntu-gnome-repo]: https://github.com/tibor309/webtop/tree/ubuntu
[ubuntu-vanilla-gnome-repo]: https://github.com/tibor309/webtop/tree/ubuntu-vanilla
[ubuntu-kde-repo]: https://github.com/tibor309/webtop/tree/kubuntu
[ubuntu-xfce-repo]: https://github.com/tibor309/webtop/tree/xubuntu
[fedora-xfce-repo]: https://github.com/tibor309/webtop/tree/fedora-xfce
[fedora-kde-repo]: https://github.com/tibor309/webtop/tree/fedora-kde
[zorin-core-repo]: https://github.com/tibor309/webtop/tree/zorinos-core



# 🖥️ [Webtop][repo]
Linux containers with full desktop environments accessible trough any modern web browser.

## Desktops
You can choose from these distros and desktops.

| Distro | Flavour |
| :--- | :--- |
| **Ubuntu** | [![ubuntu][ubuntu-gnome-badge]][ubuntu-gnome-repo] [![ubuntu-vanilla][ubuntu-vanilla-gnome-badge]][ubuntu-vanilla-gnome-repo] [![ubuntu-kde][ubuntu-kde-badge]][ubuntu-kde-repo] [![ubuntu-xfce][ubuntu-xfce-badge]][ubuntu-xfce-repo] [![ubuntu-cinnamon][ubuntu-cinnamon-badge]][ubuntu-cinnamon-repo] |
| **Fedora** | [![fedora-kde][fedora-kde-badge]][fedora-kde-repo] [![fedora-xfce][fedora-xfce-badge]][fedora-xfce-repo] |
| **Zorin OS** | [![zorin-core][zorin-core-badge]][zorin-core-repo] |

## Setup
To set up the container, you can use docker-compose or the docker cli. Unless a parameter is flagged as 'optional', it is *mandatory* and a value must be provided. This container is using a linuxserver.io base, so you can use their [mods][lsmods] and configurations to enable additional functionality within the container.

> [!NOTE]
> This image is also available on [Docker Hub][dhub] at `tibordev/webtop`.

### [docker-compose][dcompose] (recommended)
```yaml
---
services:
  webtop:
    image: ghcr.io/tibor309/webtop:latest
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

### [docker-cli][dcli]
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
  ghcr.io/tibor309/webtop:latest
```

## Security
By default, this container has no authentication. Configure the optional environment variables `CUSTOM_USER` and `PASSWORD` to enable basic HTTP auth. This should only be used to locally secure the container on a local network. If you're exposing this container to the internet, it's recommended to use a reverse proxy or a VPN such as [SWAG][lsswag] or Tailscale.

## Config
Containers are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container. Further options can be found on the [Selkies Base Images][lsselkies-op] repo.


| Parameter | Function |
| :----: | --- |
| `-p 3000:3000` | Web Desktop GUI HTTP, must be proxied |
| `-p 3001:3001` | Web Desktop GUI HTTPS |
| `-e PUID=1000` | for UserID |
| `-e PGID=1000` | for GroupID |
| `-e TZ=Etc/UTC` | Specify a timezone to use, see this [list][tz]. |
| `-e SUBFOLDER=/` | Specify a subfolder to use with reverse proxies, IE `/subfolder/` |
| `-e TITLE=Webtop` | String which will be used as page/tab title in the web browser. |
| `-v /config` | abc user's home directory, stores local files and settings |
| `-v /var/run/docker.sock` | Docker Socket on the system, if you want to use Docker in the container |
| `--device /dev/dri` | Add this for GL support (Linux hosts only) |
| `--shm-size=` | We set this to 1 gig to prevent modern web browsers from crashing |
| `--security-opt seccomp=unconfined` | For Docker Engine only, many modern gui apps need this to function on older hosts as syscalls are unknown to Docker. |

## Updating
This image is not always up to date. To update or install packages, use the desktop's package manager. You can read more about persistent apps below. It is recommended to pull the latest image and redeploy theontainer once in a while to update your configured mods.

## Applications
There are two methods for installing applications inside the container: PRoot Apps (recommended for persistence) and Native Apps.

#### PRoot Apps
Natively installed packages (e.g., via `apt-get install`) will not persist if the container is recreated. To retain applications and their settings across container updates, use [proot-apps][lsapps]. These are portable applications installed to the user's persistent `$HOME` directory.

To install an application, use the command line inside the container, or the Apps menu in the Selkies sidebar. A list of supported applications is available [here][lsapps-support].

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

* [http://yourhost:3000/][link]
* [https://yourhost:3001/][link]
