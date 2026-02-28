FROM php:8.2-cli

# Installer dépendances système
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    zip

# Installer extensions PHP
RUN docker-php-ext-install pdo pdo_mysql zip

# Installer Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app

# Copier fichiers
COPY . .

# Installer dépendances Laravel
RUN composer install --no-dev --optimize-autoloader

# Donner permissions
RUN chmod -R 777 storage bootstrap/cache

# Exposer port Railway
EXPOSE 8080

# Commande de démarrage
CMD php artisan serve --host=0.0.0.0 --port=8080