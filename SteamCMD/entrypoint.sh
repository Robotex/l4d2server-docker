#!/bin/sh

if [ ! -d /srv/$GAME/serverfiles ]
then
    /usr/games/steamcmd +runscript /srv/$GAME/update.txt validate
else
    /usr/games/steamcmd +runscript /srv/$GAME/update.txt
fi

. /srv/$GAME/start.sh "$@"
