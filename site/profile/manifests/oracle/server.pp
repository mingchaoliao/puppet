# profile/dev/soldel/oracledb.pp
# Manage Oracle DB for local development
#
# Using biemond/oradb module
# https://forge.puppet.com/biemond/oradb
#

class profile::oracle::server (
  $version             = '12.1.0.2',
  $file                = 'linuxamd64_12102_database',
  $memory_percentage   = 40,
  $memory_total        = 800,
  $db_name             = 'DEVL',
  $db_port             = 12000,
  $db_user             = 'baninst1',
  $listener            = 'listener',
  $listener_host       = '0.0.0.0',
  $dbc_file            = undef,
  $dbc_name            = undef,
  $artifact_root       = 'tmp',
){

  include '::profile::oracle::common'

  $artifact_root_real = $artifact_root;

  $sys_password    = '1234'
  $system_password = $sys_password
  $db_password     = $sys_password

  $download_dir = $profile::oracle::common::download_dir
  $oracle_home  = "${profile::oracle::common::oracle_home_base}/dbhome_1"
  $template_dir = "${oracle_home}/assistants/dbca/templates"
  $oracle_user  = $profile::oracle::common::user

  $exec_path = '/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:'

  package {'ksh':
    ensure => 'installed'
  }

  file {'/bin/awk':
    ensure => 'link',
    target => '/usr/bin/awk'
  }

  file { ['/opt/oracle/oradata', '/opt/oracle/flash_recovery_area', "${download_dir}/${file}"]:
    ensure => directory,
    mode   => '0750',
    owner  => $profile::oracle::common::user,
    group  => $profile::oracle::common::group,
  }

  -> archive { "/tmp/${file}_1of2.zip":
    source       => "puppet:///files/${artifact_root_real}/${file}_1of2.zip",
    extract      => true,
    extract_path => "${download_dir}/${file}",
    creates      => "${download_dir}/${file}/database/welcome.html",
    cleanup      => true,
    user         => $profile::oracle::common::user,
    group        => $profile::oracle::common::group,
  }

  -> archive { "/tmp/${file}_2of2.zip":
    source       => "puppet:///files/${artifact_root_real}/${file}_2of2.zip",
    extract      => true,
    extract_path => "${download_dir}/${file}",
    creates      => "${download_dir}/${file}/database/install/.oui",
    cleanup      => true,
    user         => $profile::oracle::common::user,
    group        => $profile::oracle::common::group,
  }

  ######################################
  # These tasks are a hack to work around an issue with the Oracle installer.
  # For some reason, it is not copying the libjavavm12.a file to the
  # $ORACLE_HOME/lib directory during install so subsequent actions fail.
  # Unpacking the jar and copying the file to expected final location will
  # allow the installer and database creation to complete successfully.
  # This issue was not reproducable in all cases and this workaround should
  # be considered for removal.
  -> archive { "${download_dir}/filegroup1.jar":
    source       => "${download_dir}/${file}/database/stage/Components/oracle.javavm.server.core/12.1.0.2.0/1/DataFiles/filegroup1.jar",
    extract      => true,
    extract_path => $download_dir,
    creates      => "${download_dir}/javavm/jdk/jdk6/lib/libjavavm12.a",
    cleanup      => false,
  }

  # I've tried to replace this with a file resource. Unfortunately, doing so
  # creates a dependency cycle that I have been unable to resolve. The issue
  # is that this file must be placed in a path managed during the oradb::installdb
  # resource execution, and a file resource creates an implicit require on
  # the containing directory. The exec avoids the implicit require and allows
  # the file to placed in the expected directory.
  -> exec { 'cp libjavavm12.a':
    command => "mkdir -p ${oracle_home}/lib && cp ${download_dir}/javavm/jdk/jdk6/lib/libjavavm12.a ${oracle_home}/lib/",
    creates => "${oracle_home}/lib/libjavavm12.a",
    path    => $exec_path,
    user    => $profile::oracle::common::user,
    group   => $profile::oracle::common::group,
  }

  ######################################

  -> oradb::installdb{ "${version}_Linux-x86-64":
    version                   => $version,
    file                      => $file,
    database_type             => 'EE',
    oracle_base               => '/opt/oracle',
    oracle_home               => $oracle_home,
    group                     => $profile::oracle::common::group,
    group_install             => $profile::oracle::common::group,
    group_oper                => $profile::oracle::common::group,
    download_dir              => $download_dir,
    zip_extract               => false,
    puppet_download_mnt_point => $download_dir,
  }

  # -> archive { '/tmp/restngDbc.tar.gz':
  #   source       => "${artifact_root_real}/${dbc_file}",
  #   extract      => true,
  #   extract_path => $template_dir,
  #   creates      => "${template_dir}/${dbc_name}.dbc",
  #   cleanup      => false,
  #   user         => $profile::oracle::common::user,
  #   group        => $profile::oracle::common::group,
  # }

  -> oradb::database{ 'restng':
    oracle_base               => '/opt/oracle',
    oracle_home               => $oracle_home,
    version                   => '12.1',
    # template_seeded           => $dbc_name,
    download_dir              => $template_dir,
    db_name                   => $db_name,
    db_domain                 => 'miamioh.edu',
    db_port                   => $db_port,
    sys_password              => $sys_password,
    system_password           => $system_password,
    data_file_destination     => '/opt/oracle/oradata',
    recovery_area_destination => '/opt/oracle/flash_recovery_area',
    nationalcharacter_set     => 'AL16UTF16',
    sample_schema             => undef,
    memory_percentage         => $memory_percentage,
    memory_total              => $memory_total,
  }

  -> file_line { "Uncomment ${db_name} in oratab":
    path  => '/etc/oratab',
    match => "^${db_name}:[^:]+:N$",
    line  => "${db_name}:${oracle_home}:Y",
  }

  -> exec { 'enable RESTng user':
    command     => "sqlplus -s /nolog <<EOF
connect system/${system_password}
alter user ${db_user} identified by ${db_password} account unlock;
quit
EOF
    ",
    path        => "${oracle_home}/bin",
    environment => [
      "ORACLE_SID=${db_name}",
      "ORACLE_HOME=${oracle_home}",
      "LD_LIBRARY_PATH=${oracle_home}/lib",
    ],
    user        => $profile::oracle::common::user,
  }

  # The db_control and db_listener tasks do not provide a helpful
  # service control, which mean the DB and Listener won't start
  # after a reload. The oradb service provides very rudimentary
  # start, stop and status methods which will work for our local
  # database needs. This isn't suitable for other deployements.

  # db_control { 'db start':
  #   ensure                  => 'running',
  #   instance_name           => $db_name,
  #   oracle_product_home_dir => $oracle_home,
  #   os_user                 => $profile::oracle::common::user,
  # } ->

  -> file { "${oracle_home}/network/admin/${listener}.ora":
    ensure  => file,
    owner   => $profile::oracle::common::user,
    group   => $profile::oracle::common::group,
    mode    => '0640',
    content => template("${module_name}/oracle/listener.ora.erb"),
  }

  # db_listener { 'startlistener':
  #   ensure          => 'running',  # running|start|abort|stop
  #   oracle_base_dir => '/opt/oracle',
  #   oracle_home_dir => $oracle_home,
  #   os_user         => $profile::oracle::common::user,
  #   listener_name   => $listener,
  # }

  file { '/etc/init.d/oradb':
    ensure  => file,
    mode    => '0744',
    content => template("${module_name}/oracle/oradb.erb"),
  }

  service { 'oradb':
    ensure  => running,
    enable  => true,
    require => [ File['/etc/init.d/oradb'], File["${oracle_home}/network/admin/${listener}.ora"]],
  }

}
