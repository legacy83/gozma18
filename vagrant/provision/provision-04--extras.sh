#!/usr/bin/env bash

#== Variables ==
#== Functionality ==

extras_nodejs_install() {
  if [ ! -f "/usr/bin/node" ]; then
    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
    apt-get install -y nodejs
    /usr/bin/npm install -g yarn
    /usr/bin/npm install -g bower
    /usr/bin/npm install -g grunt-cli
    /usr/bin/npm install -g gulp-cli
    /usr/bin/npm install -g webpack
  fi
}

extras_composer_install() {
  if [ ! -f "/usr/local/bin/composer" ]; then
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar /usr/local/bin/composer
  fi
}

extras_wpcli_install() {
  if [ ! -f "/usr/local/bin/wp" ]; then
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
  fi
}

extras_ohmyzsh_install() {
  if [ ! -d "/home/vagrant/.oh-my-zsh" ]; then
    git clone git://github.com/robbyrussell/oh-my-zsh.git /home/vagrant/.oh-my-zsh
    cp /home/vagrant/.oh-my-zsh/templates/zshrc.zsh-template /home/vagrant/.zshrc
    chown -R vagrant:vagrant /home/vagrant/.oh-my-zsh
    chown vagrant:vagrant /home/vagrant/.zshrc
  fi
}

#== Provisioning Script ==

export DEBIAN_FRONTEND=noninteractive

extras_nodejs_install
extras_composer_install
extras_wpcli_install
extras_ohmyzsh_install
