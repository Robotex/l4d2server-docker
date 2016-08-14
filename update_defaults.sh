#!/bin/sh
# Author: Robotex

find_and_replace() {
    sed -i.bak "s/$1/$2/g" l4d2server
    local retval=$?
    if [ "$retval" != 0 ]
    then
        echo "Default $1 was not found!"
        exit 1
    fi
    rm l4d2server.bak
}

find_and_replace 'githubuser="dgibbs64"' 'githubuser="Robotex"'
find_and_replace 'updateonstart="off"' 'updateonstart="on"'
