FROM renshou/steamcmd:latest

# Prevent some warnings
ARG DEBIAN_FRONTEND=noninteractive

# Folder name (must be same as update script)
ENV GAME=tf2

# Copy scripts
COPY update.txt /srv/${GAME}

# Install dependencies & assign files ownership
RUN apt-get update \
    && apt-get -y install lib32ncurses5 \
    && rm -rf /var/lib/apt/lists/* \
    && chown gameserver:gameserver /srv/${GAME}/update.txt

# Default port binding
ENV BIND_PORT=27015
ENV BIND_IP=0.0.0.0

# Switch to non root user
USER gameserver

CMD ["-game tf", "+map ctf_2fort"]