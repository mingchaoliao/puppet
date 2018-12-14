#!/bin/bash

hostname=$1

if [[ "$1" == "" ]]; then
  printf "Enter hostname: "
  read hostname
fi

if ! grep -Eq "127\.0\.0\.1\s+${hostname}" /etc/hosts && echo $?; then
    echo "127.0.0.1 ${hostname}" | sudo tee -a /etc/hosts
fi

sudo hostname ${hostname}
