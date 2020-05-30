class profile::applications::vmware_workstation(
  $ensure = 'installed',
  $version = '15.5.5-16285975'
) {
  class {'vmware_workstation':
    ensure => $ensure,
    version => $version,
  }
  include 'vmware_workstation'
}