class profile::oracle::instantclient (
  $version                    = '18.3',
  $sharedLibVersion           = '18.1',
  $extractFolderName          = 'instantclient_18_3',
  $instantClientBasicFile     = "puppet:///files/instantclient-basic-linux.x64-18.3.0.0.0dbru.zip",
  $instantClientSdkFile       = "puppet:///files/instantclient-sdk-linux.x64-18.3.0.0.0dbru.zip",
) {
  ensure_packages([
    'libaio1',
    'libaio-dev',
    'unzip'
  ])

  file { [
    '/usr/lib/oracle',
    "/usr/lib/oracle/$version",
    "/usr/lib/oracle/$version/client64"
  ]:
    ensure => directory,
  }
  -> archive { "/tmp/puppet/instantclient-basic.zip":
    extract      => true,
    extract_path => '/tmp/puppet',
    source       => $instantClientBasicFile,
    creates      => "/tmp/puppet/$extractFolderName"
  }
  -> archive { "/tmp/puppet/instantclient-sdk.zip":
    extract      => true,
    extract_path => '/tmp/puppet',
    source       => $instantClientSdkFile,
    creates      => "/tmp/puppet/$extractFolderName/sdk"
  }
  -> file { "/usr/lib/oracle/$version/client64/lib":
    ensure  => directory,
    source  => "/tmp/puppet/$extractFolderName",
    recurse => true
  }
  -> file { "/usr/lib/oracle/$version/client64/lib/libclntsh.so":
    ensure => link,
    target => "/usr/lib/oracle/$version/client64/lib/libclntsh.so.$sharedLibVersion"
  }
  -> file { "/usr/lib/oracle/$version/client64/lib/libocci.so":
    ensure => link,
    target => "/usr/lib/oracle/$version/client64/lib/libocci.so.$sharedLibVersion"
  }
  -> file { '/etc/profile.d/set_oracle_home.sh':
    mode    => '0755',
    content => "export ORACLE_HOME=/usr/lib/oracle/$version/client64",
  }
}
