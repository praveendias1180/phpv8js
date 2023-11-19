FROM stesie/libv8-10.5 AS builder
MAINTAINER Stefan Siegl <stesie@brokenpipe.de>

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    php-dev git ca-certificates g++ make

RUN git clone --branch php7 https://github.com/phpv8/v8js.git /usr/local/src/v8js
WORKDIR /usr/local/src/v8js

RUN phpize
RUN ./configure --with-v8js=/opt/libv8-10.5 LDFLAGS="-lstdc++" CPPFLAGS="-DV8_COMPRESS_POINTERS -DV8_ENABLE_SANDBOX"
RUN make all -j`nproc`

FROM php:7.4-apache

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    supervisor \
    libcurl4-openssl-dev \
    pkg-config \
    libssl-dev

COPY --from=builder "/usr/lib/x86_64-linux-gnu/libstdc++.so.*" /usr/lib/x86_64-linux-gnu/
COPY --from=builder /opt/libv8-10.5 /opt/libv8-10.5/

COPY --from=builder /usr/local/src/v8js/modules/v8js.so /usr/local/lib/php/extensions/no-debug-non-zts-20190902/

RUN docker-php-ext-enable v8js

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html