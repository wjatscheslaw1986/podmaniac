#!/bin/bash

SERVICE_NAME=${1:-unbound}

podman run \
    --rm -it \
    --uidmap=0:124:1 \
    --gidmap=0:124:1 \
    --uidmap=9898:125:1 \
    --gidmap=9898:125:1 \
    -p 53:53/tcp \
    -p 853:853/tcp \
    -p 53:53/udp \
    -p 853:853/udp \
    --name=$SERVICE_NAME \
    -v $HOME/$SERVICE_NAME/etc:/usr/local/etc/unbound \
    -v $HOME/$SERVICE_NAME/log:/opt/unbound/log:rw \
    -v $HOME/$SERVICE_NAME/root:/opt/unbound/root:rw \
    $1
