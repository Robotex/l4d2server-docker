FROM renshou/steamcmd:latest

# Prevent some warnings
ARG DEBIAN_FRONTEND=noninteractive

# Default port binding
ENV BIND_PORT=27015
ENV BIND_IP=0.0.0.0

# SRCDS parameters
ENV SRCDS_GAME=left4dead2
ENV SRCDS_HOSTNAME="Speranza's L4D2"

# Download MM and SM
ADD http://mirror.pointysoftware.net/alliedmodders/mmsource-1.10.6-linux.tar.gz /tmp/mm.tar.gz
ADD https://sm.alliedmods.net/smdrop/1.8/sourcemod-1.8.0-git5974-linux.tar.gz /tmp/sm.tar.gz

# Copy scripts
COPY update.txt /srv/srcds/update.txt
COPY start.sh /srv/srcds/start.sh

# Copy cfg callback
COPY server.cfg /srv/srcds/serverfiles/${SRCDS_GAME}/cfg/server.cfg

# Create forward mount symlinks
RUN mkdir -p /mnt/srcds \
    && ln -s /srv/srcds/serverfiles/${SRCDS_GAME}/addons /mnt/srcds/addons \
    && ln -s /srv/srcds/serverfiles/${SRCDS_GAME}/cfg/sourcemod /mnt/srcds/cfg-sourcemod \
    && ln -s /srv/srcds/serverfiles/${SRCDS_GAME}/cfg/server /mnt/srcds/cfg-server

# Create reverse mount symlinks
RUN mkdir -p /srv/srcds/serverfiles/${SRCDS_GAME}/cfg \
    && ln -s /srv/srcds/mods/cfg/sourcemod /srv/srcds/serverfiles/${SRCDS_GAME}/cfg/sourcemod \
    && ln -s /srv/srcds/mods/addons /srv/srcds/serverfiles/${SRCDS_GAME}/addons \
    && ln -s /srv/srcds/mods/cfg/server /srv/srcds/serverfiles/${SRCDS_GAME}/cfg/server

# Create user customization folders
RUN mkdir -p /srv/srcds/mods/cfg/sourcemod /srv/srcds/mods/addons /srv/srcds/mods/cfg/server

# Assign ownership
RUN chown -R gameserver:gameserver /srv/srcds /tmp/mm.tar.gz /tmp/sm.tar.gz \
    && chmod +x /srv/srcds/start.sh

# Switch to non root user
USER gameserver

CMD ["+map c5m1_waterfront"]