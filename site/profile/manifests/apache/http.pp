class profile::apache::http (
  $vhosts = {},
  $hosts  = {}
) {
  class { 'apache':
    apache_version      => '2.4',
    default_vhost       => false,
    mpm_module          => 'prefork',
    default_mods        => true,
    default_confd_files => true
  }

  contain
  '::apache',
  '::apache::mod::prefork',
  '::apache::mod::headers',
  '::apache::mod::ssl',
  '::apache::mod::proxy',
  '::apache::mod::proxy_http'
  '::apache::mod::rewrite'

  file { '/var/www':
    mode => '0666'
  }

  apache::vhost { 'localhost nonssl':
    servername      => 'localhost',
    port            => '80',
    docroot         => '/var/www/localhost',
    docroot_owner   => 'www-data',
    docroot_group   => 'www-data',
    docroot_mode    => '0666',
    override        => 'All',
    redirect_status => 'permanent',
    redirect_dest   => 'https://localhost/'
  }

  class { 'profile::apache::http::self_signed_crt': }
  -> apache::vhost { 'localhost ssl':
    servername    => 'localhost',
    port          => '443',
    override      => 'All',
    docroot       => '/var/www/localhost',
    docroot_owner => 'www-data',
    docroot_group => 'www-data',
    ssl           => true,
    ssl_cert      => '/opt/ssl/self_signed.crt',
    ssl_key       => '/opt/ssl/self_signed.key',
  }

  create_resources('host', $hosts)
  create_resources('apache::vhost', $vhosts)
}
