FROM debian:11-slim
ENV DEBIAN_FRONTEND noninteractive
ENV PY_VERSION 3.10.4
ENV TZ UTC
RUN apt-get update \
    && apt-get upgrade --yes \
    && apt-get install --no-install-suggests --no-install-recommends --yes \
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
    zlib1g-dev \
    libssl-dev \
    && cd ~ \
    && wget https://www.python.org/ftp/python/${PY_VERSION}/Python-${PY_VERSION}.tgz \
    && tar -xvf Python-${PY_VERSION}.tgz \
    && cd Python-${PY_VERSION} \
    && ./configure --prefix=/usr/local --enable-optimizations \
    && make -j $(nproc) \
    && make install \
    && ln -s /usr/local/bin/python3 /usr/local/bin/python \
    && ln -s /usr/local/bin/pip3 /usr/local/bin/pip \
    && cd .. \
    && rm -rf Python-{$PY_VERSION} \
    && curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | apt-key add - \
    && echo "deb https://packages.doppler.com/public/cli/deb/debian any-version main" | tee /etc/apt/sources.list.d/doppler-cli.list \
    && python3 -m venv /venv \
    && /venv/bin/pip install --no-cache-dir --upgrade pip setuptools wheel poetry \
    && apt-get clean \
    && apt-get autoremove --purge --yes \
    && rm -rf /var/lib/apt/lists/* /root/* /tmp/* /var/cache/apt/archives/*.deb
