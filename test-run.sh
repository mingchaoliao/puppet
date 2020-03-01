#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

OPTIONS=$@
IS_IN_DOCKER=$(grep 'docker\|lxc' /proc/1/cgroup)
if [[ ${IS_IN_DOCKER} ]]; then
    OPTIONS='--skip-set-hostname'
fi

${DIR}/scripts/init.sh ${OPTIONS} && bash -l -c "puppet apply --hiera_config=${DIR}/hiera.yaml --modulepath=${DIR}/site:${DIR}/modules ${DIR}/site.pp"