class profile::mysql::phpmyadmin (
  String $ensure        = 'present',
  String $source        = 'https://files.phpmyadmin.net/phpMyAdmin/4.8.4/phpMyAdmin-4.8.4-all-languages.zip',
  String $extractFolder = 'phpMyAdmin-4.8.4-all-languages'
) {
  if $ensure == 'present' {
    contain profile::mysql, profile::php, profile::apache::http, profile::apache::http::mod_php

    archive { '/tmp/puppet/phpmyadmin.zip':
      source       => $source,
      extract      => true,
      extract_path => '/opt',
      creates      => "/opt/$extractFolder/LICENSE"
    }
    -> file { '/var/www/localhost/phpmyadmin':
      ensure => link,
      target => "/opt/$extractFolder"
    }
  } elsif $ensure == 'absent' {
    file { "/opt/$extractFolder":
      ensure  => 'absent',
      recurse => true
    }

    file { '/var/www/localhost/phpmyadmin':
      ensure => 'absent'
    }
  } else {
    fail("Unsupported ensure value: $ensure")
  }
}
