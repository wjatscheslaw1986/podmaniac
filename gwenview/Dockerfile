FROM docker.io/library/debian:bookworm-slim 

RUN apt update && apt upgrade -y
RUN apt install gwenview -y && apt install -y kde-plasma-desktop 
RUN rm -rf /var/lib/apt/lists/*

ARG GROUP_ID=9898
ARG USER_ID=9898
ARG USR_NAME=gwen

RUN groupadd -g $GROUP_ID --system ${USR_NAME} && \
    useradd -m --gid $GROUP_ID --system -u $USER_ID ${USR_NAME} \
    && mkdir -p /home/${USR_NAME}/.config \
    && mkdir -p /home/${USR_NAME}/.cache \
    && chown --recursive ${USR_NAME}:${USR_NAME} /home/${USR_NAME}

COPY entrypoint.sh /entrypoint.sh
RUN chmod ugo+x /entrypoint.sh

USER ${USR_NAME}

ENTRYPOINT ["/entrypoint.sh"]
CMD []
