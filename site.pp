file { '/etc/puppetlabs/puppet/fileserver.conf':
  ensure => file,
  content => "[files]\n  path /tmp/puppet/files\n  allow *\n",
  replace => 'no'
}

file {['/tmp/puppet', '/tmp/puppet/files']:
  ensure => directory
}

contain '::profile::apache'
contain '::profile::apache::mod_php'
contain '::profile::oracle'
contain '::profile::commands'
contain '::profile::chrome'
contain '::profile::slack'
