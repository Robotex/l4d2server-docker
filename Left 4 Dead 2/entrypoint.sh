#!/bin/sh

/usr/games/steamcmd +runscript /srv/l4d2server/update.txt

mkdir -pv ~/.steam/sdk32/
ln -s ~/.steam/steamcmd/linux32/steamclient.so ~/.steam/sdk32/steamclient.so

/srv/l4d2server/serverfiles/srcds_run -ip $SRCDS_BIND_IP -port $SRCDS_BIND_PORT -secure +map c5m1_waterfront