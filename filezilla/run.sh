#!/bin/bash
CONTAINER=$1
podman run \
    --uidmap=0:15:1 \
    --uidmap=9898:16:1 \
    --gidmap=0:15:1 \
    --gidmap=9898:16:1 \
    --rm -it \
    --cgroup-manager systemd \
    --net=slirp4netns \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -e DISPLAY=$DISPLAY \
    -v /dev/dri:/dev/dri:ro \
    -v $HOME/.config/filezilla:/home/testpilot/.config/:rw \
    -v $HOME/FTP:/opt:rw \
    $CONTAINER
