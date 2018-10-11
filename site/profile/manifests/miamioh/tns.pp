class profile::miamioh::tns {
  file {'/etc/oracle':
    ensure => directory
  }
  -> file {'/etc/oracle/tns_admin':
    ensure => directory
  }
  ->file {'/etc/oracle/tns_admin/ldap.ora':
    ensure => file,
    content => file('profile/miamioh/tns/ldap.ora')
  }
  ->file {'/etc/oracle/tns_admin/sqlnet.ora':
    ensure => file,
    content => file('profile/miamioh/tns/sqlnet.ora')
  }
  -> file_line { 'set TNS_ADMIN':
    path => '/etc/environment',
    line => 'TNS_ADMIN=/etc/oracle/tns_admin',
  }
}