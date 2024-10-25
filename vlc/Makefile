SHELL=/bin/bash

DOCKER=podman

CH_IMAGE=vlc
UUID=$(shell id -u)
GUID=$(shell id -g)
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
	@ ${DOCKER} build -t ${CH_IMAGE} .

run:
	@ ${DOCKER} run \
		--net=none \
		--cgroup-manager systemd \
		${WITH_USERNS} \
		--log-level info \
		--log-driver json-file \
		-it --rm \
		-v /tmp/.X11-unix:/tmp/.X11-unix:ro \
		-e DISPLAY=:0.0 \
                -v /var/lib/dbus:/var/lib/dbus:ro \
		--device /dev/snd \
                -v /dev/dri:/dev/dri:ro \
		-e PULSE_SERVER=unix:/run/user/${UUID}/pulse/native \
		-e XDG_RUNTIME_DIR=/run/user/${UUID} \
		-v ${XDG_RUNTIME_DIR}/pulse:/run/user/${UUID}/pulse:ro \
		-v ${XDG_RUNTIME_DIR}/pulse/native:/run/user/${UUID}/pulse/native:ro \
		-v /home/${ME}/.config/pulse:/home/${USRNME}/.config/pulse:rw \
                -v /home/${ME}/Music:/home/${USRNME}/Music:ro \
		-v /home/${ME}/Videos:/home/${USRNME}/Videos:ro \
                -v /home/${ME}/Downloads:/home/${USRNME}/Downloads:ro \
		${CH_IMAGE}
