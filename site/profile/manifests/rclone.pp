class profile::rclone(
  $ensure   = 'present',
  $source   = 'https://downloads.rclone.org/v1.57.0/rclone-v1.57.0-linux-amd64.deb'
) {
  file {'/tmp/puppet/rclone.deb':
    ensure => $ensure,
    source => $source
  }
  ->package {'rclone':
    provider => 'dpkg',
    ensure => $ensure,
    source => '/tmp/puppet/rclone.deb'
  }
}
