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
    -v /home/$(whoami)/Documents/keepass:/home/testpilot/Documents:rw \
    -v /home/$(whoami)/.config/keepass:/home/testpilot/.config/:rw \
    -e DISPLAY=$DISPLAY \
    $CONTAINER
