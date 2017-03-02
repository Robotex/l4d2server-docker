FROM renshou/steamcmd:latest

# Prevent some warnings
ARG DEBIAN_FRONTEND=noninteractive

# Folder name (must be same as update script)
ENV GAME=l4d2

# Copy scripts
COPY update_l4d2_ds.txt /srv/${GAME}/update.txt

# Assign ownership
RUN chown gameserver:gameserver /srv/${GAME}/update.txt

# Specify port binding
ENV BIND_PORT=27015
ENV BIND_IP=0.0.0.0
EXPOSE ${BIND_PORT}/tcp ${BIND_PORT}/udp

# Switch to non root user
USER gameserver

# Steam fix
RUN mkdir -pv ~/.steam/sdk32/ \
    && ln -s ~/.steam/steamcmd/linux32/steamclient.so ~/.steam/sdk32/steamclient.so

ENTRYPOINT ["/srv/l4d2/entrypoint.sh"]
CMD ["+map c5m1_waterfront"]