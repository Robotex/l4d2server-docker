#!/bin/sh

if [ -f /srv/$GAME/serverfiles/srcds_run ]
then
    /srv/$GAME/serverfiles/srcds_run -ip $BIND_IP -port $BIND_PORT -strictportbind "$@"
else
    echo "Executable not found!"
fi