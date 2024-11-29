#!/bin/bash
CONTAINER=$1
podman run \
    --uidmap=0:15:1 \
    --uidmap=9898:16:1 \
    --gidmap=0:15:1 \
    --gidmap=9898:16:1 \
    --rm -it \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -e DISPLAY=$DISPLAY \
    -v /opt/filezilla:/home/testpilot:rw \
    $CONTAINER
