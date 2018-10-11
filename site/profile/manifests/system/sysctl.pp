class profile::system::sysctl(
  $configs = lookup('', Hash, 'deep', {})
) {
  $sysctl = '/etc/sysctl.conf'

  $configs.each |String $key, Hash $config| {
    file_line {"$sysctl/$key":
      ensure => $config['ensure'] ? {
        'absent' => absent,
        default => present
      },
      path => $sysctl,
      line => "$key = ${config['value']}"
    }
  }

  exec {'/sbin/sysctl -p --system':

  }
}