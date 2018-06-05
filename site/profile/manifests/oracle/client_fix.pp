class profile::oracle::client_fix(
  $oracle_home = "${profile::oracle::common::oracle_home_base}/client",
  $download_dir = $profile::oracle::common::download_dir,
  $version = '12.1.0.2',
  $exec_path = lookup('oradb::exec_path'),
  $user = $profile::oracle::common::user,
  $group = $profile::oracle::common::group,
  $log_output = true,
) {
  exec {'fix_libclntshcore':
    command => "cp -r /usr/lib/oracle/12.1/client64/lib/* /opt/oracle/product/12.1.0/client/lib/",
    path => ['/bin', '/usr/bin'],
    require => Class['::profile::oracle']
  }

  exec { "install oracle net":
    command   => "${oracle_home}/bin/netca /silent /responsefile ${download_dir}/netca_client_${version}.rsp",
    creates   => "${oracle_home}/network/admin/sqlnet.ora",
    path      => $exec_path,
    user      => $user,
    group     => $group,
    logoutput => $log_output,
  }
}