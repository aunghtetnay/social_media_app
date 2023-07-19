# Use the desired PHP base image with Alpine Linux
FROM php:8.1-fpm-alpine

# Arguments defined in docker-compose.yml
ARG user
ARG uid

# Install php extension
RUN apk update --update -q && apk add -q --no-cache \
	bash \
	vim \
	supervisor \
	git \
	tzdata \
	gettext \
	curl \
	zip \
	# php
	php \
    php-gd \
    php-bcmath \
    php-json \
    php-ctype \
    php-iconv \
    php-calendar \
    php-zip \
	php-curl \
	php-dom \
	php-fpm \
	php-gettext \
	php-json \
	php-pcntl \
	php-posix \
	php-mbstring \
	php-openssl \
	php-pdo \
    php-pdo_mysql \
    php-mysqlnd \
	php-phar \
	php-opcache \
	php-session \
	php-intl \
	php-xml \
	php-zlib

# RUN docker-php-ext-install pdo pdo_mysql

# Composer
ENV COMPOSER_ALLOW_SUPERUSER=1

COPY --from=composer:2.4.4 /usr/bin/composer /usr/bin/composer

# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer
# RUN composer install --prefer-dist --no-dev --no-scripts --no-progress --no-interaction

# RUN composer dump-autoload --optimize

# Create system user to run Composer and Artisan Commands
# RUN addgroup -g 82 www-data \
#     && addgroup -g 0 root \
#     && adduser -G www-data,root -u $uid -h /home/$user -D $user

# RUN mkdir -p /home/$user/.composer && \
#     chown -R $user:$user /home/$user
# Set working directory
RUN docker-php-ext-install pdo pdo_mysql

WORKDIR /var/www

USER $user
