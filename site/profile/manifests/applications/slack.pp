class profile::applications::slack (
  String $ensure = 'present',
  String $source = 'https://downloads.slack-edge.com/linux_releases/slack-desktop-3.3.3-amd64.deb'
) {
  $release = Float($facts['os']['release']['major'])

  if $facts['os']['name'] == 'Ubuntu' and $release >= 18 {
    package {'slack':
      ensure => $ensure,
      provider => snap
    }
  } else {
    package { ['libappindicator1', 'libindicator7']:
      ensure => $ensure
    }

    file { '/tmp/puppet/slack.deb':
      ensure => $ensure,
      source => $source
    }

    package { 'install_slack':
      ensure   => $ensure,
      provider => 'dpkg',
      source   => '/tmp/puppet/slack.deb',
      require  => [Package['libappindicator1', 'libindicator7'], File['/tmp/puppet/slack.deb']]
    }
  }
}