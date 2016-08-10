#!/bin/sh
# SteamCMD downloader script for Docker automated builds
# Author: Robotex

while [ "${exitcode}" != "0" ]; do
    ./steamcmd.sh +login anonymous +force_install_dir ./serverfiles +app_update 222860 validate +quit
    exitcode=$?
done