file {'/tmp/puppet':
  ensure => 'directory'
}
->file {'/opt/puppet':
  ensure => directory
}
->file { '/etc/puppetlabs/puppet/fileserver.conf':
  ensure => file,
  content => "[files]\n  path /opt/puppet/files\n  allow *\n",
  replace => 'no'
}

lookup('classes', Array[String], 'unique', []).include
