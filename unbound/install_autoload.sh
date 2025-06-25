#!/bin/bash

SERVICE_NAME=${1:-unbound}

mkdir -p $HOME/$SERVICE_NAME/{log,root,etc}

echo 'IMPORTANT: CHOWN DIR STRUCTURE TO THE SUBUID:SUBGID IF RELEVENT: chown -R 100124:100124 '$HOME/$SERVICE_NAME

cp ./docker_files/* $HOME/$SERVICE_NAME/etc
cp unbound_run.sh $HOME/.local/bin/ && chmod +x $HOME/.local/bin/unbound_run.sh

# Copy DNS root files
if [ -d /usr/share/dns ]; then
  cp /usr/share/dns/* "$HOME/$SERVICE_NAME/root" 2>/dev/null || echo "Warning: Nothing in /usr/share/dns or copy failed"
else
  echo "Warning: /usr/share/dns does not exist. Try search for root.hints somewhere else."
fi

#curl -o $HOME/$SERVICE_NAME/root/root.hints https://www.internic.net/domain/named.cache
#echo '#!/bin/bash' > /etc/cron.monthly/curl_root_name_hints.sh
#echo 'wget https://www.internic.net/domain/named.cache -O $HOME/unbound/root/root.hints' >> /etc/cron.monthly/curl_root_name_hints.sh
#chmod +x /etc/cron.monthly/curl_root_name_hints.sh

servicepath=$HOME/.config/systemd/user/podman-$SERVICE_NAME.service

cat > "$servicepath" << EOF
[Unit]
Description=Podman unbound container service
Before=network.target

[Service]
ExecStart=$HOME/.local/bin/unbound_run.sh $SERVICE_NAME
#ExecStartPost=/usr/bin/curl -o $HOME/$SERVICE_NAME/root/root.hints https://www.internic.net/domain/named.cache
ExecStop=/usr/bin/podman stop $SERVICE_NAME
ExecStopPost=/usr/bin/podman rm --force $SERVICE_NAME
Restart=always
TimeoutStartSec=20
TimeoutStopSec=5

[Install]
WantedBy=default.target
EOF

systemctl --user enable $servicepath
loginctl enable-linger $(whoami)
