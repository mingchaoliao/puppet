class profile::applications::slack {
  file { '/tmp/puppet/tmp/slack.deb':
    source  => 'https://downloads.slack-edge.com/linux_releases/slack-desktop-3.2.1-amd64.deb',
    ensure  => present,
    replace => false
  }

  package { ['libappindicator1', 'libindicator7']: }

  package { '/tmp/puppet/tmp/slack.deb':
    ensure   => present,
    provider => 'dpkg',
    source   => '/tmp/puppet/tmp/slack.deb',
    require  => [File['/tmp/puppet/tmp/slack.deb'], Package['libappindicator1', 'libindicator7']]
  }
}