class profile::user (
  $users = lookup('profile::user::merged_users', Hash, 'deep', [])
) {
  $users.each |String $username, Hash $user| {
    user { $username:
      ensure     => $user['ensure'],
      comment    => $user['full_name'],
      shell      => $user['shell'],
      expiry     => absent,
      home       => "/home/$username",
      managehome => true
    }

    $user['public_keys'].each |Hash $public_key| {
      ssh_authorized_key { $public_key['name']:
        ensure => $public_key['ensure'],
        user   => $username,
        type   => $public_key['type'],
        key    => $public_key['key']
      }
    }

    if($user['sudo'] == true) {
      sudo::conf { "no_password_sudoer_$username":
        content => "$username ALL=(ALL) NOPASSWD:ALL",
      }
    }
  }
}