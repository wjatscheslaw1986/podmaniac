#!/bin/sh
podman run \
  -d \
  --name hermes-proxy \
  -e MODEL_URL="http://my.model.com:4000" \
  -e MODEL_API_KEY="xxxxx" \
  -v "$HOME/.local/share/hermes-socket:/socket:Z" \
  hermes-proxy

