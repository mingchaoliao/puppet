file {'/tmp/puppet':
  ensure => directory
}

file {'/tmp/puppet/tmp':
  ensure => directory
}
->exec {'/bin/rm -rf /tmp/puppet/tmp/*': }

file { '/etc/puppetlabs/puppet/fileserver.conf':
  ensure => file,
  content => "[files]\n  path /tmp/puppet/files\n  allow *\n",
  replace => 'no'
}

contain '::profile::apache'
contain '::profile::apache::mod_php'
contain '::profile::oracle'
contain '::profile::commands'
contain '::profile::applications'
