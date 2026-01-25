FROM ubuntu:16.04
LABEL maintainer="Pedro Lobo <https://github.com/pslobo>"
LABEL Name="Dockerized xmr-node-proxy"
LABEL Version="1.4"

RUN export BUILD_DEPS="cmake \
                       pkg-config \
                       git \
                       build-essential \
                       curl" \

    && apt-get update && apt-get upgrade -qqy  \
    && apt-get install --no-install-recommends -qqy \
        ${BUILD_DEPS} python-virtualenv \
        python3-virtualenv ntp screen \
        libboost-all-dev libevent-dev \
        libunbound-dev libminiupnpc-dev \
        libunwind8-dev liblzma-dev libldns-dev \
        libexpat1-dev libgtest-dev libzmq3-dev \

    && curl -o- https://deb.nodesource.com/setup_6.x| bash \
    && apt-get install nodejs \
    && apt-get --auto-remove purge -qqy ${BUILD_DEPS} \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

RUN npm install

EXPOSE 5000

ENTRYPOINT ["node","proxy.js"]
