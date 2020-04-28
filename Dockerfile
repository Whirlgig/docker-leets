FROM linuxserver/lidarr:latest
LABEL maintainer="whirlgig"

ENV VERSION="0.1"
ENV XDG_CONFIG_HOME="/config/xdg"
ENV LidarrUrl="http://127.0.0.1:8686"

RUN \
	echo "************ install dependencies ************" && \
	apt-get update -qq && \
	apt-get install -qq -y \
		wget \
		nano \
		unzip \
		git \
		jq \
		mp3val \
		flac \
		opus-tools \
		python3 \
		python3-pip \
		libchromaprint-tools \
		ffmpeg \
		lame \
		imagemagick \
		python-gi \
		libgstreamer1.0-0 \
		gstreamer1.0-plugins-base \
		gstreamer1.0-plugins-good \
		gstreamer1.0-plugins-bad \
		gstreamer1.0-plugins-ugly \
		gstreamer1.0-libav \
		gstreamer1.0-doc \
		gstreamer1.0-tools \
		gstreamer1.0-x \
		gstreamer1.0-alsa \
		gstreamer1.0-gl \
		gstreamer1.0-gtk3 \
		gstreamer1.0-qt5 \
		gstreamer1.0-pulseaudio \
		python3-pythonmagick \
		cron && \
	apt-get purge --auto-remove -y && \
	apt-get clean && \
	echo "************ install beets and plugin dependencies ************" && \
	pip3 install --no-cache-dir -U \
		beets \
		beets-extrafiles \
		requests \
		requests_oauthlib \
		discogs-client \
		flask \
		pillow \
		gmusicapi \
		pip \
		pylast \
		beautifulsoup4 \
		unidecode \
		python-mpd2 \
		pyacoustid && \
	echo "************ All dependencies installed ************"
	
WORKDIR /
ENV BEETSDIR="/config/beets" \
EDITOR="vim" \
HOME="/config"

# copy local files
COPY root/ /

# ports and volumes
EXPOSE 8686 8337
VOLUME /config /downloads /music
