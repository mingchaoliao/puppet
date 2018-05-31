# profile/oracle/common.pp
# Manage Oracle Common Stuff
#

class profile::oracle::common (
  $user              = 'oracle',
  $group             = 'dba',
  $groups            = undef,
  $home              = '/home/oracle',
  $oracle_home_base  = '/opt/oracle/product/12.1.0',
  $download_dir      = '/opt/oracle/software',
  $ora_inventory     = pick($facts['oradb_inst_loc_data'], '/opt/oraInventory'),
  $directories       = undef,
  $pam_access_origin = 'ALL',
){

  $ora_inventory_dir = $ora_inventory.split('/')[0, -2].join('/')

  $_directories = $directories ? {
    undef   => [
      '/opt/oracle',
      '/opt/oracle/product',
      $oracle_home_base,
      $download_dir,
    ],
    default => $directories,
  }

  group { $group:
    gid    => '5000',
    system => true,
  }

  user { $user:
    uid        => '5000',
    gid        => '5000',
    groups     => $groups,
    home       => $home,
    managehome => true,
    shell      => '/bin/bash',
    system     => true,
  }

  if $_directories {
    file { $_directories:
      ensure => directory,
      mode   => '0775',
      owner  => $user,
      group  => $group,
    }
  }
}
