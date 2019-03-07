#!/bin/bash

case $1 in
    enable|on)
        sudo phpenmod xdebug
        ;;
    disable|off)
        sudo phpdismod xdebug
        ;;
    *)
        echo -e "Usage: \n 1. xdebug {enable|on}\n 2. xdebug {disable|off}"
        ;;
esac