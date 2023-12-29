FROM alpine:3.18.4
MAINTAINER aunghtetnay.x@gmail.com 
ENV COMPOSER_ALLOW_SUPERUSER=1
# Setup document root
WORKDIR /var/www/html

# Install packages and remove default server definition
RUN apk add --no-cache \
  curl \
  nginx \
  php82 \
  php82-ctype \
  php82-curl \
  php82-dom \
  php82-fpm \
  php82-gd \
  php82-intl \
  php82-mbstring \
  #php82-mysqli \
  php82-opcache \
  php82-openssl \
  php82-phar \
  php82-session \
  php82-xml \
  php82-xmlreader \
  php82-pdo \
  php82-pdo_pgsql \
  php82-fileinfo \
  php82-tokenizer \
  php82-xmlwriter \
  php82-xmlreader \
  php82-pdo_mysql \
  php82-simplexml \
  php82-pcntl \
  php82-opcache \
  php82-sodium\
  php82-posix\
  php82-iconv\
  php82-exif\
  php82-zip\
  supervisor

# Create symlink so programs depending on `php` still function
RUN ln -s /usr/bin/php82 /usr/bin/php

# Configure nginx
COPY docker-config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY docker-config/fpm-pool.conf /etc/php82/php-fpm.d/www.conf
COPY docker-config/php.ini /etc/php82/conf.d/custom.ini

# Configure supervisord
COPY docker-config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

COPY docker-config/scheduler /etc/cron.d/scheduler

# COPY docker-config/docker-entrypoint.sh /var/www/html/docker-entrypoint.sh

# USER www-data
# RUN chmod 0644 /etc/cron.d/scheduler \
#     && crontab  /etc/cron.d/scheduler

# Install composer 
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer
# # Switch to use root user from here on
USER root

# set www-data group (82 is the standard uid/gid for www-data in Alpine)
RUN set -x ; \
	addgroup -g 82 -S www-data ; \
	adduser -u 81 -D -S -G www-data www-data && exit 0 ; exit 1

RUN apk add --no-cache \
    cronie \
    && chmod 0644 /etc/cron.d/scheduler \
    && crontab -u root /etc/cron.d/scheduler

# Add application
COPY .  /var/www/html/

# Install composer packages 
RUN composer install
#Permission
RUN chown -R www-data:www-data /var/www/html /run /var/lib/nginx /var/log/nginx /var/www/html/storage/


# Expose the port nginx is reachable on
EXPOSE 80

RUN ["chmod", "a+x", "/var/www/html/docker-config/docker-entrypoint.sh"]

ENTRYPOINT ["/bin/sh","/var/www/html/docker-config/docker-entrypoint.sh"]
# Let supervisord start nginx & php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
