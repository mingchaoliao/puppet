class profile::miamioh::ssh_alias(
  $hosts = lookup('profile::miamioh::ssh_alias::alias', Hash, deep, {})
) {
  $hosts.each | String $key, Hash $config| {
    file_line {"ssh alias $key":
      path => '/etc/ssh/ssh_config',
      ensure => $config['ensure'],
      line => "Host $key\nHostname ${config['hostname']}"
    }
  }
}