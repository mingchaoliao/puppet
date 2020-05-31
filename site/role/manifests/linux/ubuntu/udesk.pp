class role::linux::ubuntu::udesk {
  contain role::linux::ubuntu::desktop
  contain profile::applications::chrome
  contain profile::ssr
  contain profile::applications::telegram
  #
  # exec {'baidupcs config set -enable_https=true -savedir=/media/localu -max_download_load=5 -max_parallel=200':
  #   user => 'liaom',
  #   require => [Class[profile::baidupcs]]
  # }

  file {'/opt/nginx':
    ensure => 'directory'
  }
  -> file {'/opt/nginx/nginx.conf':
    ensure => 'file',
    content => file('profile/udeck/nginx.conf')
  }
  -> file {'/opt/nginx/default.conf':
    ensure => 'file',
    content => file('profile/udeck/server.conf')
  }
  -> exec {'grep liaom /etc/shadow > /opt/nginx/.htpasswd':
    path => '/bin',
    creates => '/opt/nginx/.htpasswd',
    require => User['liaom']
  }
  -> file {'/usr/share/nginx':
    ensure => directory,
    mode => '0777'
  }
  -> file {'/opt/nginx/ssl':
    ensure => directory
  }
  -> exec {'create_self_signed_sslcert':
    command => "openssl req -newkey rsa:2048 -nodes -keyout localhost.key -x509 -days 365 -out localhost.crt -subj '/CN=localhost'",
    cwd     => '/opt/nginx/ssl',
    creates => [ "/opt/nginx/ssl/localhost.key", "/opt/nginx/ssl/localhost.crt"],
    path    => ["/usr/bin", "/usr/sbin"]
  }
  -> systemd::unit_file { 'nginx.service':
    ensure => 'present',
    content => file('profile/udeck/nginx.service'),
    require => Class['profile::docker']
  }
  ~> service {'nginx':
    ensure => running,
  }
}
