SHELL=/bin/bash

DOCKER=podman

IMG_NAME=chrm
UUID=$(shell id -u)
GUID=$(shell id -g)
ME=$(shell whoami)
USRNME=chromeuser

list:
	@ $(MAKE) -pRrq -f Makefile : 2>/dev/null \
		| grep -e "^[^[:blank:]]*:$$\|#.*recipe to execute" \
		| grep -B 1 "recipe to execute" \
		| grep -e "^[^#]*:$$" \
		| sed -e "s/\(.*\):/\1/g" \
		| sort

build:
	@ ${DOCKER} build -t ${IMG_NAME} .

run:
	@ ${DOCKER} run \
		-it --rm \
		--userns=keep-id \
		--cpus 3.0 \
        --memory 8192m \
        --shm-size 2G \
		-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
		-e DISPLAY=${DISPLAY} \
        -v /var/lib/dbus:/var/lib/dbus:ro \
		--device /dev/snd \
		--device /dev/dri/card0 \
		-e PULSE_SERVER=unix:/run/user/${UUID}/pulse/native \
		-e XDG_RUNTIME_DIR=/run/user/${UUID} \
		-v ${XDG_RUNTIME_DIR}/pulse:/run/user/${UUID}/pulse:ro \
		-v /home/${ME}/.config/pulse:/home/${USRNME}/.config/pulse:rw \
        -v /home/${ME}/.config/chromium:/home/${USRNME}/.config/chromium:rw \
        -v /home/${ME}/.cache/chromium:/home/${USRNME}/.cache/chromium:rw \
        -v /home/${ME}/Downloads:/home/${USRNME}/Downloads:ro \
		chromium

run-deaf:
	@ ${DOCKER} run \
        --uidmap=0:7:1 \
        --uidmap=9898:8:1 \
        --gidmap=0:7:1 \
        --gidmap=9898:8:1 \
        --gidmap=29:6:1 \
        --gidmap=44:5:1 \
        --gidmap=108:4:1 \
        --rm -it \
        --cpus 3.0 \
        --memory 8192m \
        --shm-size 2G \
        -e DISPLAY=${DISPLAY} \
        -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
        -v /home/${ME}/.config/Chromium/chromium:/home/${USRNME}/.config/chromium:rw \
        -v /home/${ME}/.cache/Chromium/chromium:/home/${USRNME}/.cache/chromium:rw \
        -v /home/${ME}/Downloads:/home/${USRNME}/Downloads:rw \
        --device /dev/snd \
        --device /dev/dri/card0 \
        -v /dev/snd:/dev/snd:ro \
        -e PULSE_SERVER=unix:/tmp/run/pulse/native \
        -v ${XDG_RUNTIME_DIR}/pulse:/tmp/run/pulse:ro \
        -v /home/${ME}/.config/pulse:/home/${USRNME}/.config/pulse:ro \
        -v /etc/machine-id:/etc/machine-id:ro \
		-v /var/lib/dbus:/var/lib/dbus:ro \
	    chrm
