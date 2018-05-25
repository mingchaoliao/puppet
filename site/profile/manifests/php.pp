class profile::php () {
  class { '::php':
    ensure       => latest,
    package_prefix => 'php7.1_',
    manage_repos => true,
    fpm          => false,
    dev          => true,
    composer     => true,
    pear         => true,
    phpunit      => true,
    settings     => {
      'Date/date.timezone'      => 'America/New_York',
      'PHP/max_execution_time'  => '90',
      'PHP/max_input_time'      => '300',
      'PHP/memory_limit'        => '64M',
      'PHP/post_max_size'       => '32M',
      'PHP/upload_max_filesize' => '32M',
    },
    extensions   => {
      # pdo-dblib => {},
      # oci8      => {},
      # ldap      => {},
      # soap      => {},
      # xmlrpc    => {},
      # mcrypt    => {},
      # opcache   => {},
      # mbstring  => {},
      # pecl-zip  => {},
      # gd        => {},
      # pecl-yaml => {}
    }
  }

  contain '::php'


}