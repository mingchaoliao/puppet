class profile::apache::http (
  $vhosts = lookup('profile::apache::http::vhosts', Hash, 'deep', {}),
  $hosts  = lookup('profile::apache::http::hosts', Hash, 'deep', {})
) {
  class { 'apache':
    apache_version      => '2.4',
    default_vhost       => false,
    mpm_module          => 'prefork',
    default_mods        => true,
    default_confd_files => true
  }

  contain apache,
  apache::mod::prefork,
  apache::mod::headers,
  apache::mod::ssl,
  apache::mod::proxy,
  apache::mod::proxy_http,
  apache::mod::rewrite

  file { '/var/www':
    mode => '0666'
  }

  apache::vhost { 'localhost_nonssl':
    servername      => 'localhost',
    port            => '80',
    docroot         => '/var/www/localhost',
    docroot_owner   => 'www-data',
    docroot_group   => 'www-data',
    docroot_mode    => '0666',
    override        => 'All',
    redirect_status => 'permanent',
    rewrite_rule    => '(.*) https://localhost [R,L]',
    redirect_dest   => 'https://localhost'
  }

  class { 'profile::apache::http::self_signed_crt': }
  -> apache::vhost { 'localhost_ssl':
    servername    => 'localhost',
    port          => '443',
    override      => 'All',
    docroot       => '/var/www/localhost',
    docroot_owner => 'www-data',
    docroot_group => 'www-data',
    ssl           => true,
    ssl_cert      => '/opt/ssl/self_signed.crt',
    ssl_key       => '/opt/ssl/self_signed.key',
    rewrite_rule  => '(.*) https://localhost [R,L]'
  }

  create_resources('host', $hosts)
  create_resources('apache::vhost', $vhosts)

  file { '/var/log/apache2':
    ensure => directory,
    owner  => 'www-data',
    group  => 'www-data'
  }
}
