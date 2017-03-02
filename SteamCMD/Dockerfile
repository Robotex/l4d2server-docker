FROM ubuntu:yakkety

# Prevent some warnings
ARG DEBIAN_FRONTEND=noninteractive

# Enable the multiverse source and install SteamCMD
RUN sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list \
    && dpkg --add-architecture i386 \
    && apt-get update \
    && echo steamcmd steam/question select I AGREE | debconf-set-selections \
    && apt-get -y install ca-certificates steamcmd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
