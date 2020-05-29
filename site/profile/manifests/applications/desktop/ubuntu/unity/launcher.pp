define profile::applications::desktop::ubuntu::unity::launcher (
  String $ensure              = 'present',
  String $desktopFileDirecoty = '/tmp',
  String $desktopFileName     = $title,
  String $displayedName       = '',
  String $comment             = 'no comment',
  String $exec                = '',
  String $icon                = '',
  Boolean $terminal           = false,
  String $type                = 'Application'
) {
  $desktopFile = {
    name     => $displayedName,
    comment  => $comment,
    exec     => $exec,
    icon     => $icon,
    terminal => $terminal,
    type     => $type
  }

  $desktopFileTitle = "Ubuntu Desktop File: ${desktopFileName}.desktop"

  file { $desktopFileTitle:
    path => "${desktopFileDirecoty}/${desktopFileName}.desktop",
    ensure  => $ensure ? {
      absent  => 'absent',
      default => 'file'
    },
    content => template('profile/applications/desktop/ubuntu/unity/desktop.erb')
  }

  if $ensure == 'absent' {
    file {"Remove Desktop File: ${desktopFileName}.desktop":
      path => "/usr/share/applications/${desktopFileName}.desktop",
      ensure => absent,
      require => File[$desktopFileTitle]
    }
  } else {
    exec {"/usr/bin/desktop-file-install ${desktopFileDirecoty}/${desktopFileName}.desktop":
      require => File[$desktopFileTitle],
      creates => "/usr/share/applications/${desktopFileName}.desktop"
    }
  }
}