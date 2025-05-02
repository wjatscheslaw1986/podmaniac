SHELL=/bin/bash

DOCKER=podman

IMG_NAME=vscode
UUID=$(shell id -u)
GUID=$(shell id -g)
ME=$(shell whoami)
CONTAINER_USER=vscoder

WITH_USERNS=$$(eval [ "podman" == "${DOCKER}" ] && echo "--userns=keep-id")

list:
	@ $(MAKE) -pRrq -f Makefile : 2>/dev/null \
		| grep -e "^[^[:blank:]]*:$$\|#.*recipe to execute" \
		| grep -B 1 "recipe to execute" \
		| grep -e "^[^#]*:$$" \
		| sed -e "s/\(.*\):/\1/g" \
		| sort

build-x11:
	@ ${DOCKER} build -f Dockerfile_X11 -t ${IMG_NAME} .

build-wayland:
	@ ${DOCKER} build -f Dockerfile_Wayland -t ${IMG_NAME} .


run-x11:
	@ ${DOCKER} run \
		--log-level=error \
		--log-driver=json-file \
		--uidmap=0:19:1 \
		--uidmap=9898:20:1 \
		--gidmap=0:19:1 \
		--gidmap=9898:20:1 \
		--rm -it \
		-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
		-v /home/${ME}/Code:/home/${CONTAINER_USER}/Code:rw \
		-v /opt/vs/cache:/home/${CONTAINER_USER}/.cache:rw \
		-v /opt/vs/local:/home/${CONTAINER_USER}/.local:rw \
		-v /opt/vs/config:/home/${CONTAINER_USER}/.config:rw \
		-v /opt/vs/vscode:/home/${CONTAINER_USER}/.vscode:rw \
		-e DISPLAY=$DISPLAY \
		--device=/dev/dri/card0 \
		${IMG_NAME}

run-wayland:
	@ x11docker \
		--backend=${DOCKER} \
		--clipboard=yes \
		--verbose \
		-- \
		--cap-add=sys_chroot \
		--cpus 3.5 \
		--shm-size 2G \
		-v /home/${ME}/Code:/home/${CONTAINER_USER}/Code:rw \
		-v /opt/vs/.cache:/home/${CONTAINER_USER}/.cache:rw \
		-v /opt/vs/.local:/home/${CONTAINER_USER}/.local:rw \
		-v /opt/vs/.config:/home/${CONTAINER_USER}/.config:rw \
		-v /opt/vs/.vscode:/home/${CONTAINER_USER}/.vscode:rw  \
		-- \
		${IMG_NAME}
