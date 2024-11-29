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
		--cpus 4.0 \
        --memory 8192m \
		--shm-size 2G \
        -v /opt/chromium/config:/home/${USRNME}/.config:rw \
        -v /opt/chromium/cache:/home/${USRNME}/.cache:rw \
        -v /opt/chromium/reports:/home/${USRNME}/reports:rw \
        -v /opt/chromium/local:/home/${USRNME}/.local:rw \
        -v /home/${ME}/Downloads:/home/${USRNME}/Downloads:rw \
        --device /dev/dri \
        --device /dev/snd \
		-e DISPLAY=${DISPLAY} \
        -e PULSE_SERVER=unix:path=/tmp/xdg/pulse/native \
        -e XDG_RUNTIME_DIR=/tmp/xdg \
        -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
        -v /run/user/${UUID}/pulse:/tmp/xdg/pulse:ro \
        -v /run/user/${UUID}/bus:/tmp/xdg/bus:rw \
        -e DBUS_SESSION_BUS_ADDRESS=unix:path=/tmp/xdg/bus \
        -v /run/dbus/system_bus_socket:/run/dbus/system_bus_socket:rw \
		chromium

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
		chromium
