class profile::golang(
  $ensure = '1.12.8'
) {
  if $ensure == 'absent' {
    file {'/etc/profile.d/golang.sh':
      ensure => 'absent'
    }
    file {'/usr/local/go':
      ensure => 'absent',
      force => true,
      recurse => true,
      purge => true
    }
  } else {
    class { 'golang':
      version   => $ensure,
      workspace => '/usr/local/src/go',
    }

    include golang
  }
}