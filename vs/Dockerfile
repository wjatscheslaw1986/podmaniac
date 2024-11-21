FROM docker.io/library/debian:latest

RUN apt update && apt upgrade -y \
    && apt install -y xfce4 xdg-utils \
    && apt clean && rm -rf /var/lib/apt/lists/*
RUN apt update && apt upgrade -y && apt install -y git vim curl \
    python3 python3-dev python3-venv python3-pip pylint pipx python3-virtualenv \
    build-essential libssl-dev libffi-dev libpq-dev \
    && apt clean && rm -rf /var/lib/apt/lists/*

ARG GROUP_ID=9898
ARG USER_ID=9898
ARG USRNME=testpilot
ARG GIT_EMAIL=taleskeeper@ya.ru
ARG GIT_NAME='"Viacheslav Mikhailov"'

RUN groupadd --gid $GROUP_ID --system $USRNME && \
    useradd --create-home --gid $GROUP_ID --system --uid $USER_ID $USRNME \
    && mkdir --parents /home/$USRNME/.config \
    && mkdir --parents /home/$USRNME/.cache \
    && mkdir --parents /home/$USRNME/.local/share \
    && chown --recursive $USRNME:$USRNME /home/$USRNME

COPY code_*_amd64.deb /root/vs.deb
WORKDIR /root
RUN dpkg -i vs.deb
RUN apt -f install

COPY entrypoint.sh /entrypoint.sh
RUN chmod ugo+x /entrypoint.sh

WORKDIR /home/$USRNME
RUN JDK23_SHA256SUM=$(curl https://download.java.net/java/GA/jdk23.0.1/c28985cbf10d4e648e4004050f8781aa/11/GPL/openjdk-23.0.1_linux-x64_bin.tar.gz.sha256) \
    && curl -o jdk23.tar.gz https://download.java.net/java/GA/jdk23.0.1/c28985cbf10d4e648e4004050f8781aa/11/GPL/openjdk-23.0.1_linux-x64_bin.tar.gz \
    && JDK23_ACTUAL_SHA256SUM=$(sha256sum jdk23.tar.gz) \
    && if [ $JDK23_ACTUAL_SHA256SUM != $JDK23_SHA256SUM ]; then \
            echo "Error: The sha256sum of the file does not match the expected value."; \
            echo "Expected: $JDK23_SHA256SUM"; \
            echo "Actual:   $JDK23_ACTUAL_SHA256SUM"; \
            exit 1; \
        fi
RUN tar -xzvf jdk23.tar.gz -C .
RUN chown -R 9898:9898 .
USER $USRNME
RUN git config --global user.email $GIT_EMAIL
RUN git config --global user.name $GIT_NAME
ENV usrnme=${USRNME}
ENTRYPOINT /entrypoint.sh $usrnme
