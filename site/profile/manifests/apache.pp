class profile::apache () {
  class { 'apache':
    default_vhost       => false,
    mpm_module          => 'prefork',
    default_mods        => true,
    default_confd_files => true
  }

  contain '::apache', '::apache::mod::prefork', '::apache::mod::headers', '::apache::mod::ssl'

  apache::vhost { 'localhost nonssl':
    ip            => '127.0.0.1',
    servername    => 'localhost',
    port          => '80',
    docroot       => '/var/www/localhost',
    docroot_owner => 'www-data',
    docroot_group => 'www-data',
    # redirect_status => 'permanent',
    # redirect_dest   => 'https://localhost/'
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
