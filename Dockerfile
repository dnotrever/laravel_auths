FROM php:8.4-fpm

WORKDIR /var/www/

RUN adduser --disabled-password --gecos '' appuser && \
    chown -R appuser /var/www/

RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    nano \
    git \
    curl \
    zip \
    unzip \
    nodejs \
    npm

RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER appuser

COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer