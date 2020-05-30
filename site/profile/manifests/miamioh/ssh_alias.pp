class profile::miamioh::ssh_alias(
  $hosts = lookup('profile::miamioh::ssh_alias::hosts', Hash, deep, {})
) {
  $users = lookup ('profile::user::merged_users', Hash, deep, {})

  $users.each | String $username, Hash $userConfig| {
    $sshDir = "/home/$username/.ssh"

    file {$sshDir:
      ensure => 'directory',
      mode => '0700'
    }

    $hosts.each | String $key, Hash $config| {
      ssh_config {"ssh alias $key for user $username":
        key => 'Hostname',
        ensure => $config['ensure'],
        host => $key,
        value => $config['hostname'],
        target => "$sshDir/config",
        require => [User[$username], File[$sshDir]]
      }
    }
  }
}