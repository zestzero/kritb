FROM php:7.2-fpm

RUN apt-get update && apt-get install -y libmcrypt-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    mysql-client libmagickwand-dev git --no-install-recommends \
    && pecl install imagick \
    && pecl install mcrypt-1.0.2 \
    && docker-php-ext-install -j$(nproc) pdo_mysql iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-enable imagick mcrypt sodium pdo_mysql gd
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
