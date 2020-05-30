class profile::glances (
  $ensure = 'present'
) {
  package {['python-pip', 'build-essential', 'python-dev']:
    ensure => present
  }

  if $ensure == 'absent' {
    exec {'glances':
      command => '/usr/bin/pip uninstall -y glances[all]',
      onlyif => '/usr/bin/which glances',
      require => Package[['python-pip', 'build-essential', 'python-dev']]
    }
  } else {
    exec {'glances':
      command => '/usr/bin/pip install glances[all]',
      creates => '/usr/local/bin/glances',
      require => Package[['python-pip', 'build-essential', 'python-dev']]
    }
  }

  file {'/etc/glances':
    ensure => $ensure == 'absent' ? {true => 'absent', default => 'directory'},
    force => true,
    recurse => true
  }
  ->file {'/etc/glances/glances.conf':
    ensure => $ensure,
    content => file('profile/applications/glances/glances.conf')
  }

  systemd::unit_file { 'glances.service':
    ensure => $ensure,
    content => file('profile/applications/glances/glances-web.service'),
    require => [Exec['glances'], File['/etc/glances/glances.conf']]
  }
  ~> service {'glances':
    ensure => $ensure ? {absent => stopped, default => running},
  }
}