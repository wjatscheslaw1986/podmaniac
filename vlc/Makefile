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
	@ ${DOCKER} build -f Dockerfile_X11 -t ${IMG_NAME} .

build-wayland:
	@ ${DOCKER} build -f Dockerfile_Wayland -t ${IMG_NAME} .


run:
	@ ${DOCKER} run \
        --net=none \
        ${WITH_USERNS} \
        --log-level info \
        --log-driver json-file \
        -it --rm \
        --cpus 3.0 \
        --memory 8192m \
        -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
        -e DISPLAY=${DISPLAY} \
        --device /dev/snd \
        --device /dev/dri \
        -v /home/${ME}/Music:/opt/Music:ro \
        -v /home/${ME}/Videos:/opt/Videos:ro \
           -v /home/${ME}/Downloads:/opt/Downloads:ro \
        -v /opt/yt:/home/${USRNME}/YouTube:ro \
        -v /var/lib/dbus:/var/lib/dbus:rw \
        -v /opt/vlc:/home/${USRNME}:rw \
        -e XDG_RUNTIME_DIR=/run/user/${UUID}/ \
        -e PULSE_SERVER=unix:path=/run/user/${UUID}/pulse/native \
        -v ${XDG_RUNTIME_DIR}/pulse:/run/user/${UUID}/pulse:ro \
        -e DBUS_SESSION_BUS_ADDRESS=unix:path=/run/dbus/system_bus_socket \
        -v /run/dbus:/run/dbus:rw \
        ${IMG_NAME}
	
run-wayland:  
	@ x11docker \
        --backend=${DOCKER} \
        --network=none \
	--user=RETAIN \
        --group-add video \
        --group-add audio \
        --pulseaudio \
        --dbus=system \
        --share=/home/${ME}/Music \
        --share=/home/${ME}/Videos \
        -- \
            -v /opt/yt:/home/${USRNME}/YouTube:ro \
            --cpus 3.0 \
            --memory 8192m \
            --device /dev/snd \
            --device /dev/dri \
        -- \
        ${IMG_NAME} vlc

run-wayland-bluetooth:  
	@ x11docker \
        --backend=${DOCKER} \
        --network=none \
	--home \
        --group-add video \
        --group-add audio \
        --group-add bluetooth \
        --pulseaudio=socket \
        --dbus=system \
        --share=/home/${ME}/Music \
        --share=/home/${ME}/Videos \
        -- \
            -v /opt/yt:/home/${USRNME}/YouTube:ro \
            --cpus=2.0 \
            --memory=8192m \
            --device=/dev/snd \
            --device=/dev/dri \
        -- \
        ${IMG_NAME} vlc
