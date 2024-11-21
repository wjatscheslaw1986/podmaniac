#!/bin/bash
CONTAINER=viewinor
podman run \
    --uidmap=0:11:1 \
    --uidmap=9898:12:1 \
    --gidmap=0:11:1 \
    --gidmap=9898:12:1 \
    --rm \
    -it \
    --cgroup-manager systemd \
    --shm-size 10m \
    --net=none \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v /home/$(whoami)/Pictures:/home/testpilot/Pictures:ro \
    -v /home/$(whoami)/Downloads:/home/testpilot/Downloads:ro \
    -v /home/$(whoami)/.config/viewinor:/home/testpilot/.config:rw \
    -e DISPLAY=$DISPLAY \
    -v /dev/dri:/dev/dri:ro \
    $CONTAINER
