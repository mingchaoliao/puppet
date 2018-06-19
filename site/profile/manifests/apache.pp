class profile::apache () {
  class { 'apache':
    apache_version => '2.4',
    default_vhost       => false,
    mpm_module          => 'prefork',
    default_mods        => true,
    default_confd_files => true
  }

  contain '::apache', '::apache::mod::prefork', '::apache::mod::headers', '::apache::mod::ssl'

  file { '/var/www':
      mode => '0666'
  }

  apache::vhost { 'localhost nonssl':
    ip            => '127.0.0.1',
    servername    => 'localhost',
    port          => '80',
    docroot       => '/var/www/localhost',
    docroot_owner => 'www-data',
    docroot_group => 'www-data',
    docroot_mode  => '0666',
    redirect_status => 'permanent',
    redirect_dest   => 'https://localhost'
  }

  class {'::profile::apache::localhost_crt': }
  ->apache::vhost { 'localhost ssl':
    ip            => '127.0.0.1',
    servername    => 'localhost',
    port          => '443',
    docroot       => '/var/www/localhost',
    docroot_owner => 'www-data',
    docroot_group => 'www-data',
    ssl      => true,
    ssl_cert => '/opt/ssl/localhost.crt',
    ssl_key  => '/opt/ssl/localhost.key',
  }

  # apache::vhost { 'localhost ssl':
  #   ip            => '127.0.0.1',
  #   servername    => 'localhost',
  #   port          => '443',
  #   ssl           => true,
  #   docroot       => '/var/www/localhost',
  #   docroot_owner => 'www-data',
  #   docroot_group => 'www-data',
  #   ssl_cert      => '/etc/ssl/fourth.example.com.cert',
  #   ssl_key       => '/etc/ssl/fourth.example.com.key',
  # }

}
