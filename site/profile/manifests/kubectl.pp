class profile::kubectl(
  $ensure = 'present'
) {
  package {'kubectl':
    ensure => $ensure,
    provider => snap
  }
  ->file_line {"kubectl alias":
    path => '/etc/bash.bashrc',
    ensure => $ensure,
    line => "alias k=kubectl"
  }
}
