class role::dev_desktop {
  contain role::dev_server
  contain profile::vmware_workstation
  contain profile::jetbrains
  contain profile::oracle::sqldeveloper
  contain profile::oracle::virtualbox

  package {'code':
    provider => snap
  }
}
