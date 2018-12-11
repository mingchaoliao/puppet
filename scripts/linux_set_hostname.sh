#!/bin/bash

echo "Enter hostname: "
read hostname
if ! grep -Eq "127\.0\.0\.1\s+${hostname}" /etc/hosts && echo $?;
    then
        echo "127.0.0.1 ${hostname}" | sudo tee -a /etc/hosts
fi
sudo hostname ${hostname}
