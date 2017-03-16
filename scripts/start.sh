#!/bin/sh

if [ ! -f /srv/srcds/serverfiles/srcds_run ]
then
    echo "Executable not found!"
    exit;
fi

/srv/srcds/serverfiles/srcds_run -game $SRCDS_GAME -ip $BIND_IP -port $BIND_PORT -strictportbind "$@" -autoupdate -steam_dir ~/.steam/steamcmd -steamcmd_script /srv/srcds/update.txt +hostname \"${SRCDS_HOSTNAME}\"