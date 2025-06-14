#!/bin/bash

path=$HOME/.config/systemd/user/podman-unbound.service

cat > "$path" << EOF
[Unit]
Description=Podman unbound container service

[Service]
ExecStart=$HOME/.local/bin/run.sh unbound
ExecStop=/usr/bin/podman stop unbound
ExecStopPost=/usr/bin/podman rm unbound
Restart=always

[Install]
WantedBy=default.target
EOF

