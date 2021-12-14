class profile::oit::keep_mouse_moving(
  Enum['present', 'absent'] $ensure = 'present'
) {
  package{'xdotool':
    ensure => $ensure
  }
  ->file {'/usr/local/bin/keep_mouse_moving':
    content => file('profile/oit/keep_mouse_moving.sh'),
    ensure => $ensure,
    mode => '0755'
  }
  -> systemd::unit_file { 'keep-mouse-moving.service':
    ensure => $ensure,
    content => file('profile/oit/keep-mouse-moving.service'),
  }
  ~> service {'keep-mouse-moving':
    ensure => $ensure ? {absent => stopped, default => running},
    enable => true,
  }
}