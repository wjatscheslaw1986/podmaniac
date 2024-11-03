FROM docker.io/library/debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y
RUN apt install bash git neovim -y
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

WORKDIR /home/${USRNME}
USER $USRNME
RUN git clone https://github.com/Optixal/neovim-init.vim.git
WORKDIR /home/${USRNME}/neovim-init.vim/convenience
RUN /bin/bash install.sh
RUN /bin/bash font_install.sh

WORKDIR /home/$USRNME


CMD [ "nvim" ]
