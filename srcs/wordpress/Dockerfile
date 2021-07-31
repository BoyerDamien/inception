FROM alpine:3.14

# Update
RUN apk update && apk upgrade --no-cache

# Install package
RUN apk add openrc --no-cache \
    curl \ 
    php7-phar \
    php7 \
    mysql \
    mysql-client\
    php7-fpm \
    php7-mcrypt \
    php7-soap \
    php7-openssl \
    php7-gmp \
    php7-pdo_odbc \
    php7-json \
    php7-dom \
    php7-pdo \
    php7-zip \
    php7-mysqli \
    php7-sqlite3 \
    php7-apcu \
    php7-pdo_pgsql \
    php7-bcmath \
    php7-gd \
    php7-odbc \
    php7-pdo_mysql \
    php7-pdo_sqlite \
    php7-gettext \
    php7-xmlreader \
    php7-xmlrpc \
    php7-bz2 \
    php7-iconv \
    php7-pdo_dblib \
    php7-curl \
    php7-ctype \
    php-mbstring \  
    php-gettext \
    php7-cgi \
    php7-pdo \
    php7-session \
    php7-xml \
    php7-zlib

# Configure php-fpm
RUN adduser -D www

RUN sed -i "s|display_errors\s*=\s*Off|display_errors = On|i" /etc/php7/php.ini
RUN sed -i "s|display_startup_errors\s*=\s*Off|display_startup_errors = On|i" /etc/php7/php.ini
RUN sed -i "s|error_reporting\s*=\s*E_ALL & ~E_DEPRECATED & ~E_STRICT|error_reporting = E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR|i" /etc/php7/php.ini
RUN sed -i "s|;*memory_limit =.*|memory_limit = 512M|i" /etc/php7/php.ini
RUN sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = 50M|i" /etc/php7/php.ini
RUN sed -i "s|;*max_file_uploads =.*|max_file_uploads = 200|i" /etc/php7/php.ini
RUN sed -i "s|;*post_max_size =.*|post_max_size = 100M|i" /etc/php7/php.ini
RUN sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= 0 |i" /etc/php7/php.ini

RUN chown www:www -R /etc/php7 && \
    chown www:www -R /var/log/php7 && \
    chown www:www -R /var/log/php7


# Install wordpress
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
RUN wp cli update && mkdir -p /var/www

EXPOSE 9000

ADD ./entrypoint.sh entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]