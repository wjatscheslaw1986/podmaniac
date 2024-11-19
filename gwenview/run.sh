#!/bin/bash
CONTAINER=$1
podman run \
    --uidmap=0:13:1 \
    --uidmap=9898:14:1 \
    --gidmap=0:13:1 \
    --gidmap=9898:14:1 \
    --rm \
    -it \
    --net=none \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v /home/$(whoami)/Pictures:/home/gwen/Pictures:rw \
    -v /home/$(whoami)/Downloads:/home/gwen/Downloads:ro \
    -v /home/$(whoami)/.config/gwenview:/home/testpilot/.config:rw \
    -e DISPLAY=$DISPLAY \
    -v /dev/dri:/dev/dri:ro \
    $CONTAINER
