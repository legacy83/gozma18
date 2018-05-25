#!/usr/bin/env bash

# Install packages
apt-get install -y \
  apache2 php7.2 \
  libapache2-mod-php7.2 \
  php7.2-cli php7.2-dev \
  php7.2-pgsql php7.2-sqlite3 php7.2-gd \
  php7.2-curl php7.2-memcached \
  php7.2-imap php7.2-mysql php7.2-mbstring \
  php7.2-xml php7.2-zip php7.2-bcmath php7.2-soap \
  php7.2-intl php7.2-readline \
  php7.2-common php7.2-opcache \
  php7.2-xmlrpc php7.2-imagick \
  php-xdebug php-pear
