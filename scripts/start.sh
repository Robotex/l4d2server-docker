#!/bin/sh

if [ ! -f /usr/games/gameserver/serverfiles/srcds_run ]
then
    echo "Executable not found!"
    exit;
fi

_trap() {
    echo "---TRAP!---"
    kill -TERM "$child" 2>/dev/null
}

trap _trap 2 SIGTERM SIGHUP

/usr/games/gameserver/serverfiles/srcds_run -game $SRCDS_GAME -ip $BIND_IP -port $BIND_PORT -strictportbind "$@" -autoupdate -steam_dir ~/.steam/steamcmd -steamcmd_script /usr/games/gameserver/update.txt +hostname \"${SRCDS_HOSTNAME}\" &

child=$! 
wait "$child"