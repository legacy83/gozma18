#!/usr/bin/env bash

echo "mysql-server mysql-server/root_password password root@secret" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password root@secret" | debconf-set-selections

# Is MySQL installed?
if [[ -f "/usr/bin/mysql" ]]; then
  is_mysql_installed=true
fi

# Is PostgreSQL installed?
if [[ -f "/usr/bin/psql" ]]; then
    is_postgresql_installed=true
fi

# Install packages
apt-get install -y \
  mysql-server \
  postgresql postgresql-contrib \
  sqlite3 libsqlite3-dev

# Enalbe MySQL remote access
if [[ ! -v is_mysql_installed ]]; then
  sed -i '/^bind-address/s/bind-address.*=.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
fi

# Create MySQL privileges
if [[ ! -v is_mysql_installed ]]; then
  mysql --user="root" --password="root@secret" -e "CREATE USER 'gozma18'@'localhost' IDENTIFIED BY 'gozma18@secret';"
  mysql --user="root" --password="root@secret" -e "GRANT ALL ON *.* TO 'gozma18'@'localhost' IDENTIFIED BY 'gozma18@secret' WITH GRANT OPTION;"
  mysql --user="root" --password="root@secret" -e "GRANT ALL ON *.* TO 'gozma18'@'%' IDENTIFIED BY 'gozma18@secret' WITH GRANT OPTION;"
  mysql --user="root" --password="root@secret" -e "FLUSH PRIVILEGES;"
fi

# Create MySQL databases
if [[ ! -v is_mysql_installed ]]; then
  mysql --user="root" --password="root@secret" -e "CREATE DATABASE gozma18 character set UTF8mb4 collate utf8mb4_bin;"
  mysql --user="root" --password="root@secret" -e "CREATE DATABASE gozma18_test character set UTF8mb4 collate utf8mb4_bin;"
fi

# Create PostgreSQL privileges
if [[ ! -v is_postgresql_installed ]]; then
  sudo -u postgres psql -c "CREATE ROLE gozma18 LOGIN PASSWORD 'gozma18@secret' SUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;"
fi

# Create PostgreSQL databases
if [[ ! -v is_mysql_installed ]]; then
  sudo -u postgres /usr/bin/createdb --echo --owner=gozma18 gozma18
  sudo -u postgres /usr/bin/createdb --echo --owner=gozma18 gozma18_test
fi

# Restart services
service mysql restart
service postgresql restart
