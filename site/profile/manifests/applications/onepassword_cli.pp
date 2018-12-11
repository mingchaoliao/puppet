class profile::applications::onepassword_cli (
  String $ensure = 'present',
  String $source = 'https://cache.agilebits.com/dist/1P/op/pkg/v0.5.4/op_linux_amd64_v0.5.4.zip'
) {
  file { '/opt/1password':
    ensure => $ensure ? {
      absent  => 'absent',
      default => 'directory'
    }
  }
  -> archive { '/tmp/puppet/1password.zip':
    ensure       => $ensure,
    source       => $source,
    extract      => true,
    extract_path => '/opt/1password',
    creates      => '/opt/1password/op'
  }
  -> file { '/opt/1password/op':
    ensure => $ensure ? {
      absent  => 'absent',
      default => 'file'
    },
    mode   => '0755'
  }
  -> file { '/usr/bin/op':
    ensure => $ensure ? {
      absent  => 'absent',
      default => 'link'
    },
    target => '/opt/1password/op'
  }
}