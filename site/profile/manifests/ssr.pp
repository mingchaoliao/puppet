class profile::ssr(
  $ensure   = 'present',
  $source   = 'puppet:///files/ssr.deb'
) {
  file {'/tmp/puppet/ssr.deb':
    ensure => $ensure,
    source => $source
  }
  -> package {['libsodium18', 'libsodium-dev']:
    ensure => $ensure
  }
  ->package {'electron-ssr':
    provider => 'dpkg',
    ensure => $ensure,
    source => '/tmp/puppet/ssr.deb'
  }
}