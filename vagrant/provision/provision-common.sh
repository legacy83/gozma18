#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# Update packages
apt-get update
apt-get upgrade -y

# Install packages
apt-get install -y \
  colordiff dos2unix gettext \
  graphviz imagemagick \
  git-core subversion \
  ngrep wget unzip zip \
  whois vim mcrypt \
  bash-completion zsh
