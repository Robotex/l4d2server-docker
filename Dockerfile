FROM ubuntu:xenial
MAINTAINER Robotex

# Prevent some warnings
ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install lib32gcc1 wget -y

# Copy script
COPY downloader.sh /tmp
COPY l4d2server-entrypoint.sh /tmp

# Add new user and assign ownership
RUN adduser --disabled-password --gecos '' l4d2server && chown l4d2server /tmp/downloader.sh && chmod +x /tmp/downloader.sh && mv /tmp/downloader.sh /home/l4d2server/ && chown l4d2server /tmp/l4d2server-entrypoint.sh && chmod +x /tmp/l4d2server-entrypoint.sh && mv /tmp/l4d2server-entrypoint.sh /home/l4d2server/
USER l4d2server

# Create steamcmd directory
RUN mkdir ~/steamcmd

# Download and extract SteamCMD for Linux
WORKDIR /home/l4d2server/steamcmd/
RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && tar -xf steamcmd_linux.tar.gz && rm steamcmd_linux.tar.gz && mv ../downloader.sh ./

# Install Left 4 Dead 2
RUN ./downloader.sh && rm downloader.sh

# SteamCMD fix
WORKDIR /home/l4d2server/
RUN mkdir -pv ~/.steam/sdk32 && ln -s ~/steamcmd/linux32/steamclient.so ~/.steam/sdk32/steamclient.so

VOLUME ["/home/l4d2server/serverfiles/left4dead2/addons", "/home/l4d2server/serverfiles/left4dead2/cfg"]

# Specify port binding
ENV SRCDS_BIND_PORT=27015
ENV SRCDS_BIND_IP=0.0.0.0
EXPOSE ${SRCDS_BIND_PORT}/tcp
EXPOSE ${SRCDS_BIND_PORT}/udp

ENTRYPOINT ["./l4d2server-entrypoint.sh", "-game", "left4dead2", "-autoupdate", "-strictportbind", "-port", "echo $SRCDS_BIND_PORT", "-ip", "echo $SRCDS_BIND_IP", "+clientport", "27005"]
CMD ["+map", "c5m1_waterfront", "+servercfgfile", "l4d2-server.cfg", "-maxplayers", "12"]