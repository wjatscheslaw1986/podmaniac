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
    -v /opt/gwenview/config:/home/gwen/.config:rw \
    -v /opt/gwenview/cache:/home/gwen/.cache:rw \
    -v /opt/gwenview/local:/home/gwen/.local:rw \
    -v /home/$(whoami)/Pictures:/home/gwen/Pictures:ro \
    -v /home/$(whoami)/Downloads:/home/gwen/Downloads:ro \
    -e DISPLAY=$DISPLAY \
    -v /dev/dri:/dev/dri:ro \
    -e XDG_RUNTIME_DIR=/tmp/runtime \
    $CONTAINER
