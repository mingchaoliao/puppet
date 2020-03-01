#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

bash -l -c "puppet apply --hiera_config=${DIR}/hiera.yaml --modulepath=${DIR}/site:${DIR}/modules ${DIR}/site.pp"