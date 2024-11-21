FROM docker.io/library/debian:latest 

RUN apt update && apt upgrade -y
RUN apt install chromium -y 
RUN rm -rf /var/lib/apt/lists/*

ARG GROUP_ID=1000
ARG USER_ID=1000

COPY files/daemon.conf /etc/pulse/daemon.conf
COPY files/pulse-client.conf /etc/pulse/client.conf

RUN groupadd -g $GROUP_ID --system testpilot && \
    useradd -m --gid $GROUP_ID --system -u $USER_ID -G audio,video testpilot \
    && mkdir -p /home/testpilot/reports \
    && mkdir -p /home/testpilot/.config \
    && mkdir -p /home/testpilot/.cache \
    && chown --recursive testpilot:testpilot /home/testpilot

COPY files/entrypoint.sh /entrypoint.sh
RUN chmod ugo+x /entrypoint.sh

USER testpilot

ENTRYPOINT ["/entrypoint.sh"]
CMD []
