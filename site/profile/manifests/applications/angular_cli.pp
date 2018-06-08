class profile::applications::angular_cli {
  package {'@angular/cli':
    ensure => '6.0.7',
    provider => npm,
    require => Class['::profile::applications::nodejs']
  }
}