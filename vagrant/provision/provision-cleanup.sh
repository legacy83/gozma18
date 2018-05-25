#!/usr/bin/env bash

apt-get -y autoremove
apt-get -y clean
chown -R vagrant:vagrant /home/vagrant
