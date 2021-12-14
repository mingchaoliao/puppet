class profile::glances (
  $ensure = 'present'
) {
  if $ensure == 'absent' {
    exec {'glances':
      command => '/usr/bin/pip uninstall -y glances[all]',
      onlyif => '/usr/bin/which glances',
    }
  } else {
    exec {'glances':
      command => '/usr/bin/pip install glances[all]',
      creates => '/usr/local/bin/glances',
    }
  }

  file {'/etc/glances':
    ensure => $ensure == 'absent' ? {true => 'absent', default => 'directory'},
    force => true,
    recurse => true
  }
  ->file {'/etc/glances/glances.conf':
    ensure => $ensure,
    content => file('profile/glances/glances.conf')
  }

  systemd::unit_file { 'glances.service':
    ensure => $ensure,

    content => file('profile/glances/glances-web.service'),
    require => [Exec['glances'], File['/etc/glances/glances.conf']]
  }
  ~> service {'glances':
    ensure => $ensure ? {absent => stopped, default => running},
    enable => true,
  }
}