class role::linux::desktop {
  contain profile::chrome

  package {[
    'gparted',
  ]: }
}
