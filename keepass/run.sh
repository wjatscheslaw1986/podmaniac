#!/bin/bash
IMAGE=$1
podman run \
    --uidmap=0:119:1 \
    --uidmap=9898:120:1 \
    --gidmap=0:119:1 \
    --gidmap=9898:120:1 \
    --rm -it \
    --net=none \
    -v /opt/keepass:/home/testpilot/:rw \
    -e DISPLAY=$DISPLAY \
    -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
    -v /run/user/1000:/run/user/9898:rw \
    $IMAGE
