class profile::user (
  $users = {}
) {
  # TODO: fix this
  $users.each |Hash $user| {
    user { $user['username']:
      ensure  => present,
      comment => $user['full_name'],
      expiry  => absent,
      home    => "/home/${user['username']}"
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
      sudo::conf { "no-password sudoer ${user['username']}":
        content => "${user['username']} ALL=(ALL) NOPASSWD:ALL",
      }
    }
  }
}