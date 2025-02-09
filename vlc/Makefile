SHELL=/bin/bash

DOCKER=podman

IMG_NAME=vlc
UUID=$(shell id -u)
ME=$(shell whoami)
USRNME=mgibson

WITH_USERNS=$$(eval [ "podman" == "${DOCKER}" ] && echo "--userns=keep-id")

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
		--net=none \
		${WITH_USERNS} \
		--log-level info \
		--log-driver json-file \
		-it --rm \
		--cpus 2.0 \
                --memory 8192m \
	        -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
		-e DISPLAY=${DISPLAY} \
		--device /dev/snd \
		--device /dev/dri \
                -v /home/${ME}/Music:/opt/Music:ro \
		-v /home/${ME}/Videos:/opt/Videos:ro \
                -v /home/${ME}/Downloads:/opt/Downloads:ro \
		-v /var/lib/dbus:/var/lib/dbus:ro \
		-v /opt/vlc:/home/${USRNME}:rw \
		-e XDG_RUNTIME_DIR=/tmp \
                -e PULSE_SERVER=unix:/tmp/pulse/native \
                -v ${XDG_RUNTIME_DIR}/pulse:/tmp/pulse:ro \
                -e DBUS_SESSION_BUS_ADDRESS=unix:path=/run/dbus/system_bus_socket \
                -v /run/dbus:/run/dbus:rw \
		${IMG_NAME}
