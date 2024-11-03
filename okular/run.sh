#!/bin/bash
CONTAINER=okular
podman run \
    --uidmap=0:9:1 \
    --uidmap=9898:10:1 \
    --gidmap=0:9:1 \
    --gidmap=9898:10:1 \
    --rm -it \
    --network=none \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v /home/$(whoami)/Documents/okulaar:/home/reader/Documents:rw \
    -v /home/$(whoami)/.config/okular:/home/reader/.config/:rw \
    -e DISPLAY=$DISPLAY \
    -v /dev/dri:/dev/dri:ro \
    $CONTAINER
