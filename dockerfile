FROM php:7.3.12-fpm-alpine

RUN apk add --no-cache openssl bash mysql-client

RUN docker-php-ext-install pdo pdo_mysql

WORKDIR /var/www

RUN rm -rf /var/www/html

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#RUN composer install && \
#            cp .env.example .env && \
#            php artisan key:generate && \
#            php artisan config:cache

COPY . /var/www

RUN echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories

RUN apk --no-cache add shadow && usermod -u 1000 www-data

RUN ln -s public html

EXPOSE 9000

ENTRYPOINT ["php-fpm"]