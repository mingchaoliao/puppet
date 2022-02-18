class profile::system::ssh(
  $pwd_enabled_users = lookup('profile::system::ssh::merged_pwd_enabled_users', Array, 'deep', [])
) {
  $options = {
    'PermitRootLogin' => 'no',
    'PasswordAuthentication' => 'no',
    'PermitEmptyPasswords' => 'no',
  }

  if $pwd_enabled_users.length != 0 {
    $user = {
      "Match User ${join($pwd_enabled_users, ',')}" => {
        'PasswordAuthentication' => 'yes',
      },
    }
  } else {
    $user = {}
  }

  class { '::ssh':
    server_options => merge($options, $user)
  }

  contain '::ssh'
}
