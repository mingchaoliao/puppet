class profile::oit::dcvpn_split_tunnel(
  Enum['present', 'absent'] $ensure = 'present',
) {
  file {'/usr/local/bin/dcvpn-split-tunnel':
    content => file('profile/oit/dcvpn_split_tunnel.sh'),
    mode => '0755',
    ensure => $ensure
  }
}