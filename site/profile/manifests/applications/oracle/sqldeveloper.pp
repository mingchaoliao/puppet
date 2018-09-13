class profile::applications::oracle::sqldeveloper (
  $file = 'puppet:///files/sqldeveloper-18.1.0.095.1630-no-jre.zip'
) {
  archive { '/tmp/puppet/tmp/sqldeveloper.zip':
    extract      => true,
    extract_path => '/tmp/puppet/tmp',
    source       => $file,
    creates      => '/tmp/puppet/tmp/sqldeveloper'
  }
  -> file { '/opt/sqldeveloper':
    recurse => true,
    source  => '/tmp/puppet/tmp/sqldeveloper'
  }
  -> profile::applications::desktop::ubuntu::unity::launcher { 'sqldeveloper':
    displayedName => 'Sqldeveloper',
    comment       => "Oracle SQL Developer",
    exec          => "/opt/sqldeveloper/sqldeveloper.sh",
    icon          => "/opt/sqldeveloper/icon.png"
  }
}