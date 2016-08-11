FROM ubuntu:xenial
MAINTAINER Robotex

# Prevent some warnings
ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN dpkg --add-architecture i386 && apt-get update && apt-get install bzip2 bsdmainutils python-minimal tmux mailutils nullmailer curl file lib32gcc1 libstdc++6 libstdc++6:i386 -y

# Copy scripts
COPY update_defaults.sh /tmp/

# Add new user
RUN adduser --disabled-password --gecos '' l4d2server
USER l4d2server
WORKDIR /home/l4d2server

# Download LGSM
RUN curl --remote-name -L http://gameservermanagers.com/dl/l4d2server && chmod +x l4d2server

# Execute script
RUN chmod +x /tmp/update_defaults.sh && /tmp/update_defaults.sh

# Install Left 4 Dead 2
RUN ./l4d2server auto-install

ENTRYPOINT ["./l4d2server"]
CMD ["start"]