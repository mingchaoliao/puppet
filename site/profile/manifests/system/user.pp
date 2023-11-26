class profile::system::user (
  $users = lookup('profile::system::user::merged_users', Hash, 'deep', {})
) {
  archive { "/tmp/puppet/bash-profile.tar.gz":
    extract      => true,
    extract_path => '/opt',
    source       => 'puppet:///files/bash-profile.tar.gz',
    creates      => "/opt/bash-profile",
  }

  $users.each |String $username, Hash $user| {
    if $username != 'root' {
      user { $username:
        ensure     => $user['ensure'],
        comment    => $user['full_name'],
        shell      => $user['shell'],
        expiry     => absent,
        home       => "/home/$username",
        managehome => true,
      }

      if($user['ensure'] != 'absent') {
        $user['public_keys'].each |Hash $public_key| {
          ssh_authorized_key { $public_key['name']:
            ensure => $public_key['ensure'],
            user   => $username,
            type   => $public_key['type'],
            key    => $public_key['key']
          }
        }
      }

      if($user['sudo'] == true) {
        sudo::conf { "no_password_sudoer_$username":
          ensure => $user['ensure'],
          content => "$username ALL=(ALL) NOPASSWD:ALL",
        }
      }
    }

    if $user['ensure'] != 'absent' {
      file { "bashrc_${username}":
        ensure => 'file',
        path => ($username == 'root' ? {
          true  => '/root/.bashrc',
          false => "/home/$username/.bashrc",
        }),
        require => $username == 'root' ? {
          true => [],
          false => User[$username],
        },
      }
      -> file_line { "bash_profile_${username}":
        ensure => 'bash_profile' in $user ? {
          true  => $user['bash_profile'],
          false => 'absent',
        },
        path   => ($username == 'root' ? {
          true  => '/root/.bashrc',
          false => "/home/$username/.bashrc",
        }),
        line   => "source /opt/bash-profile/main",
      }
    }
  }
}
