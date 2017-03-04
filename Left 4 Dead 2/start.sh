#!/bin/sh

if [ ! -f /srv/$GAME/serverfiles/srcds_run ]
then
    echo "Executable not found!"
    exit;
fi

rm -rf /srv/${GAME}/serverfiles/left4dead2/addons
ln -s /srv/${GAME}/addons /srv/${GAME}/serverfiles/left4dead2

rm -rf /srv/${GAME}/cfg
ln -s /srv/${GAME}/cfg /srv/${GAME}/serverfiles/left4dead2

/srv/$GAME/serverfiles/srcds_run -ip $BIND_IP -port $BIND_PORT -strictportbind "$@"