#!/bin/bash
CONTAINER=$1
podman run \
    --log-level=error \
    --log-driver=json-file \
    --uidmap=0:27:1 \
    --uidmap=9898:28:1 \
    --gidmap=0:27:1 \
    --gidmap=9898:28:1 \
    --cpus 2.0 \
    --memory 4096m \
    --rm -it \
    -v /opt/yt:/home/ytber:rw \
    $CONTAINER
