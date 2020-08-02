class profile::microk8s (
  $ensure = 'present',
  $users = lookup('profile::microk8s::merged_users', Array, 'deep', []),
  $enable_ingress = true
) {
  $release = Float($facts['os']['release']['major'])

  if $facts['os']['name'] == 'Ubuntu' and $release >= 18 {
    package {'microk8s':
      ensure => $ensure,
      provider => snap
    }

    if $enable_ingress {
      exec {"enable-microk8s-addon-ingress":
        command => "/snap/bin/microk8s.enable ingress",
        unless  => "/snap/bin/microk8s.status -a ingress | grep -qw enabled",
        require => Package['microk8s']
      }
    } else {
      exec {"disable-microk8s-addon-ingress":
        command => "/snap/bin/microk8s.disable ingress",
        unless  => "/snap/bin/microk8s.status -a ingress | grep -qw disabled",
        require => Package['microk8s']
      }
    }

    $users.each | $name | {
      exec { "microk8s-system-user-${name}":
        command => "/usr/sbin/usermod -aG microk8s ${name}",
        unless  => "/bin/cat /etc/group | grep '^microk8s:' | grep -qw ${name}",
        require => [Package['microk8s'], Class[profile::user]]
      }
    }
  } else {
    fail("Installing microk8s on non-ubuntu (>= 18.04) machine is not supported")
  }
}