#!/bin/bash
IMAGE=$1
COMMAND=$2
x11docker --clipboard=yes --network=none --user=RETAIN --backend=podman -- --uidmap=0:119:1 --uidmap=9898:120:1 --gidmap=0:119:1 --gidmap=9898:120:1  -v /opt/keepass:/home/testpilot:rw -- $IMAGE $COMMAND
