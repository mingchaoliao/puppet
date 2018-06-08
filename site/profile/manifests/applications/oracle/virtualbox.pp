class profile::applications::oracle::virtualbox {
  package { [
    'virtualbox',
    'virtualbox-ext-pack',
    'virtualbox-qt'
  ]:
    ensure => 'installed'
  }
}