file {'/tmp/puppet':
  ensure => 'directory'
}

file {'/opt/puppet':
  ensure => directory
}

lookup('classes', Array[String], 'unique', []).include
