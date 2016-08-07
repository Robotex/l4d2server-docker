FROM ubuntu:xenial

# Prevent some warnings
ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install tmux mailutils postfix curl file lib32gcc1 libstdc++6 libstdc++6:i386 -y

# Add new user
RUN adduser --disabled-password --gecos '' l4d2server
USER l4d2server
WORKDIR /home/l4d2server

# Download LGSM
RUN wget http://gameservermanagers.com/dl/l4d2server && chmod +x l4d2server

# Install Left 4 Dead 2
RUN ./l4d2server auto-install

# Set port binding
ENV SRCDS_PORT=27015
EXPOSE SRCDS_PORT/tcp
EXPOSE SRCDS_PORT/udp

ENTRYPOINT ["./serverfiles/srcds_run", "-game", "left4dead2"]
