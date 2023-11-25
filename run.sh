#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root."
  exit
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
g10k -puppetfile -usemove -puppetfilelocation ${DIR}/Puppetfile
puppet apply --hiera_config=${DIR}/hiera.yaml --modulepath=${DIR}/site:${DIR}/modules ${DIR}/site.pp
