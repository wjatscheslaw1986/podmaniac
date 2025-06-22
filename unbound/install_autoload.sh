#!/bin/bash

SERVICE_NAME=${1:-unbound}

mkdir -p $HOME/$SERVICE_NAME/{log,root}

curl -o $HOME/$SERVICE_NAME/root/root.hints https://www.internic.net/domain/named.cache
#echo '#!/bin/bash' > /etc/cron.monthly/curl_root_name_hints.sh
#echo 'wget https://www.internic.net/domain/named.cache -O $HOME/unbound/root/root.hints' >> /etc/cron.monthly/curl_root_name_hints.sh
#chmod +x /etc/cron.monthly/curl_root_name_hints.sh

path=$HOME/.config/systemd/user/podman-$SERVICE_NAME.service

cat > "$path" << EOF
[Unit]
Description=Podman unbound container service

[Service]
ExecStart=$HOME/.local/bin/unbound_run.sh $SERVICE_NAME
ExecStop=/usr/bin/podman stop $SERVICE_NAME
ExecStopPost=/usr/bin/podman rm $SERVICE_NAME
Restart=always

[Install]
WantedBy=default.target
EOF

