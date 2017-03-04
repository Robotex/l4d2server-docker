#!/bin/sh

if [ ! -f /srv/$GAME/serverfiles/srcds_run ]
then
    echo "Executable not found!"
    exit;
fi

if [ ! -f /srv/${GAME}/addons/.speranza ]
then
    if [ ! -L /srv/${GAME}/serverfiles/left4dead2/addons ]
    then
        cp -r /srv/${GAME}/serverfiles/left4dead2/addons/* /srv/${GAME}/addons
        rm -rf /srv/${GAME}/serverfiles/left4dead2/addons
        ln -s /srv/${GAME}/addons /srv/${GAME}/serverfiles/left4dead2
    fi

    tar -zxvf -C /srv/${GAME} /tmp/mm.tar.gz
    tar -zxvf -C /srv/${GAME} /tmp/sm.tar.gz
    mv -v /srv/${GAME}/addons/sourcemod/* /srv/${GAME}/sourcemod/
    rm -rf /srv/${GAME}/addons/sourcemod
    ln -s /srv/${GAME}/sourcemod/ /srv/${GAME}/addons

    touch /srv/${GAME}/addons/.speranza
fi

if [ ! -f /srv/${GAME}/cfg/.speranza ]
then
    if [ ! -L /srv/${GAME}/serverfiles/left4dead2/cfg ]
    then
        cp -r /srv/${GAME}/serverfiles/left4dead2/cfg/* /srv/${GAME}/cfg
        rm -rf /srv/${GAME}/serverfiles/left4dead2/cfg
        ln -s /srv/${GAME}/cfg /srv/${GAME}/serverfiles/left4dead2
    fi

    touch /srv/${GAME}/cfg/.speranza
fi

/srv/$GAME/serverfiles/srcds_run -ip $BIND_IP -port $BIND_PORT -strictportbind "$@"