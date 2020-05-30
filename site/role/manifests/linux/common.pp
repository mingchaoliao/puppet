class role::linux::common {
  contain profile::system::ssh
  contain profile::system::sysctl
  contain profile::sift
  contain profile::docker
  contain profile::baidupcs
  contain profile::golang
  contain profile::thefuck
  contain profile::kubectl
  contain profile::glances
  contain profile::system::drop_page_cache
}
