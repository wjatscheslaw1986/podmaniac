FROM docker.io/library/debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y
RUN apt install bash vim mc git python3 python3-pip build-essential libssl-dev libffi-dev python3-dev -y
RUN rm -rf /var/lib/apt/lists/*

ARG GROUP_ID=9898
ARG USER_ID=9898
ARG USRNME=testpilot

RUN groupadd -g $GROUP_ID --system $USRNME && \
    useradd -m --gid $GROUP_ID --system -u $USER_ID $USRNME \
    && mkdir -p /home/$USRNME/.config \
    && mkdir -p /home/$USRNME/.cache \
    && mkdir -p /home/$USRNME/.local/share \
    && chown --recursive $USRNME:$USRNME /home/$USRNME

COPY .vimrc /home/${USRNME}/
RUN chown -R 9898:9898 /home/${USRNME} 

WORKDIR /home/$USRNME
USER $USRNME

CMD [ "/bin/bash" ]
