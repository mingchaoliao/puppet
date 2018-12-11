#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

sudo apt -y install software-properties-common
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt update
sudo apt -y install augeas-tools libaugeas-dev rvm
sudo usermod -aG rvm $(whoami)
echo "source /etc/profile.d/rvm.sh" | sudo tee -a /etc/bash.bashrc

cd $DIR
./linux_set_hostname.sh

bash -lc "cd ${DIR}/.. && rvm install 2.5.1 && gem install bundler && bundler install && librarian-puppet install"

sudo rm -rf /opt/puppet/files
sudo mkdir -p /opt/puppet
sudo ln -s "${DIR}/../tmp" /opt/puppet/files