class profile::applications::cisco::anyconnect {
  archive { '/tmp/puppet/tmp/anyconnect-linux64-4.6.02074.tar.gz':
    source       => 'https://uci.service-now.com/sys_attachment.do?sys_id=3e869ef2db082b0054e7f236bf961900',
    extract      => true,
    extract_path => '/tmp/puppet/tmp',
    creates      => '/tmp/puppet/tmp/anyconnect-linux64-4.6.02074'
  }
  -> exec { 'install cisco anyconnect client':
    command => 'echo "yes" | ./vpn_install.sh',
    cwd     => '/tmp/puppet/tmp/anyconnect-linux64-4.6.02074/vpn',
    path    => '/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin'
  }
}