class profile::mysql {
  class { '::mysql::server':
    root_password           => 'root',
    remove_default_accounts => true
  }

  contain '::mysql::server'
  contain '::mysql::client'
}