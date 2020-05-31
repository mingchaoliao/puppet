class profile::java (
  $ensure = 'present',
  $url,
  $extractedDirectoryName
) {
  if $ensure == 'absent' {
    file{"/opt/$extractedDirectoryName":
      ensure => absent,
      force => true,
      recurse => true,
      purge => true
    }
  }

  archive { "/tmp/puppet/java.tar.gz":
    ensure => $ensure,
    source       => $url,
    extract      => true,
    extract_path => '/opt',
    creates      => "/opt/$extractedDirectoryName"
  }
  ->file { '/etc/profile.d/oracle_java_setup.sh':
    ensure  => $ensure == 'absent' ? {true => 'absent', default => 'file'},
    mode    => '0644',
    content => "export PATH=/opt/$extractedDirectoryName/bin:\$PATH\nexport JAVA_HOME=/opt/$extractedDirectoryName"
  }
}
