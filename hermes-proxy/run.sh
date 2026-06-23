#!/bin/sh
podman run \
  -d \
  --name hermes-proxy \
  -v "$HOME/.local/share/hermes-socket:/socket:Z" \
  hermes-proxy

