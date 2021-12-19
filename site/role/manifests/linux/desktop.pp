class role::linux::desktop {
  contain profile::shutter
  package{[
    'gparted',
    'guake',
    'thunderbird',
    'kcachegrind',
  ]: }

  package {'vlc':
    provider => snap
  }
}