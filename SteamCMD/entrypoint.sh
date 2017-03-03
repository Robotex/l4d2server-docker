#!/bin/sh

/usr/games/steamcmd +runscript /srv/$GAME/update.txt

/srv/$GAME/start.sh "$@"
