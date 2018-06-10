class profile::applications::jetbrains::phpstorm {
  archive {'/tmp/puppet/tmp/phpstorm.tar.gz':
    source => 'https://download-cf.jetbrains.com/webide/PhpStorm-2018.1.5.tar.gz',
    extract => true,
    extract_path => '/tmp/puppet/tmp'
  }
  ->file {'/opt/phpstorm':
    ensure => directory,
    source => '/tmp/puppet/tmp/PhpStorm-181.5281.19',
    recurse => true
  }
  ->file {'/tmp/puppet/tmp/PhpStorm-181.5281.19':
    ensure => absent,
    force => true
  }
  ->file {'/tmp/puppet/tmp/phpstorm.tar.gz':
    ensure => absent
  }
}