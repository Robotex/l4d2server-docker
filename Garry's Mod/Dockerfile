FROM renshou/steamcmd:latest

# Prevent some warnings
ARG DEBIAN_FRONTEND=noninteractive

# Folder name (must be same as update script)
ENV GAME=gmod

# Copy scripts
COPY update_gmod_ds.txt /srv/${GAME}/update.txt
COPY ../entrypoint.sh /srv/${GAME}/entrypoint.sh

# Add new user and assign ownership
RUN adduser --disabled-password --gecos '' gameserver \
    && chown gameserver:gameserver /srv/${GAME}/update.txt \
    && chown gameserver:gameserver /srv/${GAME}/entrypoint.sh \
    && chmod +x /srv/${GAME}/entrypoint.sh

# Specify port binding
ENV BIND_PORT=27015
ENV BIND_IP=0.0.0.0
EXPOSE ${BIND_PORT}/tcp ${BIND_PORT}/udp

# Switch to non root user
USER gameserver

# Steam fix
RUN mkdir -pv ~/.steam/sdk32/ \
    && ln -s ~/.steam/steamcmd/linux32/steamclient.so ~/.steam/sdk32/steamclient.so

ENTRYPOINT ["/srv/gmod/entrypoint.sh"]
CMD ["+map gm_construct"]