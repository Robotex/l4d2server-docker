FROM renshou/steamcmd:latest

# Prevent some warnings
ARG DEBIAN_FRONTEND=noninteractive

# Folder name (must be same as update script)
ENV GAME=l4d2

# Default port binding
ENV BIND_PORT=27015
ENV BIND_IP=0.0.0.0

# Copy scripts
COPY update.txt /srv/${GAME}/update.txt
COPY start.sh /srv/${GAME}/start.sh

# Assign ownership and mount user customization folders
RUN chown gameserver:gameserver /srv/${GAME}/update.txt /srv/${GAME}/start.sh \
    && chmod +x /srv/${GAME}/start.sh \
    && mkdir /srv/${GAME}/addons \
    && mkdir /srv/${GAME}/cfg \
    && mount --bind --verbose /srv/${GAME}/addons /srv/${GAME}/serverfiles/left4dead2/addons \
    && mount --bind --verbose /srv/${GAME}/cfg /srv/${GAME}/serverfiles/left4dead2/cfg  

# Switch to non root user
USER gameserver

CMD ["-game left4dead2", "+map c5m1_waterfront"]