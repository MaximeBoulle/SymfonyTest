# Utilisation d'une image PHP officielle
FROM php:8.2-fpm

# Installation des dépendances nécessaires
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo pdo_mysql

# Installation de Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER=1

# Définir le répertoire de travail
WORKDIR /var/www

# Copie du code dans le container
COPY . .

# Installation des dépendances
RUN composer install --no-dev --optimize-autoloader

# Exposer le port 9000 pour le serveur FPM
EXPOSE 9000
CMD ["php-fpm"]
