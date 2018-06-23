#!/usr/bin/env bash

#== Variables ==
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

#== Provisioning Script ==

export DEBIAN_FRONTEND=noninteractive

database_install

# Restart services
service mysql restart
service postgresql restart
