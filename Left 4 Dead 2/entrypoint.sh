#!/bin/sh

/usr/games/steamcmd +runscript update_l4d2_ds.txt

/opt/l4d2/game/srcds_run -ip $SRCDS_BIND_IP -port $SRCDS_BIND_PORT -secure +map c5m1_waterfront