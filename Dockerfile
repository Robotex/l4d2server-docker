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
WORKDIR /home/l4d2server

# Create steamcmd directory
RUN mkdir ~/steamcmd && cd ~/steamcmd

# Download and extract SteamCMD for Linux
RUN wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && tar -xf steamcmd_linux.tar.gz && rm steamcmd_linux.tar.gz

# Install Left 4 Dead 2
RUN ./downloader.sh && rm downloader.sh

EXPOSE 27015/tcp
EXPOSE 27015/udp

ENTRYPOINT ["./serverfiles/srcds_run"]