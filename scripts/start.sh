#!/bin/sh

if [ ! -f /usr/games/gameserver/serverfiles/srcds_run ]
then
    echo "Executable not found!"
    exit;
fi

_trapTERM() {
    echo "---TERM signal received!---"
    kill -15 "$childpid" 2>/dev/null
}

_trapINT() {
    echo "---INT signal signal!---"
    kill -2 "$childpid" 2>/dev/null
}

_trapHUP() {
    echo "---HUP signal signal!---"
    kill -1 "$childpid" 2>/dev/null
}

_trapUSR1() {
    echo "---USR1 signal signal!---"
    kill -10 "$childpid" 2>/dev/null
}

rm /var/lock/gameserver.lock || true

trap _trapTERM 15

/usr/games/gameserver/serverfiles/srcds_run -game "$SRCDS_GAME" -strictportbind -ip "$BIND_IP" -port "$BIND_PORT" -pingboost 2 -timeout 0 +exec server/autoexec.cfg -norestart -steam_dir ~/.steam/steamcmd -steamcmd_script /usr/games/gameserver/update.txt +hostname \""${SRCDS_HOSTNAME}"\" "$@" &

childpid=$! 
while wait $childpid; test $? -gt 128; do
    kill -0 $childpid 2> /dev/null || break;
done

trap - 15