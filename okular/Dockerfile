FROM docker.io/library/debian:bookworm-slim 

RUN apt update && apt upgrade -y
RUN apt install okular -y && apt install -y kde-standard 
RUN rm -rf /var/lib/apt/lists/*

ARG GROUP_ID=9898
ARG USER_ID=9898
ARG USRNME=reader

RUN groupadd -g $GROUP_ID --system $USRNME && \
    useradd -m --gid $GROUP_ID --system -u $USER_ID $USRNME \
    && mkdir -p /home/$USRNME/.config \
    && mkdir -p /home/$USRNME/.cache \
    && chown --recursive $USER_ID:$GROUP_ID /home/$USRNME

COPY entrypoint.sh /entrypoint.sh
RUN chmod ugo+x /entrypoint.sh

USER $USRNME

ENTRYPOINT ["/entrypoint.sh"]
CMD []
