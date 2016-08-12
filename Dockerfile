FROM ubuntu:xenial
MAINTAINER Robotex

# Prevent some warnings
ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN dpkg --add-architecture i386 && apt-get update && apt-get install wget bzip2 bsdmainutils python-minimal tmux mailutils nullmailer curl file lib32gcc1 libstdc++6 libstdc++6:i386 -y

# Copy scripts
COPY update_defaults.sh ./

# Add new user and assign script ownership
RUN adduser --disabled-password --gecos '' l4d2server && chown l4d2server update_defaults.sh && chmod +x update_defaults.sh && mv update_defaults.sh /home/l4d2server/
USER l4d2server
WORKDIR /home/l4d2server

# Download LGSM
RUN curl --remote-name -L http://gameservermanagers.com/dl/l4d2server && chmod +x l4d2server

# Execute script
RUN ./update_defaults.sh

# Install Left 4 Dead 2
RUN ./l4d2server auto-install

ENTRYPOINT ["./l4d2server"]
CMD ["start"]