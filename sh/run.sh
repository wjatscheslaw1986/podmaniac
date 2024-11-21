#!/bin/bash
USRNME=testpilot
CONTAINER=$1
podman run \
    --uidmap=0:19:1 \
    --uidmap=9898:20:1 \
    --gidmap=0:19:1 \
    --gidmap=9898:20:1 \
    --rm -it \
    -h shell_for_vscode \
    -v /home/$(whoami)/Code:/home/$USRNME/Code:rw \
    -v /home/$(whoami)/.cache/Code:/home/$USRNME/.cache:rw \
    -v /home/$(whoami)/.local/share/Code:/home/$USRNME/.local/share:rw \
    -v /home/$(whoami)/.config/Code:/home/$USRNME/.config:rw \
    -v /home/$(whoami)/.vscode:/home/$USRNME/.vscode:rw \
    -v /tmp:/tmp:rw \
    --name=vscshell \
    -w /home/$USRNME/Code \
    $CONTAINER
