FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    php-fpm \
    php-mysql \
    php-zip \
    php-redis \
    curl \
    vim \
    sendmail && \
    sed -i -e 's/listen =.*/listen = 0.0.0.0:9000/g' /etc/php/7.4/fpm/pool.d/www.conf && \
    mkdir -p /run/php
    
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/html
COPY ./tools/script.sh /script.sh
RUN chmod +x /script.sh

ENTRYPOINT ["bash", "/script.sh"]

