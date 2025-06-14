FROM docker.io/library/debian:latest

ARG OPENSSL_VERSION=3.5.0
ARG OPENSSL_SHA256=344d0a79f1a9b08029b0744e2cc401a43f9c90acd1044d09a530b4885a8e9fc0
ARG OPENSSL_DOWNLOAD_URL=https://github.com/openssl/openssl/releases/download/openssl-${OPENSSL_VERSION}/openssl-${OPENSSL_VERSION}.tar.gz
ARG OPENSSL_PGP_SIG=https://github.com/openssl/openssl/releases/download/openssl-${OPENSSL_VERSION}/openssl-${OPENSSL_VERSION}.tar.gz.asc
ARG NAME=unbound
ARG UNBOUND_VERSION=1.23.0
ARG UNBOUND_SHA256=959bd5f3875316d7b3f67ee237a56de5565f5b35fc9b5fc3cea6cfe735a03bb8
ARG UNBOUND_DOWNLOAD_URL=https://www.nlnetlabs.nl/downloads/unbound/unbound-${UNBOUND_VERSION}.tar.gz
ARG UNBOUND_PGP_SIG=https://www.nlnetlabs.nl/downloads/unbound/unbound-${UNBOUND_VERSION}.tar.gz.asc
ARG SUMMARY="${NAME} is a validating, recursive, and caching DNS resolver."
ARG DESCRIPTION="${NAME} is a validating, recursive, and caching DNS resolver."
ARG GROUP_ID=9898
ARG USER_ID=9898
ARG OPENSSL_GPG_PUBKEY='BA5473A2B0587B07FB27CF2D216094DFD0CB81EF'
ARG RICHARD_LEVITTE='7953AC1FBC3DC8B3B292393ED5E9E43F7DF9EE8C'
ARG MATT_CASWELL='8657ABB260F056B1E5190839D9C4D26D0E604491'
ARG PAUL_DALE='B7C1C14360F353A36862E4D5231C84CDDCC69C45'
ARG TOMAS_MRAZ='A21FAB74B0088AA361152586B8EF1A6BA9DA2D5C'

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /tmp/src

RUN set -e -x && apt update && apt upgrade -y && apt install -y \
    build-essential \
    curl \
    ca-certificates \
    dnsutils \
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
    curl -L $OPENSSL_DOWNLOAD_URL -o openssl.tar.gz && \
    echo "${OPENSSL_SHA256} *openssl.tar.gz" | sha256sum -c - && \
    curl -L $OPENSSL_PGP_SIG -o openssl.tar.gz.asc && \
    gpg --no-tty --keyserver keys.openpgp.org --recv-keys $OPENSSL_GPG_PUBKEY $MATT_CASWELL $RICHARD_LEVITTE $TOMAS_MRAZ $PAUL_DALE && \
    gpg --verify openssl.tar.gz.asc openssl.tar.gz && \
    tar xf openssl.tar.gz

RUN ls -hal

RUN cd openssl-$OPENSSL_VERSION && ./config \
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
    make install_sw

RUN rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

RUN groupadd -g $GROUP_ID --system $NAME && \
    useradd -m --gid $GROUP_ID --system -u $USER_ID $NAME \
    && mkdir -p /home/$NAME/.config \
    && mkdir -p /home/$NAME/.cache \
    && chown --recursive $USER_ID:$GROUP_ID /home/$NAME

RUN set -e -x && \
    curl -sSL $UNBOUND_DOWNLOAD_URL -o unbound.tar.gz && \
    echo "${UNBOUND_SHA256} *unbound.tar.gz" | sha256sum -c - && \
    curl -L ${UNBOUND_PGP_SIG} -o unbound-${UNBOUND_VERSION}.tar.gz.asc && \
    gpg --keyserver keys.openpgp.org --recv-keys EDFAA3F2CA4E6EB05681AF8E9F6F1C2D7E045F8D && \
    gpg --verify unbound-${UNBOUND_VERSION}.tar.gz.asc unbound.tar.gz && \
    tar xzf unbound.tar.gz && \
    rm -f unbound.tar.gz

RUN cd unbound-${UNBOUND_VERSION} && \
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
        make install

RUN mkdir -p /usr/share/dns
COPY root/root.* /usr/share/dns/
RUN chmod 777 /usr/share/dns && chmod 666 /usr/share/dns/*
RUN mkdir -p /opt/unbound/log && chmod 777 /opt/unbound/log

RUN rm -rf \
        /opt/unbound/share/man \
        /tmp/* \
        /var/tmp/* \
        /var/lib/apt/lists/*

RUN set -x && apt purge -y --auto-remove build-essential curl
RUN mv /usr/local/etc/unbound/unbound.conf /usr/local/etc/unbound/unbound.conf.bak
COPY docker_files/unbound.conf /usr/local/etc/unbound/unbound.conf
COPY docker_files/a-records.conf /usr/local/etc/unbound/a-records.conf
COPY docker_files/srv-records.conf /usr/local/etc/unbound/srv-records.conf
COPY docker_files/forward-records.conf /usr/local/etc/unbound/forward-records.conf
RUN rm -rf /usr/local/etc/unbound/unbound.conf.d/*

WORKDIR /var/log/unbound/

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

#HEALTHCHECK --interval=30s --timeout=30s --start-period=10s --retries=3 CMD drill @127.0.0.1 cloudflare.com || exit 1

CMD ["/usr/local/sbin/unbound", "-c", "/usr/local/etc/unbound/unbound.conf"]
