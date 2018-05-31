#!/usr/bin/env bash

#== Variables ==

ls /usr/bin/mysql && IS_MYSQL_INSTALLED=$?
ls /usr/bin/psql && IS_POSTGRESQL_INSTALLED=$?

#== Functionality ==

database_install() {
  local ROOT_PASS='root@secret'

  echo "mysql-server mysql-server/root_password password ${ROOT_PASS}" | debconf-set-selections
  echo "mysql-server mysql-server/root_password_again password ${ROOT_PASS}" | debconf-set-selections

  apt-get install -y \
    mysql-server \
    postgresql postgresql-contrib \
    sqlite3 libsqlite3-dev
}

database_mysql_setup() {
  local ROOT_PASS='root@secret'

  local USER_NAME='gozma18'
  local USER_PASS='gozma18@secret'

  local DATABASE='gozma18'
  local DATABASE_TEST='gozma18_test'

  # add mysql|root privileges
  mysql --user="root" --password="${ROOT_PASS}" -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '${ROOT_PASS}' WITH GRANT OPTION;"

  # add mysql|user privileges
  mysql --user="root" --password="${ROOT_PASS}" -e "CREATE USER '${USER_NAME}'@'localhost' IDENTIFIED BY '${USER_PASS}';"
  mysql --user="root" --password="${ROOT_PASS}" -e "GRANT ALL ON *.* TO '${USER_NAME}'@'localhost' IDENTIFIED BY '${USER_PASS}' WITH GRANT OPTION;"
  mysql --user="root" --password="${ROOT_PASS}" -e "GRANT ALL ON *.* TO '${USER_NAME}'@'%' IDENTIFIED BY '${USER_PASS}' WITH GRANT OPTION;"
  mysql --user="root" --password="${ROOT_PASS}" -e "FLUSH PRIVILEGES;"

  # create mysql databases
  mysql --user="root" --password="${ROOT_PASS}" -e "CREATE DATABASE ${DATABASE} character set UTF8mb4 collate utf8mb4_bin;"
  mysql --user="root" --password="${ROOT_PASS}" -e "CREATE DATABASE ${DATABASE_TEST} character set UTF8mb4 collate utf8mb4_bin;"
}

database_mysql_remote() {
  sed -i '/^bind-address/s/bind-address.*=.*/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
}

database_postgresql_setup() {
  local USER_NAME='gozma18'
  local USER_PASS='gozma18@secret'

  local DATABASE='gozma18'
  local DATABASE_TEST='gozma18_test'

  # add postgres|user privileges
  sudo -u postgres psql -c "CREATE ROLE ${USER_NAME} LOGIN PASSWORD '${USER_PASS}' SUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;"

  # create postgres databases
  sudo -u postgres /usr/bin/createdb --echo --owner=$USER_NAME $DATABASE
  sudo -u postgres /usr/bin/createdb --echo --owner=$USER_NAME $DATABASE_TEST
}

database_postgresql_remote() {
  sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/10/main/postgresql.conf
  echo "host    all             all             192.168.27.1/32         md5" | tee -a /etc/postgresql/10/main/pg_hba.conf
}

#== Provisioning Script ==

export DEBIAN_FRONTEND=noninteractive

if [ ! $IS_MYSQL_INSTALLED ];
then
  database_install
  database_mysql_setup
  database_mysql_remote
fi

if [ ! $IS_POSTGRESQL_INSTALLED ];
then
  database_install
  database_postgresql_setup
  database_postgresql_remote
fi

# Restart services
service mysql restart
service postgresql restart
