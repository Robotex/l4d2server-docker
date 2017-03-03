FROM renshou/steamcmd:latest

# Prevent some warnings
ARG DEBIAN_FRONTEND=noninteractive

# Folder name (must be same as update script)
ENV GAME=l4d2

# Default port binding
ENV BIND_PORT=27015
ENV BIND_IP=0.0.0.0

# Copy scripts
COPY update.txt /srv/${GAME}
COPY start.sh /srv/${GAME}

# Assign ownership
RUN chown gameserver:gameserver /srv/${GAME}/update.txt /srv/${GAME}/start.sh \
    && chmod +x /srv/${GAME}/start.sh

# Switch to non root user
USER gameserver

CMD ["-game left4dead2", "+map c5m1_waterfront"]