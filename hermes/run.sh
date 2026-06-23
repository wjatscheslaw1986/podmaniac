#!/bin/bash
CONTAINER=$1
podman run \
    --rm -it \
    --network=none \
    -v "$HOME/.local/share/hermes-socket:/socket:Z" \
    -v "$HOME/Code:/workspace/Code:Z" \
    $CONTAINER
