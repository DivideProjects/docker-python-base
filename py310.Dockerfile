FROM python:3.10-slim
ENV DEBIAN_FRONTEND noninteractive
ENV TZ UTC
COPY setup /tmp/setup
RUN apt-get update \
    && apt-get upgrade --yes \
    && apt-get install --no-install-suggests --no-install-recommends --yes \
    poppler-utils \
    apt-utils \
    build-essential \
    libpq-dev \
    python3-dev \
    python3-lxml \
    gcc \
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
    && pip install --no-cache-dir --upgrade pip setuptools wheel poetry \
    && apt-get clean \
    && apt-get autoremove --purge --yes \
    && /tmp/setup/ffmpeg-setup.sh \
    && rm -rf /var/lib/apt/lists/* /root/* /tmp/* /var/cache/apt/archives/*.deb setup
