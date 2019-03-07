class profile::applications::angular_cli(
  String $ensure = '6.0.7'
) {
  package { '@angular/cli':
    ensure   => $ensure,
    provider => npm,
    require  => Class['::profile::applications::nodejs']
  }
}