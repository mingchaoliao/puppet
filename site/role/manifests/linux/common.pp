class role::linux::common {
  contain profile::system::ssh
  contain profile::bash_profile

  package {[
    'guake',
    'git',
    'net-tools',
    'iotop',
    'iftop',
    'screen',
  ]: }
}
