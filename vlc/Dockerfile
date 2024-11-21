FROM --platform=linux/amd64 docker.io/library/debian:latest 

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y && apt install pulseaudio -y && apt install vlc -y
RUN rm -rf /var/lib/apt/lists/*

ARG GROUP_ID=1000
ARG USER_ID=1000
ARG USRNME=mgibson

RUN groupadd --system -g $GROUP_ID $USRNME
RUN useradd --system --create-home -u $USER_ID -g $GROUP_ID -G audio,video $USRNME
RUN mkdir -p /home/$USRNME/.config \
    && mkdir -p /home/$USRNME/.cache \
    && mkdir -p /home/$USRNME/.local/share \
    && chown --recursive $USRNME:$USRNME /home/$USRNME

COPY files/daemon.conf /etc/pulse/daemon.conf
COPY files/pulse-client.conf /etc/pulse/client.conf
COPY files/entrypoint.sh /entrypoint.sh
RUN chmod ugo+x /entrypoint.sh

RUN echo "default-server = unix:/run/user/$USER_ID/pulse/native" >> /etc/pulse/client.conf

USER $USRNME

ENTRYPOINT ["/entrypoint.sh"]
CMD []
