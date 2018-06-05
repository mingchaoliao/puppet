# profile/oracle/client.pp
# Manage Oracle Client
#
# https://docs.oracle.com/database/121/LACLI/pre_install.htm#LACLI1283
#
# Using biemond/oradb module
# https://forge.puppet.com/biemond/oradb
#
# http://download.oracle.com/otn/linux/oracle12c/121020/linuxamd64_12102_client.zip
#

class profile::oracle::client (
  $version    = '12.1.0.2',
  $file       = 'linuxamd64_12102_client',
  $log_output = true,
) {

  include '::profile::oracle::common'

  file { '/bin/awk':
    ensure => link,
    target => '/usr/bin/awk'
  }

  swap_file::files { 'default':
    ensure => present,
  }

  ensure_resource('group', 'oinstall', { 'gid' => '54321' })
  Group['oinstall'] -> Oradb::Client["${version}_Linux-x86-64"]

  oradb::client { "${version}_Linux-x86-64":
    version                   => $version,
    file                      => "${file}.zip",
    oracle_base               => '/opt/oracle',
    oracle_home               => "${profile::oracle::common::oracle_home_base}/client",
    ora_inventory_dir         => $profile::oracle::common::ora_inventory_dir,
    db_port                   => 12000,
    user                      => $profile::oracle::common::user,
    group                     => $profile::oracle::common::group,
    download_dir              => $profile::oracle::common::download_dir,
    bash_profile              => true,
    remote_file               => false,
    puppet_download_mnt_point => 'tmp',
    log_output                => $log_output,
    require                   => Class['::profile::oracle::common'],
  }
}
