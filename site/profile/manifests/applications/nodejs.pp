class profile::applications::nodejs (
  String $ensure          = 'present',
  String $repo_url_suffix = '10.x'
) {
  class { 'nodejs':
    repo_url_suffix => $repo_url_suffix
  }

  include 'nodejs'
}