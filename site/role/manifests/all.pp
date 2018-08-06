class role::all (
  $packages = [
    'cloc'
  ]
) {

  # install packages via package manager
  package { $packages:
    ensure => 'installed'
  }

  # install command-line applications
  contain git
  contain profile::applications::nodejs
  contain profile::applications::angular_cli
  contain profile::applications::onepassword_cli
  contain profile::applications::cisco::anyconnect
  contain profile::commands
  contain profile::java
  contain profile::mysql
  contain profile::mysql::phpmyadmin
  contain profile::php
  contain profile::apache::http
  contain profile::apache::http::mod_php
  contain profile::oracle::instantclient
  contain profile::php::oci8
  contain profile::system::ssh
}