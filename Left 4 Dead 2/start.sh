#!/bin/sh

if [ ! -f /srv/$GAME/serverfiles/srcds_run ]
then
    echo "Executable not found!"
    exit;
fi

if [ ! -d /srv/${GAME}/addons ]
then
    mkdir /srv/${GAME}/addons
    mount --bind --verbose /srv/${GAME}/addons /srv/${GAME}/serverfiles/left4dead2/addons
fi
if [ ! -d /srv/${GAME}/cfg ]
then
    mkdir /srv/${GAME}/cfg
    mount --bind --verbose /srv/${GAME}/cfg /srv/${GAME}/serverfiles/left4dead2/cfg
fi

/srv/$GAME/serverfiles/srcds_run -ip $BIND_IP -port $BIND_PORT -strictportbind "$@"