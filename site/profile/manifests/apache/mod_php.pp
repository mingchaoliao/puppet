class profile::apache::mod_php (){

  contain '::profile::php'

  class { '::apache::mod::php':
    package_ensure => latest,
    php_version    => '7.1.3',
  }
  contain '::apache::mod::php'

  Class['::profile::php']
  -> Class['::apache::mod::php']
  -> File[$::apache::confd_dir]

  file { "/var/www/localhost/phpinfo.php":
    ensure  => file,
    content => '<?php phpinfo();',
  }
}