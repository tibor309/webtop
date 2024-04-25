# 🖥️ Webtop
Linux containers with full desktop environments accessible trough a web browser.

## Desktops
### Ubuntu
[![ubuntu-cinnamon][ubuntu-cinnamon-badge]][ubuntu-cinnamon-repo]
*(More coming soon!)*

## Setup
To setup the container, you can use the docker cli, or docker compose.

### [docker-compose][dcompose] (recommended)
```yaml
---
services:
  webtop:
    image: ghcr.io/tibor309/webtop:ubuntu-cinnamon
    container_name: ubuntu-webtop
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
  --name=ubuntu-webtop \
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
| `-e PUID=1000` | For UserID - see below for explanation |
| `-e PGID=1000` | For GroupID - see below for explanation |
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


[ubuntu-cinnamon-badge]: https://img.shields.io/badge/Ubuntu%20Cinnamon-E95420?style=for-the-badge&logo=ubuntu&logoColor=white

[ubuntu-cinnamon-repo]: https://github.com/tibor309/webtop/tree/ubuntu-cinnamon
