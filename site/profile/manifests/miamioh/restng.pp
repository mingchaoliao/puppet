class profile::miamioh::restng {
  contain profile::apache::http, profile::apache::http::mod_php, profile::php

  apache::vhost { 'restng nonssl':
    ip              => '127.0.0.1',
    servername      => 'restng',
    port            => '80',
    docroot         => '/var/www/restng',
    docroot_owner   => 'www-data',
    docroot_group   => 'www-data',
    docroot_mode    => '0666',
    redirect_status => 'permanent',
    redirect_dest   => 'https://restng'
  }

  apache::vhost { 'restng ssl':
    ip            => '127.0.0.1',
    servername    => 'restng',
    port          => '443',
    docroot       => '/var/www/restng',
    docroot_owner => 'www-data',
    docroot_group => 'www-data',
    ssl           => true,
    ssl_cert      => '/opt/ssl/self_signed.crt',
    ssl_key       => '/opt/ssl/self_signed.key',
  }
}