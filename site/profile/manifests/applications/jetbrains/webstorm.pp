class profile::applications::jetbrains::webstorm {
  archive {'/tmp/puppet/tmp/webstorm.tar.gz':
    source => 'https://download-cf.jetbrains.com/webstorm/WebStorm-2018.1.4.tar.gz',
    extract => true,
    extract_path => '/tmp/puppet/tmp'
  }
  ->file {'/opt/webstorm':
    ensure => directory,
    source => '/tmp/puppet/tmp/WebStorm-181.5087.27',
    recurse => true
  }
  ->file {'/tmp/puppet/tmp/WebStorm-181.5087.27':
    ensure => absent,
    force => true
  }
  ->file {'/tmp/puppet/tmp/webstorm.tar.gz':
    ensure => absent
  }
}