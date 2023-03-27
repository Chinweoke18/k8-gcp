FROM php:apache
#install all the dependencies
RUN apt-get update && apt-get install -y \
      libicu-dev \
      libpq-dev \
      libmcrypt-dev \
      git \
      zip \
      unzip
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli 

#install composer
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer
#create project folder
ENV APP_HOME /var/www/html
# RUN mkdir $APP_HOME
WORKDIR $APP_HOME
# change uid and gid of apache to docker user uid/gid
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

# COPY . /app 
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

# 3. mod_rewrite for URL rewrite and mod_headers for .htaccess extra headers like Access-Control-Allow-Origin-
RUN a2enmod rewrite headers

#copy source files and run composer
COPY .env.example $APP_HOME/.env
RUN ls -la $APP_HOME/
COPY . $APP_HOME
RUN composer self-update --2
RUN composer install --ignore-platform-reqs
#change ownership
RUN chown -R www-data:www-data $APP_HOME

CMD ["apache2-foreground"]
