class profile::shutter(
  Enum['absent','present'] $ensure = 'present',
) {
  ::apt::ppa {'ppa:linuxuprising/shutter':
    ensure => $ensure
  }
  -> package {'shutter':
    ensure => $ensure
  }
}