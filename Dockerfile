FROM debian:11-slim

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
    && python3 -m venv /venv \
    && /venv/bin/pip install --no-cache-dir --upgrade pip setuptools wheel poetry==1.1.11 \
    && apt-get clean \
    && apt-get autoremove --purge \
    && rm -rf /var/lib/apt/lists/* /root/* /tmp/* /var/cache/apt/archives/*.deb

