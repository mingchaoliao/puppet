#!/bin/bash

apt-get update \
  && apt-get -y install augeas-tools libaugeas-dev git gnupg2 curl lsb-release
