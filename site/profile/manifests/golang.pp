class profile::golang(
  $ensure = '1.12.8'
) {
  class { 'golang':
    version   => $ensure,
    workspace => '/usr/local/src/go',
  }

  include golang
}