class profile::commands {
  file { '/opt/commands':
    ensure => directory,
    owner => 'root',
    group => 'root'
  }

  file { '/etc/profile.d/personal_commands.sh':
    mode    => '644',
    content => 'export PATH=$PATH:/opt/commands',
    require => File['/opt/commands']
  }

  file {'/opt/commands/xdebug':
    ensure => file,
    content => file('profile/commands/xdebug.sh'),
    owner => 'root',
    group => 'root',
    mode => '4755',
    require => File['/etc/profile.d/personal_commands.sh']
  }
}