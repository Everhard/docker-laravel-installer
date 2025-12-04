# Base image with PHP 8.4 and Composer
FROM laravelsail/php84-composer

LABEL maintainer="Andrew Dorokhov <andrew@dorokhov.dev>"
LABEL description="Laravel Installer image based on the official Laravel Sail Docker image."

# Define Laravel installer version
ARG INSTALLER_VERSION=v5.23.1

# Clone Laravel installer and install dependencies
RUN rm -rf /laravel-installer \
    && git clone --branch ${INSTALLER_VERSION} --depth 1 https://github.com/laravel/installer.git /laravel-installer \
    && cd /laravel-installer \
    && composer install --no-dev --no-interaction --prefer-dist --optimize-autoloader

# Set Composer's cache directory to avoid permission issues in Docker
ENV COMPOSER_CACHE_DIR=/tmp/composer-cache

# Set working directory where new Laravel projects will be created
WORKDIR /app

# Set entrypoint to Laravel installer
ENTRYPOINT ["/usr/bin/laravel"]
