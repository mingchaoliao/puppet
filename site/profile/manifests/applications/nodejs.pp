class profile::applications::nodejs {
  class { 'nodejs':
    repo_url_suffix => '10.x'
  }
}