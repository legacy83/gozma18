#!/usr/bin/env bash

#== Variables ==
#== Functionality ==

webserver_install() {
  apt-get install -y \
    apache2 php7.2 \
    libapache2-mod-php7.2 \
    php7.2-cli php7.2-common php7.2-dev \
    php7.2-pgsql php7.2-sqlite3 php7.2-gd \
    php7.2-curl php7.2-memcached \
    php7.2-imap php7.2-mysql php7.2-mbstring \
    php7.2-xml php7.2-zip php7.2-bcmath php7.2-soap \
    php7.2-intl php7.2-readline php7.2-opcache \
    php7.2-xmlrpc php7.2-xsl php7.2-json \
    php7.2-bz2 php7.2-imagick \
    php-pear
}

webserver_setup() {
  local DOMAIN='gozma18.local'

  echo "<VirtualHost *:80>
    ServerName ${DOMAIN}
    DocumentRoot /var/www/html
    AllowEncodedSlashes On
    <Directory /var/www/html>
      Options +Indexes +FollowSymLinks
    	DirectoryIndex index.php index.html
    	Order allow,deny
    	Allow from all
    	AllowOverride All
    </Directory>
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined
  </VirtualHost>" > /etc/apache2/sites-available/000-default.conf

  sed -i "s/memory_limit = .*/memory_limit = 256M/" /etc/php/7.2/apache2/php.ini
  sed -i "s/post_max_size = .*/post_max_size = 64M/" /etc/php/7.2/apache2/php.ini
  sed -i "s/upload_max_filesize = .*/upload_max_filesize = 32M/" /etc/php/7.2/apache2/php.ini

  a2enmod expires
  a2enmod headers
  a2enmod include
  a2enmod rewrite
}

webserver_ownership() {
  sed -ri 's/^(export APACHE_RUN_USER=)(.*)$/\1vagrant/' /etc/apache2/envvars
  sed -ri 's/^(export APACHE_RUN_GROUP=)(.*)$/\1vagrant/' /etc/apache2/envvars

  chown -R vagrant:vagrant /var/lock/apache2
  chown -R vagrant:vagrant /var/log/apache2
  chown -R vagrant:vagrant /var/www
}

#== Provisioning Script ==

export DEBIAN_FRONTEND=noninteractive

webserver_install
webserver_setup
webserver_ownership

# Restart service
service apache2 restart
