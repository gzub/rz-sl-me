FROM php:8.2-cli AS builder

# Container with PHP and Composer for building dependencies
RUN apt update && apt install -y unzip libzip-dev
RUN docker-php-ext-install zip
COPY --from=composer:lts /usr/bin/composer /usr/bin/composer
WORKDIR /var/www/vendor
WORKDIR /var/www
COPY composer.json composer.lock ./

RUN composer install \
    --ignore-platform-reqs \
    --no-interaction \
    --no-plugins \
    --no-scripts \
    --prefer-dist \
    --optimize-autoloader


FROM php:8.2-cli
# Main container
USER php
# Set the working directory in the container
WORKDIR /var/www

# Copy your application code into the container
COPY composer.json composer.lock artisan ./
COPY --from=builder /var/www/vendor ./vendor
COPY app ./app
COPY bootstrap ./bootstrap
COPY config ./config
COPY database ./database
COPY public ./public
COPY resources ./resources
COPY routes ./routes
COPY storage ./storage

# Set the default command to run the Application
CMD ["php", "artisan", "slack-me"]