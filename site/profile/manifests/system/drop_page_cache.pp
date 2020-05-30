class profile::system::drop_page_cache(
  $ensure = 'present'
) {
  $minutes = [0, 20, 40]

  $minutes.each | Integer $minute | {
    cron {"drop-page-cache-at-minute-$minute":
      ensure => $ensure,
      command => 'sync; echo 3 > /proc/sys/vm/drop_caches',
      user => 'root',
      minute => $minute
    }
  }
}