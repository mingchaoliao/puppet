class profile::commands {
  file { '/opt/commands':
    ensure => directory,
    owner  => 'root',
    group  => 'root'
  }
  -> file { 'personal_commands':
    path    => '/etc/profile.d/personal_commands.sh',
    mode    => '644',
    content => 'export PATH=$PATH:/opt/commands',
    require => File['/opt/commands']
  }
}