#!/bin/bash
IMAGE=$1
CONTAINER=$2
podman run \
    --log-level=error \
    --log-driver=json-file \
    --uidmap=0:21:1 \
    --uidmap=9898:22:1 \
    --gidmap=0:21:1 \
    --gidmap=9898:22:1 \
    --rm -it \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v /run/user/$(id -u)/pulse:/tmp/xdg/pulse:ro \
    -v /home/$(whoami)/Downloads:/home/testpilot/Downloads:rw \
    -v /opt/tg/cache:/home/testpilot/.cache:rw \
    -v /opt/tg/local:/home/testpilot/.local:rw \
    -v /opt/tg/config:/home/testpilot/.config:rw \
    -e DISPLAY=$DISPLAY \
    -e PULSE_SERVER=unix:path=/tmp/xdg/pulse/native \
    -e XDG_RUNTIME_DIR=/tmp/xdg \
    --device /dev/dri/card0 \
    --device /dev/snd \
    --device /dev/video0 \
    -v /var/run/dbus:/var/run/dbus:ro \
    --name $CONTAINER \
    $IMAGE
