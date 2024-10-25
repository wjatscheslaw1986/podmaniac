FROM docker.io/library/debian:latest 

RUN apt update && apt upgrade -y
RUN apt install ca-certificates chromium -y 
RUN rm -rf /var/lib/apt/lists/*

ARG GROUP_ID=1000
ARG USER_ID=1000
ARG USR_NAME=chromeuser

COPY files/daemon.conf /etc/pulse/daemon.conf
COPY files/pulse-client.conf /etc/pulse/client.conf

RUN groupadd -g $GROUP_ID --system ${USR_NAME} && \
    useradd -m --gid $GROUP_ID --system -u $USER_ID -G audio,video ${USR_NAME} \
    && mkdir -p /home/${USR_NAME}/reports \
    && mkdir -p /home/${USR_NAME}/.config \
    && mkdir -p /home/${USR_NAME}/.cache \
    && chown --recursive ${USR_NAME}:${USR_NAME} /home/${USR_NAME}

COPY files/entrypoint.sh /entrypoint.sh
RUN chmod ugo+x /entrypoint.sh

USER ${USR_NAME}

CMD ["chromium"]
