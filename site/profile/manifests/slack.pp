class profile::slack {

  $packages = [
    'gconf2',
    'gconf-service',
    'libnotify4',
    'python',
    'gvfs-bin',
    'libgnome-keyring0',
    'gir1.2-gnomekeyring-1.0',
    'libappindicator1',
    'libcurl4',
    'libsecret-1-0'
  ];

  package { $packages:
      ensure => 'installed'
  }

  exec { 'download':
    command =>
      "/usr/bin/wget -O /tmp/slack.deb https://downloads.slack-edge.com/linux_releases/slack-desktop-3.2.0-beta25a7a50e-amd64.deb"
    ,
    onlyif  => 'test ! -f /tmp/slack.deb',
    path => ['/bin', '/usr/bin']
  }

  package { 'install':
    ensure   => installed,
    name     => "slack.deb",
    provider => 'dpkg',
    source   => "/tmp/slack.deb",
  }

  file { 'cleanup':
    ensure => absent,
    path   => "/tmp/slack.deb",
  }

  Package[$packages] -> Exec['download'] -> Package['install'] -> File['cleanup']
}