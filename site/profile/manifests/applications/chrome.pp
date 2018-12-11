class profile::applications::chrome (
  String $ensure = 'present'
) {
  class { '::google_chrome':
    ensure => $ensure
  }
  include 'google_chrome'
}