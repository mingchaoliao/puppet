class profile::nodejs(
  Enum['present', 'absent'] $ensure = 'present',
  String $repository = '14.x',
) {
  class {'::nodejs':
    repo_url_suffix => $repository,
    nodejs_package_ensure => $ensure,
  }

  contain '::nodejs'
}