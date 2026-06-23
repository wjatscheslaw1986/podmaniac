#!/usr/bin/env bash

set -euo pipefail

usage() {
    cat <<EOF
Usage:
    $0 MODEL_URL MODEL_API_KEY

Example:
    $0 http://my.model.com:4000 sk-xxxxxxxxxxxxxxxx

EOF
}

error() {
    echo "ERROR: $*" >&2
    exit 1
}

#
# Validate arguments
#
[[ $# -ge 1 ]] || {
    usage
    error "MODEL_URL is required."
}

MODEL_URL="$1"

read -rsp "Paste API key here: " MODEL_API_KEY
echo

[[ -n "$MODEL_API_KEY" ]] || \
    error "API key cannot be empty."

#
# Validate required files
#
SERVICE_FILE="hermes-proxy.service"

[[ -f "$SERVICE_FILE" ]] || \
    error "Missing service file: $SERVICE_FILE"

#
# Create directories
#
mkdir -p "$HOME/.config/systemd/user"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/share/hermes-socket"

#
# Write environment file
#
ENV_FILE="$HOME/.config/hermes-proxy.env"

{
    printf 'MODEL_URL=%q\n' "$MODEL_URL"
    printf 'MODEL_API_KEY=%q\n' "$MODEL_API_KEY"
} > "$ENV_FILE"

chmod 600 "$ENV_FILE"

#
# Install service
#
cp "$SERVICE_FILE" \
   "$HOME/.config/systemd/user/hermes-proxy.service"

#
# Reload and enable
#
systemctl --user daemon-reload
systemctl --user enable hermes-proxy.service
systemctl --user restart hermes-proxy.service

#Check if it is working
sleep 2
systemctl --user is-active hermes-proxy.service >/dev/null || {
    systemctl --user --no-pager status hermes-proxy.service
    error "Service failed to start."
}

echo
echo "Installed successfully."
echo "Environment file: $ENV_FILE"

#journalctl --user -u hermes-proxy.service -f


