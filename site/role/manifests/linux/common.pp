class role::linux::common {
  contain profile::glances
  contain profile::docker
  contain profile::system::drop_page_cache
  contain profile::system::ssh
  contain profile::rclone

  package {[
    'cifs-utils',
    'ffmpeg',
    'zerofree',
    'screen',
    'iotop',
    'iftop',
    'resolvconf',
    'hardinfo',
    'rar',
    'net-tools'
  ]: }
}
