#!/bin/bash
CONTAINER=$1
podman run \
    --log-level=error \
    --log-driver=json-file \
    --uidmap=0:19:1 \
    --uidmap=9898:20:1 \
    --gidmap=0:19:1 \
    --gidmap=9898:20:1 \
    --rm -it \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v /home/$(whoami)/Code:/home/testpilot/Code:rw \
    -v /opt/vs/cache:/home/testpilot/.cache:rw \
    -v /opt/vs/local:/home/testpilot/.local:rw \
    -v /opt/vs/config:/home/testpilot/.config:rw \
    -v /opt/vs/vscode:/home/testpilot/.vscode:rw \
    -e DISPLAY=$DISPLAY \
    --device=/dev/dri/card0 \
    $CONTAINER
