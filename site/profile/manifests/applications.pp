class profile::applications(
  $packages = lookup('profile::application::packages', Hash, 'deep', {})
) {
  create_resources(package, $packages)
}