class profile::sift (
  $ensure        = 'present',
  $source   = 'https://sift-tool.org/downloads/sift/sift_0.9.0_linux_amd64.tar.gz',
  $extractedName = 'sift_0.9.0_linux_amd64'
) {
  archive { "/tmp/puppet/${extractedName}.tar.gz":
    extract      => true,
    extract_path => '/opt',
    source       => $source,
    creates      => "/opt/$extractedName/sift"
  }
  -> file { "/opt/$extractedName/sift":
    ensure => 'file',
    mode   => '0755'
  }
  -> file { '/usr/bin/sift':
    ensure => link,
    target => "/opt/$extractedName/sift"
  }
}