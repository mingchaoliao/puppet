# profile/java.pp
# Manage java
#
#  [*distribution*]
#    The java distribution to install. Can be one of "jdk" or "jre",
#    or other platform-specific options where there are multiple
#    implementations available (eg: OpenJDK vs Oracle JDK).
#
# Want 1.8 jre on CentOS 7? (this is now the default for > 7.0)
#  profile::java::distribution: jre
#  profile::java::package: java-1.8.0-openjdk
#
# Uses the puppetlabs/java module
# https://forge.puppet.com/puppetlabs/java
#

class profile::java (
  $distribution  = 'oracle',
  $package       = undef,
  $version       = '8',
  $version_major = '8u131',
  $version_minor = 'b11',
  $java_se       = jdk,
  $url           = undef,
  $url_hash      = 'd54c1d3a095b4ff2b6607d096fa80163',
){

  if $distribution == 'oracle' {
    java::oracle { 'java-oracle':
      version       => $version,
      version_major => $version_major,
      version_minor => $version_minor,
      java_se       => $java_se,
      url           => $url,
      url_hash      => $url_hash,
    }
    $java_home = '/usr/java/latest'
    contain '::java'
  } else {
    class { '::java':
      distribution => $distribution,
      package      => $package,
    }
    contain '::java'
    $java_home = '/usr/lib/jvm'
  }
}
