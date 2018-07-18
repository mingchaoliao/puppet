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

  apache::vhost { 'charlesliao.com nonssl':
    ip            => '127.0.0.1',
    servername    => 'charlesliao.com',
    port          => '80',
    docroot       => '/var/www/charlesliao',
    docroot_owner => 'www-data',
    docroot_group => 'www-data',
    docroot_mode  => '0666',
    redirect_status => 'permanent',
    redirect_dest   => 'https://charlesliao.com'
  }

  apache::vhost { 'charlesliao.com ssl':
    ip            => '127.0.0.1',
    servername    => 'charlesliao.com',
    port          => '443',
    docroot       => '/var/www/charlesliao',
    docroot_owner => 'www-data',
    docroot_group => 'www-data',
    ssl_cert => '/etc/letsencrypt/live/charlesliao.com/fullchain.pem',
    ssl_key  => '/etc/letsencrypt/live/charlesliao.com/privkey.pem',
    ssl      => true,
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
