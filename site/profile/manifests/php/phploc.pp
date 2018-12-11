class profile::php::phploc (
  $ensure = 'file',
  $source = 'https://phar.phpunit.de/phploc.phar'
) {
  file { '/usr/local/bin/phploc':
    ensure  => $ensure,
    source  => $source,
    mode    => '0755',
    require => Class['::php::cli']
  }
}