class profile::angular_cli(
  String $ensure = '12.2.14'
) {
  package { '@angular/cli':
    ensure   => $ensure,
    provider => npm,
    require  => Class['::profile::nodejs']
  }
}