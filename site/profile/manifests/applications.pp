class profile::applications(
  $packages = lookup('profile::application::merged_packages', Hash, 'deep', {})
) {
  create_resources(package, $packages)
}