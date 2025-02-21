FROM --platform=linux/amd64 docker.io/library/debian:bookworm-slim

COPY files/sources.list /sources.list
RUN cat /sources.list > /etc/apt/sources.list 
RUN rm /etc/apt/sources.list.d/* && rm /sources.list

RUN apt update && apt upgrade -y && apt --fix-broken install -y && apt install apt-transport-https -y

RUN apt install -y xfce4 xdg-utils

RUN apt install xz-utils alsa-oss alsa-utils pulseaudio ca-certificates ffmpeg -y

RUN apt clean && rm -rf /var/lib/apt/lists/*

ARG GROUP_ID=9898
ARG USER_ID=9898
ARG USRNME=testpilot

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

RUN groupadd --gid $GROUP_ID --system $USRNME && \
    useradd --create-home --gid $GROUP_ID --system --uid $USER_ID -G audio,video $USRNME \
    && mkdir --parents /home/$USRNME/.config \
    && mkdir --parents /home/$USRNME/.cache \
    && mkdir --parents /home/$USRNME/.local/share \
    && chown --recursive $USRNME:$USRNME /home/$USRNME

COPY tsetup.*.tar.xz /home/$USRNME/tg.tar.xz
RUN chown -R $USRNME:$USRNME /home/$USRNME
WORKDIR /home/$USRNME/
USER $USRNME
RUN tar xf tg.tar.xz
WORKDIR /home/$USRNME/Telegram
CMD "./Telegram"
