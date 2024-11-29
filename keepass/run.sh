#!/bin/bash
CONTAINER=$1
podman run \
    --uidmap=0:119:1 \
    --uidmap=9898:120:1 \
    --gidmap=0:119:1 \
    --gidmap=9898:120:1 \
    --rm -it \
    --net=none \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v /opt/keepass:/home/testpilot/:rw \
    -e DISPLAY=$DISPLAY \
    $CONTAINER
