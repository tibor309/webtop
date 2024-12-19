# 🖥️ Webtop
Linux containers with full desktop environments accessible trough a web browser.

## Desktops
You can choose from these distros and desktops.

| Distro | Flavour |
| :--- | :--- |
| **Ubuntu** | [![ubuntu][ubuntu-gnome-badge]][ubuntu-gnome-repo] [![ubuntu-vanilla][ubuntu-vanilla-gnome-badge]][ubuntu-vanilla-gnome-repo] [![ubuntu-kde][ubuntu-kde-badge]][ubuntu-kde-repo] [![ubuntu-xfce][ubuntu-xfce-badge]][ubuntu-xfce-repo] [![ubuntu-cinnamon][ubuntu-cinnamon-badge]][ubuntu-cinnamon-repo] |
| **Fedora** | [![fedora-kde][fedora-kde-badge]][fedora-kde-repo] [![fedora-xfce][fedora-xfce-badge]][fedora-xfce-repo] |

## Setup
To setup the container, you can use the docker cli, or docker compose. Don't forget to change the image tag to your desired desktop variant!

### [docker-compose][dcompose] (recommended)
```yaml
---
services:
  webtop:
    image: ghcr.io/tibor309/webtop:ubuntu-cinnamon
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
  ghcr.io/tibor309/webtop:ubuntu-cinnamon
```

## Config
This container is based on the linuxserver.io kasmvnc base image, so you can use their mods and additional configs if you want.

| Parameter | Function |
| :----: | --- |
| `-p 3000` | Web Desktop GUI |
| `-p 3001` | Web Desktop GUI HTTPS |
| `-e PUID=1000` | For UserID |
| `-e PGID=1000` | For GroupID |
| `-e TZ=Etc/UTC` | Specify a timezone to use, see this [list][tz]. |
| `-e SUBFOLDER=/` | Specify a subfolder to use with reverse proxies, IE `/subfolder/` |
| `-e TITLE=Webtop` | String which will be used as page/tab title in the web browser. |
| `-v /config` | abc user's home directory, stores local files and settings |
| `-v /var/run/docker.sock` | Docker Socket on the system, if you want to use Docker in the container |
| `--device /dev/dri` | Add this for GL support (Linux hosts only) |
| `--shm-size=` | We set this to 1 gig to prevent modern web browsers from crashing |
| `--security-opt seccomp=unconfined` | For Docker Engine only, many modern gui apps need this to function on older hosts as syscalls are unknown to Docker. |

## Usage
To access the container, navigate to the ip address for your machine with the port you provided at the setup.

* [http://yourhost:3000/][link]
* [https://yourhost:3001/][link]

[dcompose]: https://docs.linuxserver.io/general/docker-compose
[dcli]: https://docs.docker.com/engine/reference/commandline/cli/
[tz]: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List
[link]: https://www.youtube.com/watch?v=dQw4w9WgXcQ


[ubuntu-cinnamon-badge]: https://img.shields.io/badge/Ubuntu%20Cinnamon%20Remix-E95420?style=for-the-badge&logo=ubuntu&logoColor=white
[ubuntu-gnome-badge]: https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white
[ubuntu-vanilla-gnome-badge]: https://img.shields.io/badge/Ubuntu%20Vanilla-4A86CF?style=for-the-badge&logo=ubuntu&logoColor=white
[ubuntu-kde-badge]: https://img.shields.io/badge/Kubuntu-0079C1?style=for-the-badge&logo=kubuntu&logoColor=white
[ubuntu-xfce-badge]: https://img.shields.io/badge/Xubuntu-0044AA.svg?style=for-the-badge&logo=Xubuntu&logoColor=white
[fedora-xfce-badge]: https://img.shields.io/badge/Fedora%20xfce%20spin-51A2DA?style=for-the-badge&logo=fedora&logoColor=white
[fedora-kde-badge]: https://img.shields.io/badge/Fedora%20kde%20spin-51A2DA?style=for-the-badge&logo=fedora&logoColor=white

[ubuntu-cinnamon-repo]: https://github.com/tibor309/webtop/tree/ubuntu-cinnamon
[ubuntu-gnome-repo]: https://github.com/tibor309/webtop/tree/ubuntu
[ubuntu-vanilla-gnome-repo]: https://github.com/tibor309/webtop/tree/ubuntu-vanilla
[ubuntu-kde-repo]: https://github.com/tibor309/webtop/tree/kubuntu
[ubuntu-xfce-repo]: https://github.com/tibor309/webtop/tree/xubuntu
[fedora-xfce-repo]: https://github.com/tibor309/webtop/tree/fedora-xfce
[fedora-kde-repo]: https://github.com/tibor309/webtop/tree/fedora-kde
