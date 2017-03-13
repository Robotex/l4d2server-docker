#!/bin/sh

if [ ! -f /srv/srcds/serverfiles/srcds_run ]
then
    echo "Executable not found!"
    exit;
fi

while test $# -gt 0
do
    case "$1" in
        --install-sm)
            tar -zxvf /tmp/mm.tar.gz -C /srv/srcds
            tar -zxvf /tmp/sm.tar.gz -C /srv/srcds
            ;;
        --*) echo "bad option $1"
            ;;
    esac
    shift
done

/srv/srcds/serverfiles/srcds_run -game $SRCDS_GAME -ip $BIND_IP -port 27015 +hostport $BIND_PORT -strictportbind "$@"