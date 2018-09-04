class profile::mysql::phpmyadmin {
  contain profile::mysql, profile::php, profile::apache::http, profile::apache::http::mod_php

  archive { '/tmp/puppet/tmp/phpmyadmin.zip':
    source       => 'https://files.phpmyadmin.net/phpMyAdmin/4.8.2/phpMyAdmin-4.8.2-all-languages.zip',
    extract      => true,
    extract_path => '/tmp/puppet/tmp',
    creates      => '/tmp/puppet/tmp/phpMyAdmin-4.8.2-all-languages'
  }
  -> file { '/var/www/localhost/phpmyadmin':
    ensure  => directory,
    source  => '/tmp/puppet/tmp/phpMyAdmin-4.8.2-all-languages',
    recurse => true
  }
}