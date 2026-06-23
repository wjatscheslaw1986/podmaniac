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

SOCAT_PID=$!

cleanup() {
	kill "$SOCAT_PID" 2>/dev/null || true
}

trap cleanup EXIT INT TERM

export OPENAI_BASE_URL=http://127.0.0.1:8000/v1

cd /workspace/Code

hermes config set model.default Qwen3.6-27B
hermes config set model.provider custom
hermes config set model.context_length 26400
#hermes config set model.base_url http://my.model.com:4000/v1
#hermes config set model.api_key sk-xxxxxxxxxxxxxxxxx

hermes "$@"
