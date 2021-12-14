class profile::oit::dcvpn(
  Enum['present', 'absent'] $ensure = 'present',
  String $user,
) {
  if $ensure == 'present' {
    package {'network-manager-l2tp-gnome':
      ensure => $ensure
    }
    -> Exec {'Add DCVPN':
      command => "/usr/bin/nmcli c add type vpn con-name oit-dcvpn vpn-type l2tp vpn.data 'user=$user, gateway=dcvpn.ohio.edu, ipsec-enabled=yes, ipsec-esp=aes256-sha1, ipsec-ike=aes256-sha1-ecp384, ipsec-psk=ohiobobcats, password-flags=0'",
      unless => '/usr/bin/nmcli c | grep oit-dcvpn'
    }
  } else {
    package {'network-manager-l2tp-gnome':
      ensure => $ensure
    }
    -> Exec {'Remove DCVPN':
      command => '/usr/bin/nmcli c delete oit-dcvpn',
      onlyif => '/usr/bin/nmcli c | grep oit-dcvpn'
    }
  }
}
