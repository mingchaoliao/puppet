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
  ->file {'/etc/profile.d/set_tns_admin.sh':
    mode => '0755',
    content => 'export TNS_ADMIN=/etc/oracle/tns_admin'
  }
}