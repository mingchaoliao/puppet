#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root."
  exit
fi

if [ "$#" -lt 1 ]
  then echo "Please provide AWS S3 secret access key."
  exit
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

mkdir -p /opt/puppet
rclone --config "$DIR/rclone-puppet-files.conf" --s3-access-key-id=AKIA4LIZ2RWDUVTCCFHB --s3-secret-access-key "$1" sync aws_s3:puppet-mount-files /opt/puppet/files
