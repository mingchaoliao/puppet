class profile::skaffold(
  Enum['present', 'absent'] $ensure = 'present',
) {
  file {'/usr/local/bin/skaffold':
    source => 'https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64',
    mode => '0755',
    ensure => $ensure
  }
}
