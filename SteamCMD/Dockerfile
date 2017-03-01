FROM ubuntu:yakkety

# Prevent some warnings
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get --assume-yes install steamcmd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
