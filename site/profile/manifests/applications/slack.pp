class profile::applications::slack {
  archive {'/tmp/puppet/tmp/slack.deb':
    source => 'https://downloads.slack-edge.com/linux_releases/slack-desktop-3.2.1-amd64.deb',
    extract => false
  }
  ->package {[
    'libappindicator1',
    'libindicator7'
  ]:
    ensure => present
  }
  ->package { '/tmp/puppet/tmp/slack.deb':
    ensure   => present,
    provider => 'dpkg',
    source => '/tmp/puppet/tmp/slack.deb'
  }
  ->file { '/tmp/puppet/tmp/slack.deb':
    ensure => absent
  }

}