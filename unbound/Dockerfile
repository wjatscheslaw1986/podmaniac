FROM docker.io/library/debian:latest

ARG OPENSSL_VERSION=openssl-3.5.0
ARG OPENSSL_SHA256=344d0a79f1a9b08029b0744e2cc401a43f9c90acd1044d09a530b4885a8e9fc0
ARG OPENSSL_DOWNLOAD_URL=https://github.com/openssl/openssl/releases/download/${OPENSSL_VERSION}/${OPENSSL_VERSION}.tar.gz
ARG OPENSSL_PGP_SIG=https://github.com/openssl/openssl/releases/download/openssl-3.5.0/openssl-3.5.0.tar.gz.asc
ARG NAME=unbound
ARG UNBOUND_VERSION=1.23.0
ARG UNBOUND_SHA256=959bd5f3875316d7b3f67ee237a56de5565f5b35fc9b5fc3cea6cfe735a03bb8
ARG UNBOUND_DOWNLOAD_URL=https://www.nlnetlabs.nl/downloads/unbound/unbound-${UNBOUND_VERSION}.tar.gz
ARG UNBOUND_PGP_SIG=https://www.nlnetlabs.nl/downloads/unbound/unbound-${UNBOUND_VERSION}.tar.gz.asc
ARG SUMMARY="${NAME} is a validating, recursive, and caching DNS resolver."
ARG DESCRIPTION="${NAME} is a validating, recursive, and caching DNS resolver."
ARG GROUP_ID=9898
ARG USER_ID=9898

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /tmp/src

RUN set -e -x && apt update && apt upgrade -y && apt install -y \
    build-essential \
    curl \
    ca-certificates \
    gpg \
    dirmngr \
    libidn2-0-dev \
    libssl-dev \
    libc-dev \
    libevent-dev \
    libexpat1-dev \
    libnghttp2-dev \
    bsdmainutils \
    ldnsutils \
    libevent-2.1-7 \
    libexpat1 \
    libprotobuf-c-dev \
    protobuf-c-compiler \
    ldnsutils \
    libevent-2.1-7 \
    libnghttp2-14 \
    libexpat1 \
    libprotobuf-c1

RUN set -e -x && \
    curl -L ${OPENSSL_DOWNLOAD_URL} -o openssl.tar.gz && \
    echo "${OPENSSL_SHA256} ./openssl.tar.gz" | sha256sum -c - && \
    curl -L ${OPENSSL_PGP_SIG} -o openssl.tar.gz.asc && \
    GNUPGHOME="$(mktemp -d)" && \
    export GNUPGHOME && \
    gpg --verify openssl.tar.gz.asc openssl.tar.gz && \
    tar xzf openssl.tar.gz && \
    cd $OPENSSL_VERSION && \
    ./config \
      --prefix=/opt/openssl \
      --openssldir=/opt/openssl \
      no-weak-ssl-ciphers \
      no-ssl3 \
      no-shared \
      enable-ec_nistp_64_gcc_128 \
      -DOPENSSL_NO_HEARTBEATS \
      -fstack-protector-strong && \
    make depend && \
    nproc | xargs -I % make -j% && \
    make install_sw && \
    rm -rf \
        /tmp/* \
        /var/tmp/* \
        /var/lib/apt/lists/*

RUN groupadd -g $GROUP_ID --system $NAME && \
    useradd -m --gid $GROUP_ID --system -u $USER_ID $NAME \
    && mkdir -p /home/$NAME/.config \
    && mkdir -p /home/$NAME/.cache \
    && chown --recursive $USER_ID:$GROUP_ID /home/$NAME

RUN set -e -x && \
    curl -sSL $UNBOUND_DOWNLOAD_URL -o unbound.tar.gz && \
    echo "${UNBOUND_SHA256} *unbound.tar.gz" | sha256sum -c - && \
    curl -L ${UNBOUND_PGP_SIG} -o openssl.tar.gz.asc && \
    gpg --verify openssl.tar.gz.asc unbound.tar.gz && \
    tar xzf unbound.tar.gz && \
    rm -f unbound.tar.gz && \
    cd unbound-${UNBOUND_VERSION} && \
    groupadd -g $GROUP_ID --system $NAME && \
    useradd -u $USER_ID --gid $GROUP_ID -g $NAME --system -d /etc/unbound $NAME && \
    ./configure \
        --disable-dependency-tracking \
        --with-pthreads \
        --with-username=$NAME \
        --with-ssl=/opt/openssl \
        --with-libevent \
        --with-libnghttp2 \
        --enable-dnstap \
        --enable-tfo-server \
        --enable-tfo-client \
        --enable-event-api \
        --enable-subnet && \
    make install && \
    rm -rf \
        /opt/unbound/share/man \
        /tmp/* \
        /var/tmp/* \
        /var/lib/apt/lists/*

WORKDIR /etc/unbound

RUN set -x && apt purge -y --auto-remove $BUILD_DEPS
RUN mv /etc/unbound/unbound.conf /etc/unbound/unbound.conf.bak
COPY docker_files/unbound.conf /etc/unbound/unbound.conf
COPY docker_files/a-records.conf /etc/unbound/a-records.conf
COPY docker_files/srv-records.conf /etc/unbound/srv-records.conf
COPY docker_files/forward-records.conf /etc/unbound/forward-records.conf
RUN rm -rf /etc/unbound/unbound.conf.d/*
RUN chown -R $NAME:$NAME /etc/unbound

#LABEL org.opencontainers.image.version=${UNBOUND_VERSION} \
#      org.opencontainers.image.title="vmikhailov/unbound" \
#      org.opencontainers.image.description="a validating, recursive, and caching DNS resolver" \
#      org.opencontainers.image.url="https://github.com/wjatscheslaw1986/unbound-podman-rootless" \
#      org.opencontainers.image.vendor="Viacheslav Mikhailov" \
#      org.opencontainers.image.licenses="MIT" \
#      org.opencontainers.image.source="https://github.com/wjatscheslaw1986/unbound-podman-rootless"

EXPOSE 53/tcp
EXPOSE 53/udp
EXPOSE 853/tcp
EXPOSE 853/udp

HEALTHCHECK --interval=30s --timeout=30s --start-period=10s --retries=3 CMD drill @127.0.0.1 cloudflare.com || exit 1

CMD ["/usr/sbin/unbound", "-c", "/etc/unbound/unbound.conf"]
