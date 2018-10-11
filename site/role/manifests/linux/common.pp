class role::linux::common (
  $packages = lookup('role::linux::common::packages', Hash, 'deep', {})
) {

  # install packages via package manager
  create_resources(package, $packages)

  # install command-line applications
  contain git
  contain profile::user
  contain profile::applications::nodejs
  contain profile::applications::angular_cli
  contain profile::applications::onepassword_cli
  contain profile::java
  contain profile::mysql
  contain profile::mysql::phpmyadmin
  contain profile::php
  contain profile::apache::http
  contain profile::apache::http::mod_php
  contain profile::oracle::instantclient
  contain profile::system::ssh
  contain profile::system::sysctl
  contain profile::sift
}
