# oracle/instantclient.pp
# Manage installation of the Oracle instant client
#
# http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html
# http://download.oracle.com/otn/linux/instantclient/121020/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm
# http://download.oracle.com/otn/linux/instantclient/121020/oracle-instantclient12.1-sqlplus-12.1.0.2.0-1.x86_64.rpm
# http://download.oracle.com/otn/linux/instantclient/121020/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm
#

class profile::oracle::instantclient () {
  ensure_packages([
    'libaio1',
    'libaio-dev'
  ])

  file_line { 'export_oracle_home':
    path => '/etc/bash.bashrc',
    line => 'export ORACLE_HOME=/usr/lib/oracle/12.1/client64',
  }

  file_line { 'export_ld_library_path':
    path => '/etc/bash.bashrc',
    line => 'export LD_LIBRARY_PATH=/usr/lib/oracle/12.1/client64/lib',
  }

  exec { 'install_instantclient':
    command => 'install_instantclient_sqlplus.sh',
    path    => ['/usr/bin', '/bin', 'scripts']
  }
}
