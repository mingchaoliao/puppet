class profile::glances (
  $ensure = 'present'
) {
  package {'python-pip':
    ensure => present
  }

  package {'glances[all]':
    ensure => $ensure,
    provider => pip,
    require => Package['python-pip']
  }

  file {'/etc/glances':
    ensure => $ensure == 'absent' ? {true => 'absent', default => 'directory'}
  }
  ->file {'/etc/glances/glances.conf':
    ensure => $ensure,
    content => file('profile/applications/glances/glances.conf')
  }

  systemd::unit_file { 'glances.service':
    content => file('profile/applications/glances/glances-web.service'),
    require => [Package['glances[all]'], File['/etc/glances/glances.conf']]
  }
  ~> service {'glances':
    ensure => 'running',
  }
}