#!/usr/bin/env bash

echo "mysql-server mysql-server/root_password password root@secret" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password root@secret" | debconf-set-selections

# Install packages
apt-get install -y \
  mysql-server \
  postgresql postgresql-contrib \
  sqlite3 libsqlite3-dev

# Create MySQL privileges
mysql --user="root" --password="root@secret" -e "CREATE USER 'gozma18'@'localhost' IDENTIFIED BY 'gozma18@secret';"
mysql --user="root" --password="root@secret" -e "GRANT ALL ON *.* TO 'gozma18'@'localhost' IDENTIFIED BY 'gozma18@secret' WITH GRANT OPTION;"
mysql --user="root" --password="root@secret" -e "GRANT ALL ON *.* TO 'gozma18'@'%' IDENTIFIED BY 'gozma18@secret' WITH GRANT OPTION;"
mysql --user="root" --password="root@secret" -e "FLUSH PRIVILEGES;"

# Create MySQL databases
mysql --user="root" --password="root@secret" -e "CREATE DATABASE gozma18 character set UTF8mb4 collate utf8mb4_bin;"
mysql --user="root" --password="root@secret" -e "CREATE DATABASE gozma18_test character set UTF8mb4 collate utf8mb4_bin;"

# Create PostgreSQL privileges
sudo -u postgres psql -c "CREATE ROLE gozma18 LOGIN PASSWORD 'gozma18@secret' SUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;"

# Create PostgreSQL databases
sudo -u postgres /usr/bin/createdb --echo --owner=gozma18 gozma18
sudo -u postgres /usr/bin/createdb --echo --owner=gozma18 gozma18_test

# Restart services
service mysql restart
service postgresql restart
