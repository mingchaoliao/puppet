class profile::system::ssh(
  $pwd_enabled_users = lookup('profile::system::ssh::merged_pwd_enabled_users', Array, 'deep', [])
) {
  if $pwd_enabled_users.length {
    class { '::ssh':
      server_options => {
        "Match User ${join($pwd_enabled_users, ',')}" => {
          'PasswordAuthentication' => 'yes',
        },
        'PermitRootLogin' => 'no',
        'PasswordAuthentication' => 'no',
        'PermitEmptyPasswords' => 'no',
      },
    }
  } else {
    class { '::ssh':
      server_options => {
        'PermitRootLogin' => 'no',
        'PasswordAuthentication' => 'no',
        'PermitEmptyPasswords' => 'no',
      },
    }
  }

  contain '::ssh'
}
