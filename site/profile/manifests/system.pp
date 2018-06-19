class profile::system {
  contain '::profile::system::accounts'
  contain '::profile::system::ssh'
}