class profile::applications::oracle::virtualbox(
  $ensure = 'installed'
) {
  package { [
    'virtualbox',
    'virtualbox-ext-pack',
    'virtualbox-qt'
  ]:
    ensure => $ensure
  }
}