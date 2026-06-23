#!/usr/bin/env bash
set -euo pipefail

SOCKET=/socket/model.sock

if [[ ! -S "$SOCKET" ]]; then
    echo "Missing model socket"
    exit 1
fi

socat \
  TCP-LISTEN:8000,reuseaddr,fork \
  UNIX-CONNECT:$SOCKET &

trap 'kill $!' EXIT

export OPENAI_BASE_URL=http://127.0.0.1:8000/v1

cd /workspace/Code

exec hermes "$@"
