#!/usr/bin/env bash

set -euo pipefail

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

journalctl --user -u hermes-proxy.service -f


