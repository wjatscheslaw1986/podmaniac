SHELL=/bin/bash

DOCKER=podman

IMG_NAME=keepass
UUID=$(shell id -u)
ME=$(shell whoami)
USRNME=passwordmanager

list:
	@ $(MAKE) -pRrq -f Makefile : 2>/dev/null \
        | grep -e "^[^[:blank:]]*:$$\|#.*recipe to execute" \
        | grep -B 1 "recipe to execute" \
        | grep -e "^[^#]*:$$" \
        | sed -e "s/\(.*\):/\1/g" \
        | sort

build:
	@ ${DOCKER} build \
        -f Dockerfile_X11 \
        --build-arg=USRNME=${USRNME} \
        -t ${IMG_NAME} .

build-wayland:
	@ ${DOCKER} build \
        -f Dockerfile_Wayland \
        --build-arg=USRNME=${USRNME} \
        -t ${IMG_NAME} .

run:
	@ ${DOCKER} run \
        -it --rm \
        --cpus 1.0 \
        --memory 512m \
        --uidmap=0:119:1 \
        --uidmap=9898:120:1 \
        --gidmap=0:119:1 \
        --gidmap=9898:120:1 \
        --rm -it \
        --network=none \
        -v /opt/keepass:/home/${USRNME}/:rw \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
        -e DISPLAY=${DISPLAY} \
        ${IMG_NAME}
	
run-wayland:  
	@ x11docker \
        --clipboard=yes \
        --network=none \
        --user=RETAIN \
        --backend=podman \
        -- \
        --uidmap=0:119:1 \
        --uidmap=9898:120:1 \
        --gidmap=0:119:1 \
        --gidmap=9898:120:1  \
        -v /opt/keepass:/home/${USRNME}/:rw \
        -- \
        ${IMG_NAME} keepass2
