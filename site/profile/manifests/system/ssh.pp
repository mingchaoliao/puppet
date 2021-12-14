class profile::system::ssh {
  class { '::ssh':
    server_options => {
      'PermitRootLogin' => 'no',
      'PasswordAuthentication' => 'no',
      'PermitEmptyPasswords' => 'no',
    },
  }

  contain '::ssh'
}
