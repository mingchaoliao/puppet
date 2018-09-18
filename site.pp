file {'/tmp/puppet':
  ensure => directory
}
->file {'/tmp/puppet/tmp':
  ensure => directory
}
->file { '/etc/puppetlabs/puppet/fileserver.conf':
  ensure => file,
  content => "[files]\n  path /tmp/puppet/files\n  allow *\n",
  replace => 'no'
}

lookup('classes').include