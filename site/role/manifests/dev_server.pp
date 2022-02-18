class role::dev_server {
  contain profile::thefuck
  contain profile::sift
  contain profile::nodejs
  contain profile::kubectl
  contain profile::angular_cli

  package {[
    'cloc',
    'maven',
    'rpm2cpio',
    'ldap-utils',
    'jq',
    'shc', # shell script compiler
  ]:}
}
