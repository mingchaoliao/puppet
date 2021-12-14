class role::desktop {
  contain profile::chrome
  contain profile::ssr
  package {[
    'slack',
    'telegram-desktop',
    'postman'
  ]:
    provider => snap
  }
}
