class profile::user (
  $users = lookup('profile::user::users', Array[Hash], 'deep', [])
) {
  $users.each |Hash $user| {
    user { $user['username']:
      ensure     => present,
      comment    => $user['full_name'],
      shell      => $user['shell'],
      expiry     => absent,
      home       => "/home/${user['username']}",
      managehome => true
    }

    $user['public_keys'].each |Hash $public_key| {
      ssh_authorized_key { $public_key['name']:
        ensure => present,
        user   => $user['username'],
        type   => $public_key['type'],
        key    => $public_key['key']
      }
    }

    if($user['sudo'] == true) {
      sudo::conf { "no_password_sudoer_${user['username']}":
        content => "${user['username']} ALL=(ALL) NOPASSWD:ALL",
      }
    }
  }
}