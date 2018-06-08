class profile::applications::onepassword_cli {
  archive {'/tmp/puppet/tmp/1password_cli.zip':
    source => 'https://cache.agilebits.com/dist/1P/op/pkg/v0.4.1/op_linux_amd64_v0.4.1.zip',
    extract => true,
    extract_path => '/tmp/puppet/tmp'
  }
  ->file {'/usr/bin/op':
    source => '/tmp/puppet/tmp/op',
    ensure => file,
    mode => '0755',
    owner => root,
    group => root
  }
  ->file {'/tmp/puppet/tmp/1password_cli.zip':
    ensure => absent
  }
  ->file {'/tmp/puppet/tmp/op':
    ensure => absent
  }
  ->file {'/tmp/puppet/tmp/op.sig':
    ensure => absent
  }
}