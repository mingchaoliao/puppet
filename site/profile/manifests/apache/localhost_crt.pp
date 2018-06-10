class profile::apache::localhost_crt {
  include ::openssl

  file {'/opt/ssl':
    ensure => directory
  }
  ->file {'/opt/ssl/cert.cnf':
    ensure => file,
    content => template('profile/apache/cert.cnf.erb')
  }
  ->ssl_pkey {'/opt/ssl/localhost.key':
    ensure => present,
    size => 2048
  }
  ->x509_cert {'/opt/ssl/localhost.crt':
    ensure => present,
    private_key => '/opt/ssl/localhost.key',
    days => 365,
    template => '/opt/ssl/cert.cnf'
  }
}