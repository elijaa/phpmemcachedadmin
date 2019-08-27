FROM alpine:3

COPY start.sh /start.sh
RUN apk update \
 && apk --update add php7-apache2 php7-pecl-memcached php7-cli php7-json php7-curl php7-openssl php7-mbstring php7-sockets php7-xml php7-zlib git \
 && cd /tmp \
 && git clone https://github.com/elijaa/phpmemcachedadmin.git \
 && rm -rf /var/www/localhost/htdocs \
 && mv phpmemcachedadmin /var/www/localhost/htdocs \
 && cd /var/www/localhost/htdocs \
 && mv Config/Memcache.sample.php Config/Memcache.php \
 && rm -rf docker spam.php \
 && chown -R apache:apache /var/www/localhost/htdocs \
 && ln -sf /dev/stdout /var/log/apache2/access.log \
 && ln -sf /dev/stderr /var/log/apache2/error.log \
 && mkdir -p /run/apache2 \
 && chmod uog+rx /start.sh

EXPOSE 80
WORKDIR /var/www/localhost/htdocs

CMD ["/start.sh"]
