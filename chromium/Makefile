SHELL=/bin/bash

DOCKER=podman
UUID=$(shell id -u)
GUID=$(shell id -g)
ME=$(shell whoami)
MY_UID=$(shell id -u)
USRNME=chromeuser
IMG_NAME=chromium

build:
	@ echo "Собираем образ Chromium для запуска в ином пространстве имён" && \
        ${DOCKER} build -t ${IMG_NAME} .

build-keep-uid:
	@ echo "Собираем образ Chromium для запуска от имени пользователя ${ME}" && \
        ${DOCKER} build -t ${IMG_NAME}${MY_UID} --build-arg USER_ID=${MY_UID} --build-arg GROUP_ID=${MY_UID} --build-arg USR_NAME=${ME} .

# Запустить образ Chromium в ином пространстве имён
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
	--cpus 3.5 \
        --memory 4096m \
	--shm-size 2G \
        -v /opt/${IMG_NAME}/config:/home/${USRNME}/.config:rw \
        -v /opt/${IMG_NAME}/cache:/home/${USRNME}/.cache:rw \
        -v /opt/${IMG_NAME}/reports:/home/${USRNME}/reports:rw \
        -v /opt/${IMG_NAME}/local:/home/${USRNME}/.local:rw \
        -v /home/${ME}/Downloads:/home/${USRNME}/Downloads:rw \
        -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
        -v /run/user/${UUID}/pulse/native:/tmp/xdg/pulse/native:rw \
        --device /dev/dri/card0 \
        --device /dev/snd \
        --device /dev/video0 \
	-e DISPLAY=${DISPLAY} \
        -e PULSE_SERVER=unix:path=/tmp/xdg/pulse/native \
        -e XDG_RUNTIME_DIR=/tmp/xdg \
	${IMG_NAME}

# Запустить образ Chromium от имени обычного пользователя
run-keep-uid:
	@ ${DOCKER} run \
        --log-level info \
	--log-driver json-file \
	-it --rm \
	--userns=keep-id \
	--cpus 3.5 \
        --memory 4096m \
        --shm-size 2G \
        -v /opt/${IMG_NAME}${MY_UID}/config:/home/${ME}/.config:rw \
        -v /opt/${IMG_NAME}${MY_UID}/cache:/home/${ME}/.cache:rw \
        -v /opt/${IMG_NAME}${MY_UID}/reports:/home/${ME}/reports:rw \
        -v /opt/${IMG_NAME}${MY_UID}/local:/home/${ME}/.local:rw \
        -v /home/${ME}/Downloads:/home/${ME}/Downloads:rw \
        -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
	-e DISPLAY=${DISPLAY} \
        --device /dev/snd \
        --device /dev/dri/card0 \
        --device /dev/video0 \
        -e XDG_RUNTIME_DIR=/tmp \
        -e PULSE_SERVER=unix:/tmp/pulse/native \
        -v ${XDG_RUNTIME_DIR}/pulse:/tmp/pulse:ro \
        -e DBUS_SESSION_BUS_ADDRESS=unix:path=/run/dbus/system_bus_socket \
        -v /run/dbus:/run/dbus:rw \
        ${IMG_NAME}${MY_UID}

# Запустить анонимный агностический браузер в ином пространстве имён
run-anon:
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
	--cpus 3.5 \
        --memory 4096m \
        -v /home/${ME}/Downloads:/home/${USRNME}/Downloads:rw \
        -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
	-e DISPLAY=${DISPLAY} \
	${IMG_NAME}
