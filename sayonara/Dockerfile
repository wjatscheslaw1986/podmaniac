FROM --platform=linux/amd64 docker.io/library/debian:latest 

COPY files/sources.list /sources.list

RUN cat /sources.list > /etc/apt/sources.list 
RUN rm /etc/apt/sources.list.d/* && rm /sources.list

RUN apt update && apt upgrade -y \
    && apt install apt-transport-https -y \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt update && apt upgrade -y \
    && apt --fix-broken install \
    && apt install alsa-oss alsa-utils pulseaudio ca-certificates sayonara -y \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

ARG GROUP_ID=1000
ARG USER_ID=1000
ARG USRNME=sayonara

RUN groupadd --system -g $GROUP_ID $USRNME
RUN useradd --system --create-home -u $USER_ID -g $GROUP_ID $USRNME
RUN usermod -aG audio $USRNME

COPY files/daemon.conf /etc/pulse/daemon.conf
COPY files/pulse-client.conf /etc/pulse/client.conf
RUN echo "default-server = unix:/run/user/$USER_ID/pulse/native" >> /etc/pulse/client.conf

USER $USRNME

CMD "sayonara"
