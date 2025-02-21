#!/bin/bash
IMAGE=$1
CONTAINER=$2
podman create \
    --log-level=info \
    --log-driver=json-file \
    --uidmap=0:27:1 \
    --uidmap=9898:28:1 \
    --gidmap=0:27:1 \
    --gidmap=9898:28:1 \
    --cpus 2.0 \
    --memory 4096m \
    --rm -it \
    -v /opt/yt:/home/ytber:rw \
    --name $CONTAINER \
    $IMAGE
