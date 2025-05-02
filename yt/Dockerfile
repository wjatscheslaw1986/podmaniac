FROM docker.io/library/debian:bookworm-slim

RUN apt update && apt upgrade -y && apt install -y bash ffmpeg vim mc curl \
    python3 python3-dev python3-venv python3-pip pylint pipx python3-virtualenv \
    build-essential libssl-dev libffi-dev libpq-dev \
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

COPY dwn_mus_playlist.sh /dwn_mus_playlist.sh
COPY dwn_mus_track.sh /dwn_mus_track.sh
COPY dwn_vid_bq_engsub.sh /dwn_vid_bq_engsub.sh
COPY dwn_vid_bq.sh /dwn_vid_bq.sh
COPY dwn_vid_custom1.sh /dwn_vid_custom1.sh
COPY dwn_vid_playlist_engsub_custom1.sh /dwn_vid_playlist_engsub_custom1.sh
COPY dwn_vid_playlist_engsub.sh /dwn_vid_playlist_engsub.sh
COPY dwn_vid_playlist.sh /dwn_vid_playlist.sh
COPY dwn_vid_pq.sh /dwn_vid_pq.sh

RUN chown -R 9898:9898 /home/$USRNME
RUN chmod +x /*.sh
WORKDIR /home/$USRNME
USER $USRNME

RUN python3 -m venv .venv
RUN .venv/bin/pip install yt-dlp

CMD ["/bin/bash"]

