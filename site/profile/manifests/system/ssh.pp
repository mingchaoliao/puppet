class profile::system::ssh {
  class {'::ssh':
    service_enable => true,
    service_ensure => 'running',
    ssh_config_forward_x11 => 'yes',
    sshd_password_authentication => 'no',
    sshd_config_permitemptypasswords => 'no',
    permit_root_login => 'no'
  }

  contain '::ssh'
}