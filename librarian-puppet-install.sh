#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

CMD="install"
VERBOSE=""

while getopts ":vu" opt; do
  case ${opt} in
    v ) # process option h
      VERBOSE='--verbose'
      ;;
    u ) # process option t
      CMD='update'
      ;;
    \? ) echo "Usage: ./librarian-puppet-install.sh [-v] [-u]"
      ;;
  esac
done

sudo bash -l -c "cd $DIR && librarian-puppet $CMD $VERBOSE"
