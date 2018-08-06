class profile::applications::cisco::anyconnect {
  archive { '/tmp/puppet/tmp/anyconnect.tar.gz':
    source       => 'https://uci.service-now.com/sys_attachment.do?sys_id=bf73bfaedb3307402393f1431d9619a5',
    extract      => true,
    extract_path => '/tmp/puppet/tmp',
    creates      => '/opt/cisco'
  }
  -> exec { 'install cisco anyconnect client':
    command => 'echo "yes" | ./vpn_install.sh',
    cwd     => '/tmp/puppet/tmp/anyconnect-linux64-4.5.03040/vpn',
    path    => '/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin'
  }
  -> file { '/tmp/puppet/tmp/anyconnect.tar.gz':
    ensure => absent
  }
  -> file { '/tmp/puppet/tmp/anyconnect-linux64-4.5.03040':
    ensure => absent,
    force  => true
  }
}