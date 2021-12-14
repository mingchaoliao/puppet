class profile::vmware_workstation(
  $ensure = 'installed',
  $version = '16.2.1-18811642'
) {
  class {'vmware_workstation':
    ensure => $ensure,
    version => $version,
  }
  include 'vmware_workstation'
}