#!/bin/sh

podman run  \
  --read-only \
  --name mysql \
  --uidmap=0:200:1 \
  --uidmap=999:201:1 \
  --uidmap=1000:202:198 \
  --gidmap=0:200:1 \
  --gidmap=999:201:1 \
  --gidmap=1000:202:198 \
  -e MYSQL_ROOT_PASSWORD=secret \
  -e MYSQL_DATABASE=mydb \
  -e MYSQL_USER=myuser \
  -e MYSQL_PASSWORD=mypass \
  -p 3306:3306 \
  -v $HOME/mysql/data:/var/lib/mysql \
  --tmpfs /tmp:rw,noexec,nosuid,size=64m \
  --tmpfs /run:rw,noexec,nosuid,size=16m \
  --tmpfs /var/run:rw,noexec,nosuid,size=16m \
  mysql:8.0
