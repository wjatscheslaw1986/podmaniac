FROM --platform=linux/amd64 docker.io/library/debian:latest 

RUN apt update && apt upgrade -y \
    && apt install alsa-oss alsa-utils pulseaudio ca-certificates ffmpeg chromium -y \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

ARG GROUP_ID=9898
ARG USER_ID=9898
ARG USR_NAME=chromeuser

COPY files/daemon.conf /daemon.conf
COPY files/pulse-client.conf /pulse-client.conf
RUN cat /daemon.conf > /etc/pulse/daemon.conf
RUN cat /pulse-client.conf > /etc/pulse/client.conf

RUN groupadd -g $GROUP_ID --system ${USR_NAME} && \
    useradd -m --gid $GROUP_ID --system -u $USER_ID -G audio,video ${USR_NAME} \
    && mkdir -p /home/${USR_NAME}/reports \
    && mkdir -p /home/${USR_NAME}/.config \
    && mkdir -p /home/${USR_NAME}/.cache \
    && mkdir -p /home/${USR_NAME}/.local/share \
    && chown --recursive ${USR_NAME}:${USR_NAME} /home/${USR_NAME}

RUN echo "default-server = unix:/run/user/$USER_ID/pulse/native" >> /etc/pulse/client.conf

USER ${USR_NAME}
RUN mkdir -p /tmp/xdg

CMD "chromium"
