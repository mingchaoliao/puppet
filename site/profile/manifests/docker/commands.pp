class profile::docker::commands(
  $ensure = 'present',
  $cmds = lookup('profile::docker::commands::cmds', Hash, 'deep', {})
) {
  if $ensure == 'present' {
    file {'/opt/docker_cmds':
      ensure => 'directory'
    }

    file { '/etc/profile.d/prepend-path-docker-cmds.sh':
      mode    => '644',
      content => 'export PATH=/opt/docker_cmds:$PATH',
    }

    create_resources('profile::docker::command', $cmds)
  } else {
    file {'/opt/docker_cmds':
      ensure => 'absent',
      purge => true,
      recurse => true,
      force => true
    }

    file { '/etc/profile.d/append-path-docker-cmds.sh':
      ensure => absent
    }
  }
}