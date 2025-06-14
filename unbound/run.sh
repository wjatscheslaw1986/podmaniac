#!/bin/bash
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
    --name=unbound \
    $1
