define profile::applications::desktop::ubuntu::unity::launcher (
  String $desktopFileDirecoty = '/usr/share/applications',
  String $desktopFileName     = $title,
  String $displayedName,
  String $comment             = 'no comment',
  String $exec,
  String $icon,
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

  file { "${desktopFileDirecoty}/${desktopFileName}.desktop":
    ensure  => file,
    content => template('profile/applications/desktop/ubuntu/unity/desktop.erb')
  }
}