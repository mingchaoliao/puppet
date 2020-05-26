class profile::java (
  $ensure = 'present',
  $url,
  $extractedDirectoryName
) {
  archive { "/tmp/puppet/java.tar.gz":
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
