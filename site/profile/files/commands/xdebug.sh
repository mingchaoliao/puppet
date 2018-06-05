#!/bin/bash

case $1 in
    enable)
        sudo phpenmod xdebug
        sudo service apache2 restart
        ;;
    disable)
        sudo phpdismod xdebug
        sudo service apache2 restart
        ;;
    *)
        echo -e "Usage: \n 1. xdebug enable\n 2. xdebug disable"
        ;;
esac