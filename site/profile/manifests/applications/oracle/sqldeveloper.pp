class profile::applications::oracle::sqldeveloper(
  $file = 'puppet:///files/sqldeveloper-18.1.0.095.1630-no-jre.zip'
) {
  archive {'/tmp/puppet/tmp/sqldeveloper.zip':
    extract => true,
    extract_path => '/opt',
    source => $file
  }
  ->file {'/tmp/puppet/tmp/sqldeveloper.zip':
    ensure => absent
  }
}