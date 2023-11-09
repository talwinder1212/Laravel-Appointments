FROM  php:7.4-fpm
RUN apt-get -yqq update
RUN apt install zip  unzip
RUN docker-php-ext-install mysqli pdo pdo_mysql && docker-php-ext-enable pdo_mysql
RUN apt-get -yqq install exiftool
RUN docker-php-ext-configure exif
RUN docker-php-ext-install exif
RUN docker-php-ext-enable exif
RUN apt install  nginx -y
WORKDIR /var/www/html 
COPY  ./default.conf /etc/nginx/sites-enabled/default
COPY ./entrypoint.sh   /etc/entrypoint.sh
RUN  chmod  +x  /etc/entrypoint.sh
COPY ./codefiles ./
COPY --from=composer:2.2 /usr/bin/composer /usr/local/bin/composer
RUN composer install
RUN php artisan optimize

RUN php artisan route:clear

RUN php artisan route:cache

RUN php artisan config:clear

RUN php artisan config:cache

RUN php artisan view:clear

RUN php artisan view:cache
RUN chown -R www-data:www-data .
RUN chmod -R  777 /var/www/html/storage
RUN  php artisan key:generate
EXPOSE  80
ENTRYPOINT ["/etc/entrypoint.sh"]


