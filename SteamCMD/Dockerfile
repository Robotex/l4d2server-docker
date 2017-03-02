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

COPY entrypoint.sh /srv/entrypoint.sh

# Add new user and assign ownership of entrypoint script
RUN adduser --disabled-password --gecos '' gameserver \
    && chown gameserver:gameserver /srv/entrypoint.sh \
    && chmod +x /srv/entrypoint.sh

# SteamInit crash fix
RUN mkdir -pv /home/gameserver/.steam/sdk32/ \
    && ln -s /home/gameserver/.steam/steamcmd/linux32/steamclient.so /home/gameserver/.steam/sdk32/steamclient.so

ENTRYPOINT ["/srv/entrypoint.sh"]