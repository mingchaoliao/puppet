class profile::php::oci8 {
  file {'/tmp/pecl_oci8_answer.txt':
    ensure => file,
    content => 'instantclient,/usr/lib/oracle/12.1/client64/lib',
    require => [File['/usr/lib/oracle/12.1/client64/lib']]
  }
  ->exec { 'pecl_install_oci8':
    command => 'pecl install oci8 < /tmp/pecl_oci8_answer.txt',
    path => ['/usr/bin', '/bin'],
    onlyif => '/usr/bin/test ! -f /usr/lib/php/20160303/oci8.so'
  }
  ->file_line { 'cli_php_ini':
    path => '/etc/php/7.1/cli/php.ini',
    line => 'extension=oci8.so'
  }
  ->file_line { 'apache2_php_ini':
    path => '/etc/php/7.1/apache2/php.ini',
    line => 'extension=oci8.so'
  }
  ->exec {'/etc/init.d/apache2 restart':

  }
}