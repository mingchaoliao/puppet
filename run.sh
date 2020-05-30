#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

SCRIPT='site.pp'

if [[ $1 ]]; then
  SCRIPT="-e \"$1\""
fi

sudo bash -l -c "cd $DIR && puppet apply --hiera_config=hiera.yaml --modulepath=site:modules $SCRIPT"
