class profile::oracle::virtualbox(
  $ensure = 'installed'
) {
  exec { 'accept-virtualbox-ext-license':
    command => "/bin/echo virtualbox-ext-pack virtualbox-ext-pack/license select true | /usr/bin/sudo /usr/bin/debconf-set-selections",
    unless  => "/usr/bin/debconf-show virtualbox-ext-pack | grep 'virtualbox-ext-pack/license: true'",
  }
  -> package { [
    'virtualbox',
    'virtualbox-ext-pack',
    'virtualbox-qt'
  ]:
    ensure => $ensure
  }
}