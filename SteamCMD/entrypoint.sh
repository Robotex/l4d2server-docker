#!/bin/sh

if [ ! -d /srv/$GAME/serverfiles ]
then
    /usr/games/steamcmd +runscript /srv/$GAME/update.txt validate
else
    /usr/games/steamcmd +runscript /srv/$GAME/update.txt
fi

source /srv/$GAME/start.sh "$@"
