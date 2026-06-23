FROM docker.io/library/debian:bookworm-slim 

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
	socat \
        curl \
        ca-certificates \
        git \
        bash \
        nodejs \
        npm && \
    rm -rf /var/lib/apt/lists/*

#
# Create user matching host UID 1000
#
RUN useradd \
        --uid 1000 \
        --create-home \
        --shell /bin/bash \
        hermes

RUN mkdir /workspace && chown -R 1000:1000 /workspace

USER hermes
WORKDIR /home/hermes

#
# Install Hermes CLI
#
RUN curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh \
    | bash -s -- \
        --skip-browser \
        --skip-setup \
        --no-skills

ENV PATH="/home/hermes/.local/bin:${PATH}"

USER root
COPY --chown=hermes:hermes entry.sh /usr/local/bin/entry.sh
RUN chmod 755 /usr/local/bin/entry.sh
USER hermes

WORKDIR /workspace

ENTRYPOINT ["/usr/local/bin/entry.sh"]
