class profile::applications::cisco::anyconnect (
  String $ensure        = 'present',
  String $source        = 'https://uci.service-now.com/sys_attachment.do?sys_id=3e869ef2db082b0054e7f236bf961900',
  String $extractFolder = 'anyconnect-linux64-4.6.02074'
) {
  file {['/opt/cisco', '/opt/cisco/install']:
    ensure => 'directory'
  }
  ->archive { '/tmp/puppet/cisco-anyconnect.tar.gz':
    source       => $source,
    extract      => true,
    extract_path => '/opt/cisco/install',
    creates      => "/opt/cisco/install/$extractFolder/vpn/license.txt"
  }
  if $ensure == 'present' {
    exec { 'install cisco anyconnect client':
      command => 'echo "yes" | ./vpn_install.sh',
      cwd     => "/opt/cisco/install/$extractFolder/vpn",
      path    => '/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin',
      require => Archive['/tmp/puppet/cisco-anyconnect.tar.gz'],
      creates => "/opt/cisco/anyconnect/bin/vpn"
    }
  } elsif $ensure == 'absent' {
    exec { 'uninstall cisco anyconnect client':
      command => 'echo "yes" | ./vpn_uninstall.sh',
      cwd     => "/opt/cisco/install/$extractFolder/vpn",
      path    => '/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin',
      require => Archive['/tmp/puppet/cisco-anyconnect.tar.gz']
    }
  } else {
    fail("Unsupported ensure value: $ensure")
  }

}