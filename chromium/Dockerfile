FROM --platform=linux/amd64 docker.io/library/debian:latest 

RUN apt update && apt upgrade -y \
    && apt install alsa-oss alsa-utils pulseaudio ca-certificates ffmpeg bluetooth bluez chromium -y \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

ARG GROUP_ID=9898
ARG USER_ID=9898
ARG USR_NAME=chromeuser

RUN echo "default-sample-format = s32le # Варианты s16le, s32le, float32le" > /etc/pulse/daemon.conf
RUN echo "default-sample-rate = 192000 # как вариант 48000, 96000, 192000, 320000" >> /etc/pulse/daemon.conf
RUN echo "alternate-sample-rate = 44100 # как вариант 44100, 88200" >> /etc/pulse/daemon.conf
RUN echo "default-sample-channels = 2" >> /etc/pulse/daemon.conf
RUN echo "default-channel-map = front-left,front-right" >> /etc/pulse/daemon.conf
RUN echo "default-fragments = 2 # по умолчанию 4" >> /etc/pulse/daemon.conf
RUN echo "default-fragment-size-msec = 125 # по умолчанию 25" >> /etc/pulse/daemon.conf
RUN echo "resample-method = soxr-vhq # Варианты src-sinc-best-quality, soxr-vhq, copy, speex-float-1" >> /etc/pulse/daemon.conf
RUN echo "remixing-produce-lfe=no # yes для 2+1, 5+1 и т.д." >> /etc/pulse/daemon.conf
RUN echo "remixing-consume-lfe=no # yes для 2+1, 5+1 и т.д." >> /etc/pulse/daemon.conf
RUN echo "high-priority = yes" >> /etc/pulse/daemon.conf
RUN echo "nice-level = -11" >> /etc/pulse/daemon.conf
RUN echo "realtime-scheduling = yes" >> /etc/pulse/daemon.conf
RUN echo "realtime-priority = 9 # по умолчанию 5" >> /etc/pulse/daemon.conf
RUN echo "rlimit-rtprio = 9" >> /etc/pulse/daemon.conf
RUN echo "daemonize = no" >> /etc/pulse/daemon.conf
RUN echo "PULSE DAEMON:" && cat /etc/pulse/daemon.conf

RUN echo "autospawn = no" > /etc/pulse/client.conf
RUN echo "daemon-binary = /bin/true" >> /etc/pulse/client.conf
RUN echo "enable-shm = false" >> /etc/pulse/client.conf
RUN echo "default-server = unix:/run/user/$USER_ID/pulse/native" >> /etc/pulse/client.conf
RUN echo "PULSE CLIENT:" && cat /etc/pulse/client.conf

RUN groupadd -g $GROUP_ID --system ${USR_NAME} && \
    useradd -m --gid $GROUP_ID --system -u $USER_ID -G audio,video,bluetooth ${USR_NAME} \
    && mkdir -p /home/${USR_NAME}/reports \
    && mkdir -p /home/${USR_NAME}/.config \
    && mkdir -p /home/${USR_NAME}/.cache \
    && mkdir -p /home/${USR_NAME}/.local/share \
    && chown --recursive ${USR_NAME}:${USR_NAME} /home/${USR_NAME}

USER ${USR_NAME}
RUN mkdir -p /tmp/xdg

CMD "chromium"
