#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# Install Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Install Node
apt-get install -y nodejs npm
/usr/bin/npm install -g gulp-cli
/usr/bin/npm install -g bower
/usr/bin/npm install -g yarn
/usr/bin/npm install -g grunt-cli

# Install wp-cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Install oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git /home/vagrant/.oh-my-zsh
cp /home/vagrant/.oh-my-zsh/templates/zshrc.zsh-template /home/vagrant/.zshrc
chown -R vagrant:vagrant /home/vagrant/.oh-my-zsh
chown vagrant:vagrant /home/vagrant/.zshrc
