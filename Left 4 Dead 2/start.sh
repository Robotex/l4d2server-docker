#!/bin/sh

if [ ! -f /srv/$GAME/serverfiles/srcds_run ]
then
    echo "Executable not found!"
    exit;
fi

if [ ! -L /srv/${GAME}/serverfiles/left4dead2/addons ]
then
    cp -r /srv/${GAME}/serverfiles/left4dead2/addons/* /srv/${GAME}/addons
    rm -rf /srv/${GAME}/serverfiles/left4dead2/addons
    ln -s /srv/${GAME}/addons /srv/${GAME}/serverfiles/left4dead2
fi

if [ ! -L /srv/${GAME}/serverfiles/left4dead2/cfg ]
then
    cp -r /srv/${GAME}/serverfiles/left4dead2/cfg/* /srv/${GAME}/cfg
    rm -rf /srv/${GAME}/serverfiles/left4dead2/cfg
    ln -s /srv/${GAME}/cfg /srv/${GAME}/serverfiles/left4dead2
fi

/srv/$GAME/serverfiles/srcds_run -ip $BIND_IP -port $BIND_PORT -strictportbind "$@"