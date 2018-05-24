#!/usr/bin/env bash

#== Import script args ==

#== Bash helpers ==

#== Provision script ==

export DEBIAN_FRONTEND=noninteractive

echo "mysql-server mysql-server/root_password password root@secret" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password root@secret" | debconf-set-selections

# Update/Upgrade Package Lists
apt-get update
apt-get upgrade -y

# Install Common Packages
apt-get install -y \
  colordiff dos2unix gettext git-core graphviz imagemagick ngrep subversion unzip wget zip

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
  php7.2-xmlrpc \
  php-xdebug php-pear

# Install Database Packages
apt-get install -y \
  mysql-server \
  postgresql postgresql-contrib \
  sqlite3 libsqlite3-dev

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
