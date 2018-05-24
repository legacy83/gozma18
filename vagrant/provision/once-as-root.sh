#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

echo "mysql-server mysql-server/root_password password root@secret" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password root@secret" | debconf-set-selections

# Update Package Lists
apt-get update
apt-get upgrade -y

# Install Common Packages
apt-get install -y \
  colordiff dos2unix gettext \
  graphviz imagemagick \
  git-core subversion \
  ngrep wget unzip zip \
  whois vim mcrypt \
  bash-completion zsh

# Install WebServer Packages
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

# Install Database Packages
apt-get install -y \
  mysql-server \
  postgresql postgresql-contrib \
  sqlite3 libsqlite3-dev

# Install Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Add Vagrant User To WWW-Data
usermod -a -G www-data vagrant
id vagrant
groups vagrant

# Install Node
apt-get install -y nodejs npm
/usr/bin/npm install -g gulp-cli
/usr/bin/npm install -g bower
/usr/bin/npm install -g yarn
/usr/bin/npm install -g grunt-cli

mysql --user="root" --password="root@secret" -e "CREATE USER 'gozma18'@'localhost' IDENTIFIED BY 'gozma18@secret';"
mysql --user="root" --password="root@secret" -e "GRANT ALL ON *.* TO 'gozma18'@'localhost' IDENTIFIED BY 'gozma18@secret' WITH GRANT OPTION;"
mysql --user="root" --password="root@secret" -e "GRANT ALL ON *.* TO 'gozma18'@'%' IDENTIFIED BY 'gozma18@secret' WITH GRANT OPTION;"
mysql --user="root" --password="root@secret" -e "FLUSH PRIVILEGES;"
mysql --user="root" --password="root@secret" -e "CREATE DATABASE gozma18 character set UTF8mb4 collate utf8mb4_bin;"
mysql --user="root" --password="root@secret" -e "CREATE DATABASE gozma18_test character set UTF8mb4 collate utf8mb4_bin;"
service mysql restart

sudo -u postgres psql -c "CREATE ROLE gozma18 LOGIN PASSWORD 'gozma18@secret' SUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;"
sudo -u postgres /usr/bin/createdb --echo --owner=gozma18 gozma18
sudo -u postgres /usr/bin/createdb --echo --owner=gozma18 gozma18_test
service postgresql restart

# Install wp-cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Clean Up
apt-get -y autoremove
apt-get -y clean
chown -R vagrant:vagrant /home/vagrant
