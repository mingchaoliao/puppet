class role::linux::ubuntu::udesk {
  contain role::linux::ubuntu::desktop
  contain profile::applications::chrome
  contain profile::ssr
  #
  # exec {'baidupcs config set -enable_https=true -savedir=/media/localu -max_download_load=5 -max_parallel=200':
  #   user => 'liaom',
  #   require => [Class[profile::baidupcs]]
  # }
}