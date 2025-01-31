FROM php:7.4-fpm
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN docker-php-ext-install pdo pdo_mysql sockets
RUN apt-get -yqq update
RUN apt-get -yqq install exiftool
RUN apt install libzip-dev -y
RUN docker-php-ext-configure exif
RUN docker-php-ext-install exif
RUN docker-php-ext-enable exif
RUN docker-php-ext-install  zip

#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app
COPY . .
RUN composer install
RUN  php artisan  key:generate

EXPOSE 9000
CMD ["php-fpm"]
