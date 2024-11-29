#!/bin/bash
CONTAINER=$1
podman run \
    --uidmap=0:10:1 \
    --uidmap=9898:11:1 \
    --gidmap=0:10:1 \
    --gidmap=9898:11:1 \
    --rm -it \
    --network=none \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v /opt/okular:/home/reader:rw \
    -e DISPLAY=$DISPLAY \
    -v /dev/dri:/dev/dri:ro \
    $CONTAINER
