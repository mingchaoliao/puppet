# oracle/instantclient.pp
# Manage installation of the Oracle instant client
#
# http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html
# http://download.oracle.com/otn/linux/instantclient/121020/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm
# http://download.oracle.com/otn/linux/instantclient/121020/oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64.rpm
# http://download.oracle.com/otn/linux/instantclient/121020/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm
#

class profile::oracle::instantclient (
  $instantclientBasicFile = "puppet:///files/instantclient-basic-linux.x64-12.2.0.1.0.zip",
  $instantClientSdkFile   = "puppet:///files/instantclient-sdk-linux.x64-12.2.0.1.0.zip",
) {
  ensure_packages([
    'libaio1',
    'libaio-dev',
    'unzip'
  ])

  file { [
    '/usr/lib/oracle',
    '/usr/lib/oracle/12.1',
    '/usr/lib/oracle/12.1/client64'
  ]:
    ensure => directory,
  }
  -> archive { '/tmp/puppet/tmp/instantclient_basic.zip':
    extract      => true,
    extract_path => '/tmp/puppet/tmp',
    source       => $instantclientBasicFile,
    creates      => '/tmp/puppet/tmp/instantclient_12_2/libclntshcore.so.12.1'
  }
  -> archive { '/tmp/puppet/tmp/instantclient_sdk.zip':
    extract      => true,
    extract_path => '/tmp/puppet/tmp',
    source       => $instantClientSdkFile,
    creates      => '/tmp/puppet/tmp/instantclient_12_2/sdk'
  }
  -> file { '/usr/lib/oracle/12.1/client64/lib':
    ensure  => directory,
    source  => '/tmp/puppet/tmp/instantclient_12_2',
    recurse => true
  }
  -> file { '/usr/lib/oracle/12.1/client64/lib/libclntsh.so':
    ensure => link,
    target => '/usr/lib/oracle/12.1/client64/lib/libclntsh.so.12.1'
  }
  -> file { '/usr/lib/oracle/12.1/client64/lib/libocci.so':
    ensure => link,
    target => '/usr/lib/oracle/12.1/client64/lib/libocci.so.12.1'
  }
  -> file { '/usr/lib/oracle/12.1/client64/lib/libclntshcore.so':
    ensure => link,
    target => '/usr/lib/oracle/12.1/client64/lib/libclntshcore.so.12.1'
  }
  -> file_line { 'set ORACLE_HOME':
    path => '/etc/environment',
    line => 'ORACLE_HOME=/usr/lib/oracle/12.1/client64',
  }
}
