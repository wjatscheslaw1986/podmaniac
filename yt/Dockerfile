FROM docker.io/library/debian:bookworm-slim

RUN apt update && apt upgrade -y && apt install -y bash ffmpeg vim mc curl \
    python3 python3-dev python3-venv python3-pip pylint pipx python3-virtualenv \
    build-essential libssl-dev libffi-dev libpq-dev locales fonts-noto unicode \
    && apt clean && rm -rf /var/lib/apt/lists/*

ARG GROUP_ID=9898
ARG USER_ID=9898
ARG USRNME=ytber

RUN groupadd --gid $GROUP_ID --system $USRNME && \
    useradd --create-home --gid $GROUP_ID --system --uid $USER_ID $USRNME \
    && mkdir --parents /home/$USRNME/.config \
    && mkdir --parents /home/$USRNME/.cache \
    && mkdir --parents /home/$USRNME/.local/share \
    && chown --recursive $USRNME:$USRNME /home/$USRNME

COPY dwn_*.sh /home/$USRNME/

RUN chown -R 9898:9898 /home/$USRNME
RUN chmod +x /home/$USRNME/*.sh
WORKDIR /home/$USRNME

RUN locale-gen en_US.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

RUN dpkg-reconfigure locales

USER $USRNME

RUN python3 -m venv .venv
RUN .venv/bin/pip install yt-dlp

CMD ["/bin/bash"]

