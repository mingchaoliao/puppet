#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
g10k -puppetfile -usemove -puppetfilelocation ${DIR}/Puppetfile
puppet apply --hiera_config=${DIR}/hiera.yaml --modulepath=${DIR}/site:${DIR}/modules ${DIR}/site.pp
