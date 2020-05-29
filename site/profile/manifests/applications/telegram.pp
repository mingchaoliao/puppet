class profile::applications::telegram (
  String $ensure = 'present',
  String $source = 'puppet:///files/tsetup.2.1.7.tar.xz'
) {
  $release = Float($facts['os']['release']['major'])

  if $facts['os']['name'] == 'Ubuntu' and $release >= 18 {
    package {'telegram-desktop':
      ensure => $ensure,
      provider => snap
    }
  } else {
    archive { "/tmp/telegram.tar.xz":
      ensure => $ensure,
      source       => $source,
      extract      => true,
      extract_path => '/opt',
      creates      => "/opt/Telegram"
    }
    -> file {'/opt/Telegram/telegram_logo.png':
      ensure => $ensure,
      content => file('profile/applications/telegram/telegram_logo.png')
    }
    -> profile::applications::desktop::ubuntu::unity::launcher { 'telegram':
      ensure => $ensure,
      desktopFileDirecoty => '/opt/Telegram',
      displayedName => 'Telegram',
      comment       => "a new era of messaging",
      exec          => "/opt/Telegram/Telegram",
      icon          => "/opt/Telegram/telegram_logo.png"
    }
  }
}