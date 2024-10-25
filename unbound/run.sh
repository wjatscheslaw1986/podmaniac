#!/bin/bash
CONTAINER=$1
podman run \
    --rm -it \
    --uidmap=0:1:1 \
    --gidmap=0:1:1 \
    --uidmap=9898:2:1 \
    --gidmap=9898:2:1 \
    -p 53:53 \
    -p 853:853 \
    --name=unbound \
    ${CONTAINER}
