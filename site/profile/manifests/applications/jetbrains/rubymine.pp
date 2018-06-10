class profile::applications::jetbrains::rubymine {
  archive {'/tmp/puppet/tmp/rubymine.tar.gz':
    source => 'https://download-cf.jetbrains.com/ruby/RubyMine-2018.1.3.tar.gz',
    extract => true,
    extract_path => '/tmp/puppet/tmp'
  }
  ->file {'/opt/rubymine':
    ensure => directory,
    source => '/tmp/puppet/tmp/RubyMine-2018.1.3',
    recurse => true
  }
  ->file {'/tmp/puppet/tmp/RubyMine-2018.1.3':
    ensure => absent,
    force => true
  }
  ->file {'/tmp/puppet/tmp/rubymine.tar.gz':
    ensure => absent
  }
}