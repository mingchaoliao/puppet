class profile::chrome (
  String $ensure = 'present'
) {
  ::apt::key {'google-linux-key1':
    id => '4CCA1EAF950CEE4AB83976DCA040830F7FAC5991',
    source => 'https://dl.google.com/linux/linux_signing_key.pub',
  }
  ->::apt::key {'google-linux-key2':
    id => 'EB4C1BFD4F042F6DDDCCEC917721F63BD38B4796',
    source => 'https://dl.google.com/linux/linux_signing_key.pub'
  }
  ->::apt::source {'google-chrome-stable':
    location => 'https://dl.google.com/linux/chrome/deb',
    release => 'stable',
    architecture => $facts['os']['architecture'],
    repos => 'main',
  }
  -> Exec {'/usr/bin/apt-get update':
    unless => '/usr/bin/apt search google-chrome-stable | /usr/bin/grep google-chrome-stable'
  }
  ->package {'google-chrome-stable':
    ensure => $ensure,
  }
}
