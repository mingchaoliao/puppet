class profile::thefuck(
  $ensure = 'present'
) {
  package {['python3-dev', 'python3-pip', 'python3-setuptools']:
    ensure => $ensure
  }
  ->package {'thefuck':
    ensure => $ensure,
    provider => pip3
  }
  ->file_line {"thefuck alias":
    path => '/etc/bash.bashrc',
    ensure => $ensure,
    line => "eval $(thefuck --alias)"
  }
}
