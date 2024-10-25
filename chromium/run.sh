#!/bin/bash
CONTAINER=$1
podman run \
    --rm -it \
    --userns=keep-id \
    --shm-size 1g \
    --cpus 3.0 \
    --memory 8192m \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v /home/$(whoami)/.config/chromium:/home/chromeuser/.config/chromium:rw \
    -v /home/$(whoami)/.cache/chromium:/home/chromeuser/.cache/chromium:rw \
    -v /home/$(whoami)/Downloads:/home/chromeuser/Downloads:rw \
    -v /dev/dri:/dev/dri:ro \
    --device /dev/snd \
    -e PULSE_SERVER=unix:/run/user/$(id -u)/pulse/native \
    -v $XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse:ro \
    -v $XDG_RUNTIME_DIR/pulse/native:$XDG_RUNTIME_DIR/pulse/native:ro\
    -v /home/$(whoami)/.config/pulse:/home/chromeuser/.config/pulse:ro \
    -v /etc/machine-id:/etc/machine-id:ro \
    -v /var/lib/dbus:/var/lib/dbus:ro \
    $CONTAINER


