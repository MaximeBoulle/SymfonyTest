FROM php:8.2-fpm



# Install system dependencies

RUN apt-get update \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y \
        nodejs \
        libmcrypt-dev \
        libzip-dev \
        libpng-dev \
        libjpeg-dev \
        libfreetype6-dev \
        libicu-dev \
        libwebp-dev \
        libxml2-dev \
        git \
        wget \
        curl \
        libonig-dev \
        default-mysql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
        --with-webp \
    && docker-php-ext-install \
        mbstring \
        mysqli \
        pdo_mysql \
        zip \
        bcmath \
        gd \
        intl \
        xml

# Install Composer

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer


WORKDIR /var/www

CMD ["php-fpm"]