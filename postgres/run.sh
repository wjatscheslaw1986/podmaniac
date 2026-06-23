#!/bin/sh
IMAGE=$1
CONTAINER=$2
podman run  \
  --read-only \
  --name ${CONTAINER} \
  --uidmap=0:400:1200 \
  --gidmap=0:400:1200 \
  -e POSTGRES_PASSWORD=$3 \
  -e POSTGRES_DB=$4 \
  -e POSTGRES_USER=$5 \
  -p 5432:5432 \
  -v $HOME/postgres/data:/var/lib/postgresql/data/pgdata \
  --tmpfs /tmp:rw,noexec,nosuid,size=64m \
  --tmpfs /run:rw,noexec,nosuid,size=16m \
  --tmpfs /var/run:rw,noexec,nosuid,size=16m \
  ${IMAGE}
