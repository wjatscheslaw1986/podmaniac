FROM docker.io/library/debian:bookworm-slim

RUN apt update && apt upgrade -y \
    && apt install -y xfce4 xdg-utils \
    && apt clean && rm -rf /var/lib/apt/lists/*
RUN apt update && apt upgrade -y \
    && apt install -y xz-utils \
    && apt clean && rm -rf /var/lib/apt/lists/*


ARG GROUP_ID=9898
ARG USER_ID=9898
ARG USRNME=testpilot

RUN groupadd --gid $GROUP_ID --system $USRNME && \
    useradd --create-home --gid $GROUP_ID --system --uid $USER_ID $USRNME \
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
