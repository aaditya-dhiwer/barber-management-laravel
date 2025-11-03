FROM php:8.2-apache

# install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    supervisor \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

# enable apache mod_rewrite
RUN a2enmod rewrite

# copy composer binary from official composer image
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer



# set working directory
WORKDIR /var/www/html

# Set Apache document root to Laravel's public directory
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf


# copy app source (the mounted volume in dev will override this)
COPY . /var/www/html

# set permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache || true
RUN chmod -R 755 /var/www/html/storage || true

# expose port 80
EXPOSE 80

# default command
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
