FROM docker.io/library/debian:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y && apt install -y bash ffmpeg vim mc curl \
    iproute2 python3 python3-dev python3-venv python3-pip \
    pylint pipx python3-virtualenv \
    build-essential libssl-dev libffi-dev libpq-dev locales fonts-noto unicode \
    && apt clean && rm -rf /var/lib/apt/lists/*

ARG GROUP_ID=9898
ARG USER_ID=9898
ARG USRNME=pythoner

RUN groupadd --gid $GROUP_ID --system $USRNME && \
    useradd --create-home --gid $GROUP_ID --system --uid $USER_ID $USRNME \
    && mkdir --parents /home/$USRNME/.config \
    && mkdir --parents /home/$USRNME/.cache \
    && mkdir --parents /home/$USRNME/.local/share \
    && chown --recursive $USRNME:$USRNME /home/$USRNME

COPY proxy.py /proxy.py
RUN chown -R $USER_ID:$GROUP_ID /home/$USRNME
RUN chown -R $USER_ID:$GROUP_ID /proxy.py
USER $USRNME

RUN pip install requests

CMD ["python", "/proxy.py"]
