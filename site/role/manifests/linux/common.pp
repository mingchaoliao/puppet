class role::linux::common {
  contain profile::system::ssh

  package {[
    'guake',
    'git',
    'net-tools',
    'iotop',
    'iftop',
    'screen',
  ]: }
}
