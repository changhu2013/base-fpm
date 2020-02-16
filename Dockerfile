FROM php:7.2-fpm

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libz-dev libbz2-dev curl libcurl4-openssl-dev \
    libxml2-dev libldap2-dev libsodium-dev \
    libxslt1-dev

# fix for docker-php-ext-install pdo_dblib
# https://stackoverflow.com/questions/43617752/docker-php-and-freetds-cannot-find-freetds-in-know-installation-directories
RUN ln -s /usr/lib/x86_64-linux-gnu/libsybdb.so /usr/lib/

# php
RUN docker-php-ext-install opcache pdo pdo_mysql
RUN docker-php-ext-install bcmath bz2 calendar
RUN docker-php-ext-install curl dom fileinfo exif json
RUN docker-php-ext-install ldap mbstring mysqli sockets sodium
RUN docker-php-ext-install sysvmsg sysvsem sysvshm

# fix for docker-php-ext-install xmlreader
# https://github.com/docker-library/php/issues/373
RUN export CFLAGS="-I/usr/src/php" && docker-php-ext-install xmlreader xmlwriter xml xmlrpc xsl

EXPOSE 9000

CMD ["php-fpm"]
