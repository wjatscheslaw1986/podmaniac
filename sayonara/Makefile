SHELL=/bin/bash

DOCKER=podman

IMG_NAME=sayonara
UUID=$(shell id -u)
GUID=$(shell id -g)
ME=$(shell whoami)

WITH_USERNS=$$(eval [ "podman" == "${DOCKER}" ] && echo "--userns=keep-id")

list:
	@ $(MAKE) -pRrq -f Makefile : 2>/dev/null \
    | grep -e "^[^[:blank:]]*:$$\|#.*recipe to execute" \
    | grep -B 1 "recipe to execute" \
    | grep -e "^[^#]*:$$" \
    | sed -e "s/\(.*\):/\1/g" \
    | sort

build:
	@ ${DOCKER} build -f Dockerfile_X11 -t ${IMG_NAME} .

build-wayland:
	@ ${DOCKER} build -f Dockerfile_Wayland -t ${IMG_NAME} .

run:
	@ ${DOCKER} run \
    --cgroup-manager systemd \
    ${WITH_USERNS} \
    --log-level info \
    --log-driver json-file \
    -it --rm \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -e DISPLAY=${DISPLAY} \
    -v /var/lib/dbus:/var/lib/dbus:ro \
    --device /dev/snd \
    -e PULSE_SERVER=unix:/run/user/${UUID}/pulse/native \
    -e XDG_RUNTIME_DIR=/run/user/${UUID} \
    -v ${XDG_RUNTIME_DIR}/pulse:/run/user/${UUID}/pulse:ro \
    -v /opt/sayonara:/home/sayonara/.config/sayonara:rw \
    -v /home/${ME}/Music:/home/sayonara/Music:ro \
    -v /media/${ME}/android/Music:/home/sayonara/SDCard:ro \
    ${IMG_NAME}

run-wayland:
	@ x11docker \
    --backend=${DOCKER} \
    --network=none \
    --group-add audio \
    --pulseaudio \
    --dbus=system \
    --user=RETAIN \
    --share=/home/${ME}/Music \
    -- \
    -v /media/${ME}/android/Music:/home/sayonara/SDCard:ro \
    -it --rm \
    --device /dev/snd \
    -- \
    ${IMG_NAME} sayonara

run-wayland-bluetooth:
	@ x11docker \
    --backend=${DOCKER} \
    --network=none \
    --group-add audio \
    --group-add bluetooth \
    --pulseaudio=socket \
    --dbus=system \
    --share=/home/${ME}/Music \
    -- \
    -v /media/${ME}/android/Music:/home/sayonara/SDCard:ro \
    -it --rm \
    -- \
    ${IMG_NAME} sayonara
