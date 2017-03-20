#!/bin/sh

if [ ! -f /usr/games/gameserver/serverfiles/srcds_run ]
then
    echo "Executable not found!"
    exit;
fi

_trap() {
    echo "---Stop signal received!---"
    touch /var/lock/gameserver.lock
}

_trapForward() {
    kill -2 "$childpid" 2>/dev/null
}

rm /var/lock/gameserver.lock

trap _trap 15
trap _trapForward 2

/usr/games/gameserver/serverfiles/srcds_run -game $SRCDS_GAME -ip $BIND_IP -port $BIND_PORT -strictportbind "$@" -autoupdate -steam_dir ~/.steam/steamcmd -steamcmd_script /usr/games/gameserver/update.txt +hostname \"${SRCDS_HOSTNAME}\" &

childpid=$! 
while wait $childpid; test $? -gt 128; do
    kill -0 $childpid 2> /dev/null || break;
done

trap - 2
trap - 15