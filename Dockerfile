FROM php:8.2-fpm-alpine as dev

RUN apk add --no-cache curl git build-base zlib-dev oniguruma-dev autoconf bash libpq-dev shadow linux-headers && \
    docker-php-ext-install pdo_pgsql && \
    groupmod -o -g 1000 www-data && \
    usermod -o -u 1000 -g www-data www-data

RUN pecl install xdebug-3.2.1 && docker-php-ext-enable xdebug
COPY php.dev.ini $PHP_INI_DIR/conf.d/php.ini

RUN mkdir /app && chown www-data:www-data /app
COPY --chown=www-data:www-data ./ /app
WORKDIR /app

USER www-data

RUN echo 'alias console="/app/bin/console"' >> ~/.bashrc
RUN echo 'alias phpunit="/app/bin/phpunit"' >> ~/.bashrc
# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
#RUN composer install --no-interaction

FROM nginx:stable as nginx
COPY default.conf /etc/nginx/conf.d/default.conf
