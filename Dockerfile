FROM debian:11-slim
ENV DEBIAN_FRONTEND noninteractive
ENV TZ UTC
RUN apt-get update \
    && apt-get upgrade --yes \
    && apt-get install --no-install-suggests --no-install-recommends --yes \
    python3-venv \
    gcc \
    libpython3-dev \
    g++ \
    wget \
    curl \
    xz-utils \
    gzip \
    git \
    make \
    unzip \
    zip \
    apt-transport-https \
    ca-certificates \
    gnupg \
    && curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | apt-key add - \
    && echo "deb https://packages.doppler.com/public/cli/deb/debian any-version main" | tee /etc/apt/sources.list.d/doppler-cli.list \
    && python3 -m venv /venv \
    && /venv/bin/pip install --no-cache-dir --upgrade pip setuptools wheel poetry==1.1.11 \
    && apt-get clean \
    && apt-get autoremove --purge \
    && rm -rf /var/lib/apt/lists/* /root/* /tmp/* /var/cache/apt/archives/*.deb

