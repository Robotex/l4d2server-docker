FROM renshou/steamcmd:latest

# Prevent some warnings
ARG DEBIAN_FRONTEND=noninteractive

# Folder name (must be same as update script)
ENV GAME=l4d2

# Default port binding
ENV BIND_PORT=27015
ENV BIND_IP=0.0.0.0

# Download MM and SM
ADD http://mirror.pointysoftware.net/alliedmodders/mmsource-1.10.6-linux.tar.gz /tmp/mm.tar.gz
ADD https://sm.alliedmods.net/smdrop/1.8/sourcemod-1.8.0-git5974-linux.tar.gz /tmp/sm.tar.gz

# Copy scripts
COPY update.txt /srv/${GAME}/update.txt
COPY start.sh /srv/${GAME}/start.sh

# Copy cfg
# COPY server.cfg /srv/${GAME}/server.cfg

# Assign ownership
RUN chown gameserver:gameserver /srv/${GAME}/update.txt /srv/${GAME}/start.sh /tmp/mm.tar.gz /tmp/sm.tar.gz \
#/srv/${GAME}/server.cfg \
    && chmod +x /srv/${GAME}/start.sh \
    && ln -s /srv/${GAME}/serverfiles/left4dead2/maps /srv/${GAME}/maps

# Switch to non root user
USER gameserver

CMD ["-game left4dead2", "+map c5m1_waterfront"]