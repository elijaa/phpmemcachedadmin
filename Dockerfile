FROM php:7.0-apache
COPY config/php.ini /usr/local/etc/php/
COPY src/ /var/www/html/
RUN chown -R www-data /var/www/html/Config /var/www/html/Temp
