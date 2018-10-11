class profile::sift (
  $ensure        = 'present',
  $downloadUrl   = 'https://sift-tool.org/downloads/sift/sift_0.9.0_linux_amd64.tar.gz',
  $extractedName = 'sift_0.9.0_linux_amd64'
) {
  archive { '/tmp/puppet/tmp/sift.tar.gz':
    extract      => true,
    extract_path => '/tmp/puppet/tmp',
    source       => $downloadUrl,
    creates      => '/usr/bin/sift'
  }
  -> file { '/opt/sift':
    ensure  => directory,
    source  => "/tmp/puppet/tmp/$extractedName",
    recurse => true
  }
  -> file { '/usr/bin/sift':
    ensure => link,
    target => '/opt/sift/sift'
  }
}