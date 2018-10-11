class role::linux::miami_dev {
  contain profile::applications::cisco::anyconnect
  contain profile::miamioh::tns
}