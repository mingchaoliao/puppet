class profile::php () {
  class { '::php':
    ensure         => latest,
    package_prefix => 'php7.1-',
    manage_repos   => true,
    fpm            => false,
    dev            => true,
    composer       => true,
    pear           => true,
    phpunit        => true,
    settings       => {
      'Date/date.timezone'      => 'America/New_York',
      'PHP/max_execution_time'  => '90',
      'PHP/max_input_time'      => '300',
      'PHP/memory_limit'        => '64M',
      'PHP/post_max_size'       => '32M',
      'PHP/upload_max_filesize' => '32M',
    },
    extensions     => {
      pdo-dblib => {},
      ldap      => {},
      soap      => {},
      xmlrpc    => {},
      mcrypt    => {},
      opcache   => {},
      mbstring  => {},
      zip       => {},
      gd        => {},
      yaml      => {},
      mysql     => {}
    }
  }

  exec { 'pecl_install_oci8':
    command => 'pecl install oci8 < data/pecl_oci8_answer.txt',
    path => ['/usr/bin', '/bin'],
    require => Exec['install_instantclient']
  }

  file_line { 'cli_php_ini':
    path => '/etc/php/7.1/cli/php.ini',
    line => 'extension=oci8.so',
    require => Exec['pecl_install_oci8']
  }

  file_line { 'apache2_php_ini':
    path => '/etc/php/7.1/apache2/php.ini',
    line => 'extension=oci8.so',
    require => Exec['pecl_install_oci8']
  }

  contain '::php'


}