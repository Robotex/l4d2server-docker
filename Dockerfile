FROM ubuntu:xenial
MAINTAINER Robotex

# Prevent some warnings
ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install lib32gcc1 wget -y

# Copy script
COPY downloader.sh ./

# Add new user and assign ownership
RUN adduser --disabled-password --gecos '' l4d2server && chown l4d2server downloader.sh && chmod +x downloader.sh && mv downloader.sh /home/l4d2server/
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

# Specify port binding
ENV SRCDS_PORT=27015
EXPOSE 27015/tcp
EXPOSE 27015/udp

WORKDIR /home/l4d2server/serverfiles/
ENTRYPOINT ["./srcds_run", "-game", "left4dead2", "-strictportbind"]
CMD ["-port", "echo $SRCDS_PORT", "-ip", "0.0.0.0", "+clientport", "27005", "+map", "c5m1_waterfront", "+servercfgfile", "l4d2-server.cfg", "-maxplayers", "12"]