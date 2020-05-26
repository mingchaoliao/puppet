class role::linux::miami_dev {
  contain profile::applications::cisco::anyconnect
  contain profile::miamioh::tns
  contain profile::miamioh::ssh_alias
  contain role::web
  contain profile::docker::commands
}