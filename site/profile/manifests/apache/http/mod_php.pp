class profile::apache::http::mod_php () {

  contain '::profile::php'

  contain '::apache::mod::php'

  Class['::profile::php']
  -> Class['::apache::mod::php']
  -> File[$::apache::confd_dir]
}