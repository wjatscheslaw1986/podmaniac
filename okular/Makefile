SHELL=/bin/bash

DOCKER=podman

IMG_NAME=okular
UUID=$(shell id -u)
ME=$(shell whoami)
USRNME=reader

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
        --cpus 2.0 \
        --backend=podman \
        --memory 4096m \
        --uidmap=0:10:1 \
        --uidmap=9898:11:1 \
        --gidmap=0:10:1 \
        --gidmap=9898:11:1 \
        --network=none \
        -v /opt/keepass:/home/${USRNME}/:rw \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
        -e DISPLAY=${DISPLAY} \
        ${IMG_NAME}
	
run-wayland:  
	@ x11docker \
        --network=none \
	--verbose \
        --backend=podman \
        -- \
        --uidmap=0:10:1 \
        --uidmap=9898:11:1 \
        --gidmap=0:10:1 \
        --gidmap=9898:11:1 \
        -- \
        ${IMG_NAME} okular
