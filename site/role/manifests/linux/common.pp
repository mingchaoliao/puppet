class role::linux::common {
  contain profile::system::ssh
  contain profile::system::sysctl
  contain profile::sift
  contain profile::docker
}
