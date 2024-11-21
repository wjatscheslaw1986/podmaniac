FROM --platform=linux/amd64 docker.io/library/debian:latest 

COPY docker_files/entrypoint.sh /entrypoint.sh
RUN chmod ugo+x /entrypoint.sh

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt upgrade -y && apt install pulseaudio -y && apt install sayonara -y
RUN rm -rf /var/lib/apt/lists/*

ARG GROUP_ID=1000
ARG USER_ID=1000

RUN groupadd --system -g $GROUP_ID sayonara
RUN useradd --system --create-home -u $USER_ID -g sayonara sayonara
RUN usermod -aG audio sayonara

RUN echo "default-server = unix:/run/user/$USER_ID/pulse/native" >> /etc/pulse/client.conf

USER sayonara

ENTRYPOINT ["/entrypoint.sh"]
CMD []
