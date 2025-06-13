#!/bin/bash

path=$HOME/.config/systemd/user/podman-vsftp.service

cat > "$path" << EOF
[Unit]
Description=Podman vsftp container service

[Service]
ExecStart=$HOME/Code/vsftpd/run.sh ftps
ExecStop=/usr/bin/podman stop ftps
ExecStopPost=/usr/bin/podman rm ftps
Restart=always

[Install]
WantedBy=default.target
EOF

