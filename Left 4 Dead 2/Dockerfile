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

# Copy scripts
COPY update_l4d2_ds.txt /srv/l4d2server/update.txt
COPY entrypoint.sh /srv/l4d2server/entrypoint.sh

# Add new user and assign ownership
RUN adduser --disabled-password --gecos '' gameserver \
    && chown gameserver:gameserver /srv/l4d2server/update.txt \
    && chown gameserver:gameserver /srv/l4d2server/entrypoint.sh \
    && chmod +x /srv/l4d2server/entrypoint.sh

VOLUME ["/srv/l4d2server/"]

# Specify port binding
ENV SRCDS_BIND_PORT=27015
ENV SRCDS_BIND_IP=0.0.0.0
EXPOSE ${SRCDS_BIND_PORT}/tcp ${SRCDS_BIND_PORT}/udp

# Switch to non root user
USER gameserver

# Steam fix
mkdir -pv ~/.steam/sdk32/
ln -s ~/.steam/steamcmd/linux32/steamclient.so ~/.steam/sdk32/steamclient.so

CMD ["/srv/l4d2server/entrypoint.sh"]