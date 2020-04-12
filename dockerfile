FROM php:7.3.6-fpm-alpine3.9

RUN apk add --no-cache openssl bash mysql-client nodejs npm
RUN docker-php-ext-install pdo pdo_mysql

WORKDIR /var/www

RUN rm -rf /var/www/html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

COPY . /var/www

RUN chmod a+rx k8s/entrypoint.sh

RUN chmod a+rx .env

RUN composer install \
    && php artisan cache:clear \ 
    && chmod -R 775 storage

RUN ln -s public html

EXPOSE 9000

ENTRYPOINT ["php-fpm"]