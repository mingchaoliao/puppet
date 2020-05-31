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
  -> file {'/opt/nginx/default.conf':
    ensure => 'file',
    content => file('profile/udeck/nginx.conf')
  }
  -> exec {'grep liaom /etc/shadow > /opt/nginx/.htpasswd':
    path => '/bin',
    creates => '/opt/nginx/.htpasswd',
    require => User['liaom']
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