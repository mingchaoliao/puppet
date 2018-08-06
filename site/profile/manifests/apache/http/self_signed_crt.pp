class profile::apache::http::self_signed_crt {
  include ::openssl

  file { '/opt/ssl':
    ensure => directory
  }
  -> file { '/opt/ssl/cert.cnf':
    ensure  => file,
    content => template('profile/apache/cert.cnf.erb')
  }
  -> ssl_pkey { '/opt/ssl/self_signed.key':
    ensure => present,
    size   => 2048
  }
  -> x509_cert { '/opt/ssl/self_signed.crt':
    ensure      => present,
    private_key => '/opt/ssl/self_signed.key',
    days        => 365,
    template    => '/opt/ssl/cert.cnf'
  }
}