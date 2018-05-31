#!/bin/bash

sudo apt-get -y install software-properties-common
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update
sudo apt-get -y install rvm
getent passwd | while IFS=: read -r name password uid gid gecos home shell; do
  sudo usermod -aG rvm "${name}"
done
echo "source /etc/profile.d/rvm.sh" | sudo tee -a /etc/bash.bashrc
gem install bundler
