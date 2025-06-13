#!/bin/bash
mkdir -p /tmp/vsftp/logs && podman run \
    --uidmap=0:3:1 \
    --uidmap=9898:4:1 \
    --gidmap=0:3:1 \
    --gidmap=9898:4:1 \
    --rm -it \
    -p 21:21 \
    -p 20:20 \
    -p 21100-21110:21100-21110 \
    -v /disk01:/home/ftpuser/ftp/ftp:rw \
    -v /tmp/vsftp/logs:/tmp:rw \
    $1
