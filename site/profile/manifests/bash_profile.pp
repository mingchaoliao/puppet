class profile::bash_profile(
  $users = lookup('profile::bash_profile::merged_users', Hash, 'deep', {})
) {
  archive { "/tmp/puppet/bash-profile.tar.gz":
    extract      => true,
    extract_path => '/opt',
    source       => 'puppet:///files/bash-profile.tar.gz',
    creates      => "/opt/bash-profile",
  }

  $users.each |String $username, Hash $user| {
    if($user['ensure'] != 'absent') {
      file { "bashrc_${username}":
        ensure => 'file',
      }
    }

    file_line { "bash_profile_${username}":
      ensure => $user['ensure'],
      path   => "/home/${username}/.bashrc",
      line   => "source /opt/bash-profile/main",
    }
  }
}
