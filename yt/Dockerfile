FROM docker.io/library/debian:bookworm-slim

RUN apt update && apt upgrade -y && apt install -y bash ffmpeg vim mc git curl \
    python3 python3-dev python3-venv python3-pip pylint pipx python3-virtualenv \
    build-essential libssl-dev libffi-dev libpq-dev \
    && apt clean && rm -rf /var/lib/apt/lists/*

ARG GROUP_ID=9898
ARG USER_ID=9898
ARG USRNME=ytber
ARG GIT_EMAIL=taleskeeper@ya.ru
ARG GIT_NAME='"Viacheslav Mikhailov"'

RUN groupadd --gid $GROUP_ID --system $USRNME && \
    useradd --create-home --gid $GROUP_ID --system --uid $USER_ID $USRNME \
    && mkdir --parents /home/$USRNME/.config \
    && mkdir --parents /home/$USRNME/.cache \
    && mkdir --parents /home/$USRNME/.local/share \
    && chown --recursive $USRNME:$USRNME /home/$USRNME

RUN chown -R 9898:9898 /home/$USRNME
WORKDIR /home/$USRNME

RUN chown 9898:9898 .

USER $USRNME
RUN git config --global user.email $GIT_EMAIL
RUN git config --global user.name $GIT_NAME

RUN python3 -m venv .venv
RUN .venv/bin/pip install yt-dlp

#RUN echo "#!/bin/bash" > /home/$USRNME/download.sh
#RUN echo "if [[ \$# -ne 1 ]]; then" >> /home/$USRNME/download.sh
#RUN echo "exit 1" >> /home/$USRNME/download.sh
#RUN echo "fi" >> /home/$USRNME/download.sh
#RUN echo "yt-dlp -f \"bestvideo+bestaudio\" --write-auto-sub --sub-lang en --limit-rate 2M -o \"~/%(playlist_index)s-%(title)s.%(ext)s\" \"$1\" >> /home/$USRNME/download.sh
#RUN echo "#yt-dlp -f \"bestvideo+bestaudio\" -o "~/%(title)s.%(ext)s" \"$1\"" >> /home/$USRNME/download.sh

#RUN chmod ugo+x /home/$USRNME/download.sh

CMD ["/bin/bash"]
