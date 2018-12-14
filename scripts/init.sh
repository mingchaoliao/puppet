#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

if [[ -f /etc/os-release ]]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=${NAME}
    VER=${VERSION_ID}
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [[ -f /etc/lsb-release ]]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=${DISTRIB_ID}
    VER=${DISTRIB_RELEASE}
elif [[ -f /etc/debian_version ]]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [[ -f /etc/SuSe-release ]]; then
    # Older SuSE/etc.
    ...
elif [[ -f /etc/redhat-release ]]; then
    # Older Red Hat, CentOS, etc.
    ...
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

if [[ "$OS" = "Ubuntu" ]]; then
    ${DIR}/linux/ubuntu_setup.sh
else
    echo "Unsupported OS type: ${OS}"
fi

${DIR}/linux/set_hostname.sh $1

sudo -i gpg2 --keyserver hkp://keys.gnupg.net \
    --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB \
  && sudo apt -y install curl \
  && \curl -sSL https://get.rvm.io | sudo -i bash -s stable \
  && sudo usermod -aG rvm root \
  && sudo -i rvm install 2.5.1 \
  && sudo -i rvm --default use 2.5.1 \
  && sudo -i gem install bundler \
  && sudo -i bash -c "cd ${DIR}/.. && bundle install" \
  && sudo -i bash -c "cd ${DIR}/.. && librarian-puppet install --verbose"

sudo rm -rf /opt/puppet/files
sudo mkdir -p /opt/puppet
sudo ln -s "${DIR}/../tmp" /opt/puppet/files