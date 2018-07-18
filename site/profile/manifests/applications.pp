class profile::applications (
  $packages = [
    'cloc'
  ]
) {
  package { $packages:
    ensure => 'installed'
  }

  # contain '::profile::applications::chrome'
  # contain '::profile::applications::slack'

  file {'/usr/bin/phploc':
    ensure => file,
    source => 'https://phar.phpunit.de/phploc.phar',
    mode => '0755'
  }

  # contain '::profile::applications::oracle::virtualbox'
  contain '::profile::applications::nodejs'
  contain '::profile::applications::angular_cli'
  contain '::profile::applications::onepassword_cli'
  # contain '::profile::applications::oracle::sqldeveloper'
  # contain '::profile::applications::jetbrains::phpstorm'
  # contain '::profile::applications::jetbrains::webstorm'
  # contain '::profile::applications::jetbrains::rubymine'
  # contain '::profile::applications::cisco::anyconnect'
}