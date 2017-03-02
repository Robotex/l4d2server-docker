#!/bin/sh

/usr/games/steamcmd +runscript /srv/$GAME/update.txt

/srv/$GAME/serverfiles/srcds_run -ip $BIND_IP -port $BIND_PORT -strictportbind "$@"