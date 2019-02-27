class profile::docker(
  $ensure = 'present',
  $docker_version = 'latest',
  $docker_compose_version = 'latest',
  $users = lookup('profile::docker::merged_users', Array, 'deep', [])
) {
  class { 'docker':
    ensure => $ensure,
    docker_users => $users,
    version => $docker_version
  }
  class { 'docker::compose':
    ensure => $ensure,
    version => $docker_compose_version
  }
  include 'docker', 'docker::compose'
}