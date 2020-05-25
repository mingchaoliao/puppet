class profile::minikube(
  $ensure = 'present',
  $source = 'https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64'
) {
  file {'/usr/local/bin/minikube':
    ensure => $ensure,
    source => $source,
    mode => '0755'
  }
}