class profile::php (
  $ensure     = 'present',
  $oci8       = false,
  $extensions = lookup('profile::php::extensions', Hash, 'deep', {}),
  $settings   = lookup('profile::php::settings', Hash, 'deep', {})
) {
  class { '::php':
    ensure       => $ensure,
    manage_repos => true,
    fpm          => false,
    dev          => true,
    composer     => true,
    pear         => true,
    phpunit      => true,
    settings     => $settings,
    extensions   => $extensions
  }

  if $oci8 {
    contain profile::oracle::instantclient
  }

  contain '::php'
}