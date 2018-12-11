class profile::php::xdebug_manager (
  $ensure = 'file'
) {
  file { '/usr/local/bin/xdebug':
    ensure  => $ensure ,
    content => file('profile/commands/xdebug.sh'),
    owner   => 'root',
    group   => 'root',
    mode    => '4755',
    require => Class['::php']
  }
}