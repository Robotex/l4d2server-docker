#!/bin/sh

if [ ! -f /srv/srcds/serverfiles/srcds_run ]
then
    echo "Executable not found!"
    exit;
fi

/srv/srcds/serverfiles/srcds_run -ip $BIND_IP -port $BIND_PORT -strictportbind "$@"