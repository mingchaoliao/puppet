#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root."
  exit
fi

apt-get update && apt-get install -y wget rclone

cd /tmp || exit 1

wget https://apt.puppet.com/puppet8-release-focal.deb \
  && dpkg -i puppet8-release-focal.deb \
  && apt-get update \
  && apt-get install -y puppet-agent \
  && echo "source /etc/profile.d/puppet-agent.sh" >> ~/.bashrc

apt-get install -y unzip git \
  && wget https://github.com/xorpaul/g10k/releases/download/v0.9.8/g10k-linux-amd64.zip \
  && unzip g10k-linux-amd64.zip \
  && mv g10k /usr/local/bin

cd - || exit 1
