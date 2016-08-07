FROM ubuntu:xenial

# Install dependencies
RUN apt-get update && apt-get install lib32gcc1 wget curl file tmux -y

# Add new user
RUN adduser --disabled-password --gecos '' l4d2server
USER l4d2server
WORKDIR /home/l4d2server

# Download LGSM
RUN wget http://gameservermanagers.com/dl/l4d2server && chmod +x l4d2server

# Install Left 4 Dead 2
RUN ./l4d2server auto-install

EXPOSE 27015/tcp
EXPOSE 27015/udp

ENTRYPOINT ["./serverfiles/srcds_run"]
