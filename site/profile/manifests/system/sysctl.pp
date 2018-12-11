class profile::system::sysctl(
  $configs = lookup('profile::system::sysctl::configs', Hash, 'deep', {})
) {
  create_resources(sysctl, $configs)
}