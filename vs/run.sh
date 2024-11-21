#!/bin/bash
CONTAINER=$1
podman run \
    --uidmap=0:19:1 \
    --uidmap=9898:20:1 \
    --gidmap=0:19:1 \
    --gidmap=9898:20:1 \
    --rm -it \
    --cgroup-manager=cgroupfs \
    --shm-size 300m \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v /home/$(whoami)/Code:/home/testpilot/Code:rw \
    -v /home/$(whoami)/.cache/Code:/home/testpilot/.cache:rw \
    -v /home/$(whoami)/.local/share/Code:/home/testpilot/.local/share:rw \
    -v /home/$(whoami)/.config/Code:/home/testpilot/.config:rw \
    -v /home/$(whoami)/.vscode:/home/testpilot/.vscode:rw \
    -e DISPLAY=$DISPLAY \
    -v /dev/dri:/dev/dri:ro \
    -v /var/run/dbus:/var/run/dbus:ro \
    $CONTAINER
