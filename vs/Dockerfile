FROM docker.io/library/debian:latest

RUN apt update && apt upgrade -y
RUN apt install xfce4 xdg-utils git -y
RUN rm -rf /var/lib/apt/lists/*

ARG GROUP_ID=9898
ARG USER_ID=9898
ARG USRNME=testpilot
ARG DEBIAN_FRONTEND=noninteractive
ARG GIT_EMAIL=taleskeeper@ya.ru
ARG GIT_NAME='"Viacheslav Mikhailov"'

RUN groupadd -g $GROUP_ID --system $USRNME && \
    useradd -m --gid $GROUP_ID --system -u $USER_ID $USRNME \
    && mkdir -p /home/$USRNME/.config \
    && mkdir -p /home/$USRNME/.cache \
    && mkdir -p /home/$USRNME/.local/share \
    && chown --recursive $USRNME:$USRNME /home/$USRNME

COPY vs.deb /root/vs.deb
WORKDIR /root
RUN dpkg -i vs.deb
RUN apt -f install

COPY entrypoint.sh /entrypoint.sh
RUN chmod ugo+x /entrypoint.sh

WORKDIR /home/$USRNME
USER $USRNME
RUN git config --global user.email $GIT_EMAIL
RUN git config --global user.name $GIT_NAME

ENTRYPOINT ["/entrypoint.sh"]
CMD []
