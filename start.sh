#!/bin/sh

if [ ! -f /srv/srcds/serverfiles/srcds_run ]
then
    echo "Executable not found!"
    exit;
fi

/srv/srcds/serverfiles/srcds_run -game $SRCDS_GAME -ip $BIND_IP -port 27015 +hostport $BIND_PORT -strictportbind "$@"