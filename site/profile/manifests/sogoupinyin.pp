class profile::sogoupinyin(
  $ensure = 'present',
  $source = 'puppet:///files/sogoupinyin_4.2.1.145_amd64.deb'
) {
  package {'fcitx-bin':
    ensure => $ensure,
  }
  -> file {'/tmp/puppet/sogoupinyin.deb':
    source => $source,
    ensure => $ensure,
  }
  -> package {'sogoupinyin':
    source => '/tmp/puppet/sogoupinyin.deb',
    ensure => $ensure
  }
  -> Exec {'Set Input Method System To fcitx':
    command => '/usr/bin/im-config -n fcitx',
    unless => '/usr/bin/im-config -m | /usr/bin/head -n 1 | /usr/bin/grep fcitx'
  }
  ->package {[
    'language-pack-gnome-zh-hans',
    'language-pack-zh-hans',
    'language-pack-zh-hans-base',
    'language-pack-gnome-zh-hans-base'
  ]:
    ensure => $ensure
  }
}
