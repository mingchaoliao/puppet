#!/bin/bash

# the script must be run as root only
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# get absolute path of the directory which this file stays
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

#
# get OS information
#
if [[ -f /etc/os-release ]]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=${NAME}
    VER=${VERSION_ID}
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [[ -f /etc/lsb-release ]]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=${DISTRIB_ID}
    VER=${DISTRIB_RELEASE}
elif [[ -f /etc/debian_version ]]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [[ -f /etc/SuSe-release ]]; then
    # Older SuSE/etc.
    ...
elif [[ -f /etc/redhat-release ]]; then
    # Older Red Hat, CentOS, etc.
    ...
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

#
# Parse command line arguments and options
#
for i in "$@"
do
case $i in
    --hostname=*)
    SET_HOSTNAME="${i#*=}"
    shift
    ;;
    --skip-set-hostname)
    SKIP_HOST_NAME=true
    shift
    ;;
    *)
        echo "Unknown parameter ${i}"
        exit 1
    ;;
esac
done

# hostname provided from the command line argument is required
if [[ ! ${SKIP_HOST_NAME} && ! ${SET_HOSTNAME} ]]; then
    echo 'Missing options --hostname=<hostname>. Apply option --skip-set-hostname, if the hostname is already set.'
    exit 1;
fi

# check if the current OS is supported
if [[ "$OS" = "Ubuntu" ]]; then
    if [[ ! $(bash -l -c "command -v ruby") ]]; then
        ${DIR}/linux/ubuntu_setup.sh
    fi
else
    echo "Unsupported OS type: ${OS}"
    exit 1
fi

if [[ ! ${SKIP_HOST_NAME} ]]; then
    ${DIR}/linux/set_hostname.sh ${SET_HOSTNAME}
fi

if [[ ! $(bash -l -c "command -v ruby") ]]; then
    gpg2 --keyserver hkp://keys.gnupg.net \
        --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB \
      && curl -sSL https://get.rvm.io | bash -s stable \
      && usermod -aG rvm root \
      && bash -l -c "rvm install 2.5.1" \
      && bash -l -c "rvm --default use 2.5.1"
fi

if [[ ! $(bash -l -c "command -v librarian-puppet") ]]; then
    bash -l -c "gem install bundler && bundle install"
fi

if [[ ! $(bash -l -c "command -v puppet") ]]; then
    bash -l -c "librarian-puppet install"
fi

rm -rf /opt/puppet/files \
  && mkdir -p /opt/puppet "${DIR}/../tmp" \
  && ln -s "${DIR}/../tmp" /opt/puppet/files