#!/usr/bin/env bash

#== Variables ==
#== Functionality ==

common_update() {
  apt-get update
  apt-get upgrade -y
}

common_install() {
  apt-get install -y \
    colordiff dos2unix gettext \
    graphviz imagemagick \
    git-core subversion \
    ngrep wget unzip zip \
    whois vim mcrypt \
    bash-completion zsh \
    htop curl vim
}

#== Provisioning Script ==

export DEBIAN_FRONTEND=noninteractive

common_update
common_install
