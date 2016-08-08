FROM ubuntu:xenial
MAINTAINER Robotex

# Prevent some warnings
ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN dpkg --add-architecture i386 && apt-get update && apt-get install bsdmainutils python-minimal tmux mailutils nullmailer curl file lib32gcc1 libstdc++6 libstdc++6:i386 -y

# Add new user
RUN adduser --disabled-password --gecos '' l4d2server
USER l4d2server
WORKDIR /home/l4d2server

# Download LGSM
RUN curl --remote-name -L http://gameservermanagers.com/dl/l4d2server && chmod +x l4d2server

# Install Left 4 Dead 2
RUN ./l4d2server auto-install

# SteamCMD fix
RUN mkdir -pv ./.steam/sdk32 && ln -s "./steamcmd/linux32/steamclient.so" "~/.steam/sdk32/steamclient.so"

# Specify port binding
ENV SRCDS_PORT=27015
EXPOSE ${SRCDS_PORT}/tcp
EXPOSE ${SRCDS_PORT}/udp

ENTRYPOINT ["./serverfiles/srcds_run", "-game", "left4dead2", "-strictportbind"]
CMD ["-port", "echo $SRCDS_PORT", "-ip", "0.0.0.0", "+clientport", "27005", "+map", "c5m1_waterfront", "+servercfgfile", "l4d2-server.cfg", "-maxplayers", "12"]