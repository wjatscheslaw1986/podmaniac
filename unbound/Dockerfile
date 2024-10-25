FROM docker.io/library/debian:latest

ENV VERSION_OPENSSL=openssl-3.3.2 \
    SHA256_OPENSSL=2e8a40b01979afe8be0bbfb3de5dc1c6709fedb46d6c89c10da114ab5fc3d281 \
    SOURCE_OPENSSL=https://www.openssl.org/source/ \
    # OpenSSL OMC
    OPGP_OPENSSL_1=EFC0A467D613CB83C7ED6D30D894E2CE8B3D79F5 \
    # Richard Levitte
    OPGP_OPENSSL_2=7953AC1FBC3DC8B3B292393ED5E9E43F7DF9EE8C \
    # Matt Caswell
    OPGP_OPENSSL_3=8657ABB260F056B1E5190839D9C4D26D0E604491 \
    # Paul Dale
    OPGP_OPENSSL_4=B7C1C14360F353A36862E4D5231C84CDDCC69C45 \
    # Tomas Mraz
    OPGP_OPENSSL_5=A21FAB74B0088AA361152586B8EF1A6BA9DA2D5C \
    NAME=unbound \
    UNBOUND_VERSION=1.20.0 \
    UNBOUND_SHA256=56b4ceed33639522000fd96775576ddf8782bb3617610715d7f1e777c5ec1dbf \
    UNBOUND_DOWNLOAD_URL=https://www.nlnetlabs.nl/downloads/unbound/unbound-1.20.0.tar.gz \
    SUMMARY="${NAME} is a validating, recursive, and caching DNS resolver." \
    DESCRIPTION="${NAME} is a validating, recursive, and caching DNS resolver." \
    GROUP_ID=9898 \
    USER_ID=9898 \
    DEBIAN_FRONTEND=noninteractive \
    BUILD_DEPS="build-essential curl"

WORKDIR /tmp/src

RUN set -e -x && apt update && apt upgrade -y && apt install -y \
    $BUILD_DEPS \
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
    curl -L ${SOURCE_OPENSSL}${VERSION_OPENSSL}.tar.gz -o openssl.tar.gz && \
    echo "${SHA256_OPENSSL} ./openssl.tar.gz" | sha256sum -c - && \
    curl -L ${SOURCE_OPENSSL}${VERSION_OPENSSL}.tar.gz.asc -o openssl.tar.gz.asc && \
    GNUPGHOME="$(mktemp -d)" && \
    export GNUPGHOME && \
    gpg --no-tty --keyserver keyserver.ubuntu.com --recv-keys "$OPGP_OPENSSL_1" "$OPGP_OPENSSL_2" "$OPGP_OPENSSL_3" "$OPGP_OPENSSL_4" "$OPGP_OPENSSL_5" && \
    gpg --batch --verify openssl.tar.gz.asc openssl.tar.gz && \
    tar xzf openssl.tar.gz && \
    cd $VERSION_OPENSSL && \
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

RUN set -e -x && \
    curl -sSL $UNBOUND_DOWNLOAD_URL -o unbound.tar.gz && \
    echo "${UNBOUND_SHA256} *unbound.tar.gz" | sha256sum -c - && \
    tar xzf unbound.tar.gz && \
    rm -f unbound.tar.gz && \
    cd unbound-1.20.0 && \
    groupadd -g $GROUP_ID --system ${NAME} && \
    useradd -u $USER_ID --gid $GROUP_ID -g ${NAME} --system -d /etc/unbound ${NAME} && \
    ./configure \
        --disable-dependency-tracking \
        --with-pthreads \
        --with-username=${NAME} \
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
RUN chown -R ${NAME}:${NAME} /etc/unbound

LABEL org.opencontainers.image.version=${UNBOUND_VERSION} \
      org.opencontainers.image.title="vmikhailov/unbound" \
      org.opencontainers.image.description="a validating, recursive, and caching DNS resolver" \
      org.opencontainers.image.url="https://github.com/wjatscheslaw1986/unbound-podman-rootless" \
      org.opencontainers.image.vendor="Viacheslav Mikhailov" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.source="https://github.com/wjatscheslaw1986/unbound-podman-rootless"

EXPOSE 53/tcp
EXPOSE 53/udp
EXPOSE 853/tcp
EXPOSE 853/udp

HEALTHCHECK --interval=30s --timeout=30s --start-period=10s --retries=3 CMD drill @127.0.0.1 cloudflare.com || exit 1

CMD ["/usr/sbin/unbound", "-c", "/etc/unbound/unbound.conf"]
