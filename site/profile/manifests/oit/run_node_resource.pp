class profile::oit::run_node_resource(
  Enum['present', 'absent'] $ensure = 'present',
) {
  file {'/usr/local/bin/run-node-resource':
    content => file('profile/oit/run-node-resource.sh'),
    mode => '0755',
    ensure => $ensure
  }
}
