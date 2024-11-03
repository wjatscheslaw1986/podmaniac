SHELL=/bin/bash

DOCKER=podman

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
    	--log-level info \
		--log-driver json-file \
		-it --rm \
        --uidmap=0:7:1 \
        --uidmap=9898:8:1 \
        --gidmap=0:7:1 \
        --gidmap=9898:8:1 \
        --gidmap=29:6:1 \
        --gidmap=44:5:1 \
        --gidmap=108:4:1 \
		--cpus 3.0 \
        --memory 8192m \
		--shm-size 2G \
        -v /home/${ME}/.config/Chromium/chromium:/home/${USRNME}/.config/chromium:rw \
        -v /home/${ME}/.cache/Chromium/chromium:/home/${USRNME}/.cache/chromium:rw \
        -v /home/${ME}/reports/Chromium:/home/${USRNME}/reports:rw \
        -v /home/${ME}/Downloads:/home/${USRNME}/Downloads:rw \
        -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
        --device /dev/dri/card0 \
        -v /dev/dri:/dev/dri:ro \
		-e DISPLAY=${DISPLAY} \
        --device /dev/snd \
        -e PULSE_SERVER=unix:path=/run/user/9898/pulse/native \
        -e XDG_RUNTIME_DIR=/run/user/9898 \
        -v ${XDG_RUNTIME_DIR}/pulse:/run/user/9898/pulse:ro \
        -v ${XDG_RUNTIME_DIR}/bus:/run/user/9898/bus:rw \
        -e DBUS_SESSION_BUS_ADDRESS=unix:path=/run/dbus/system_bus_socket \
        -v /run/dbus:/run/dbus:rw \
        -v /var/run/dbus:/var/run/dbus:rw \
		chromium3

run-keep-uid:
	@ ${DOCKER} run \
        --log-level info \
		--log-driver json-file \
		-it --rm \
		--userns=keep-id \
		--cpus 4.0 \
        --memory 8192m \
        --shm-size 2G \
        -v /home/${ME}/.config/chromium:/home/${USRNME}/.config/chromium:rw \
        -v /home/${ME}/.cache/chromium:/home/${USRNME}/.cache/chromium:rw \
        -v /home/${ME}/Downloads:/home/${USRNME}/Downloads:rw \
        -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
		-e DISPLAY=${DISPLAY} \
        --device /dev/snd \
        --device /dev/dri/card0 \
        -e XDG_RUNTIME_DIR=/tmp \
        -e PULSE_SERVER=unix:/tmp/pulse/native \
        -v ${XDG_RUNTIME_DIR}/pulse:/tmp/pulse:ro \
        -v /home/${ME}/.config/pulse:/home/${USRNME}/.config/pulse:ro \
        -e DBUS_SESSION_BUS_ADDRESS=unix:path=/run/dbus/system_bus_socket \
        -v /run/dbus:/run/dbus:rw \
        -v /var/run/dbus:/var/run/dbus:rw \
		chromium
