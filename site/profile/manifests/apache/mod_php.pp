class profile::apache::mod_php (){

  contain '::profile::php'
  contain '::profile::php::oci8'

  class { '::apache::mod::php':
    package_ensure => latest,
    php_version    => '7.1',
  }
  contain '::apache::mod::php'

  Class['::profile::php']
  -> Class['::apache::mod::php']
  -> File[$::apache::confd_dir]
  -> Class['::profile::php::oci8']

  file { "/var/www/localhost/phpinfo.php":
    ensure  => file,
    content => '<?php phpinfo();',
  }
}