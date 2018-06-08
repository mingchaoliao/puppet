class profile::java {
  case $facts['os']['family'] {
    'Debian': {
      include apt
      apt::ppa { 'ppa:webupd8team/java': }
      ->exec {
        'set-licence-selected':
          command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections';
        'set-licence-seen':
          command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections';
      }
      ->package {'oracle-java8-installer':
        ensure => present,
        require => Class['apt::update']
      }
      ->file {'/etc/profile.d/java_home.sh':
        ensure => file,
        content => 'export JAVA_HOME=/usr/lib/jvm/java-8-oracle'
      }
    }
    'RedHat': {
      java::oracle { 'jdk8':
        ensure        => present,
        version_major => '8u131',
        version_minor => 'b11',
        java_se       => 'jdk'
      }
    }
    default: {
      fail("unsupported platform ${$facts['kernel']}")
    }
  }
}
