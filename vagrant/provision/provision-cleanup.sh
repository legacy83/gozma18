#!/usr/bin/env bash

#== Variables ==
#== Functionality ==

cleanup() {
  apt-get -y autoremove
  apt-get -y clean
  chown -R vagrant:vagrant /home/vagrant
}

#== Provisioning Script ==

export DEBIAN_FRONTEND=noninteractive

cleanup
