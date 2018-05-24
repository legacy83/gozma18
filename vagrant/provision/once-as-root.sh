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
