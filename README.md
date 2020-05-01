# docker-leets
Automatic music downloader and library management for obsessive-compulsive music geeks.

[Lidarr](https://github.com/lidarr/Lidarr) is a music collection manager for Usenet and BitTorrent users. [Beets](https://github.com/beetbox/beets) is the media library management system for obsessive music geeks.

Both of them are great tools, however having them in separate containers make it difficult to make them work together. This image creates a single and convenient package for a great music library experience, with (hopefully) all the dependencies for beets standard plugins

Lidarr already offers a way to interface with Beets using [Custom Post-Processing Scripts](https://github.com/lidarr/Lidarr/wiki/Custom-Post-Processing-Scripts), follow the instructions there for tips on how to use them.

Base image is provided by: [linuxserver/lidarr](https://github.com/linuxserver/docker-lidarr)

## Supported Architectures

The architectures supported are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |

## Version Tags

| Tag | Description |
| :----: | --- |
| latest | Stable releases |

## Usage

Here are some example commands to help you get started creating a container.

### docker

```
docker create \
  --name=leets \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e UMASK_SET=022 `#optional` \
  -p 8686:8686 \
  -p 8337:8337 \
  -v /path/to/appdata/config:/config \
  -v /path/to/music:/music \
  -v /path/to/downloads:/downloads \
  --restart unless-stopped \
  whirlgig/docker-leets
```


### docker-compose

Compatible with docker-compose.

```
version: "3"
services:
  leets:
    image: whirlgig/docker-leets
    container_name: leets
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
      - UMASK_SET=022 #optional
    volumes:
      - /path/to/appdata/config:/config
      - /path/to/music:/music
      - /path/to/downloads:/downloads
    ports:
      - 8337:8337
      - 8686:8686
    restart: unless-stopped
```
## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 8686` | Lidarr WebUI |
| `-p 8337` | Beets Web plugin WebUI |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London. |
| `-e UMASK_SET=022` | control permissions of files and directories created. |
| `-v /config` | Configuration files. |
| `-v /music` | Music files (See note in Application setup). |
| `-v /downloads` | Path to your download folder for music (See note in Application setup). |

## Directories:
* <strong>/config</strong>
  * Lidarr Configuration Files
* <strong>/config/beets</strong>
  * Beets configuration files
* <strong>/downloads</strong>
  * This is where your download client will download the music to
* <strong>/music</strong>
  * This is where all your music lives

<strong>Special Note</strong>: Following current folder structure will result in an inability to hardlink from your downloads to your Music folder because they are on seperate volumes. To support hardlinking, simply ensure that the Music and downloads data are on a single volume. For example, if you have /mnt/storage/Music and /mnt/storage/downloads/completed/Music, you would want something like /mnt/storage:/media for your volume. Then you can hardlink from /media/downloads/completed to /media/Music.

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```
## Updating Info
### Via Docker Run/Create
* Update the image: `docker pull linuxserver/leets`
* Stop the running container: `docker stop leets`
* Delete the container: `docker rm leets`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start leets`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull leets`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d leets`
* You can also remove the old dangling images: `docker image prune`




