#!/usr/bin/env bash

#== Variables ==
#== Functionality ==
#== Provisioning Script ==

apt-get -y autoremove
apt-get -y clean
chown -R vagrant:vagrant /home/vagrant
