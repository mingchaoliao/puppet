class profile::ssr(
  $ensure   = 'present',
  $source   = 'https://github.com/shadowsocksrr/electron-ssr/releases/download/v0.2.7/electron-ssr-0.2.7.deb'
) {
  file {'/tmp/puppet/ssr.deb':
    ensure => $ensure,
    source => $source
  }
  -> package {[
    'libsodium23',
    'libsodium-dev',
    'gconf-service',
    'gconf-service-backend',
    'gconf2-common',
    'gconf2',
    'libappindicator1',
    'libdbusmenu-gtk4',
    'libgconf-2-4'
  ]:
    ensure => $ensure
  }
  ->package {'electron-ssr':
    provider => 'dpkg',
    ensure => $ensure,
    source => '/tmp/puppet/ssr.deb'
  }
}
