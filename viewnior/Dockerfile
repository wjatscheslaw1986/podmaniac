FROM docker.io/library/debian:bookworm-slim 

RUN apt update && apt upgrade -y
RUN apt install -y viewnior 
RUN rm -rf /var/lib/apt/lists/*

ARG GROUP_ID=9898
ARG USER_ID=9898

RUN groupadd -g $GROUP_ID --system testpilot && \
    useradd -m --gid $GROUP_ID --system -u $USER_ID testpilot \
    && mkdir -p /home/testpilot/.config \
    && mkdir -p /home/testpilot/.cache \
    && chown --recursive testpilot:testpilot /home/testpilot

COPY entrypoint.sh /entrypoint.sh
RUN chmod ugo+x /entrypoint.sh

USER testpilot

ENTRYPOINT ["/entrypoint.sh"]
CMD []
