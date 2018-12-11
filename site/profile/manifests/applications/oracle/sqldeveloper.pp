class profile::applications::oracle::sqldeveloper (
  $ensure        = 'present',
  $source          = 'puppet:///files/sqldeveloper-18.1.0.095.1630-no-jre.zip',
  $extractFolder = 'sqldeveloper'
) {
  if $ensure == 'present' {
    archive { '/tmp/puppet/sqldeveloper.zip':
      extract      => true,
      extract_path => "/opt",
      source       => $source,
      creates      => "/opt/$extractFolder/sqldeveloper.sh"
    }
    -> file { "/opt/$extractFolder/sqldeveloper.sh":
      ensure => 'file',
      mode    => '0755'
    }
    -> profile::applications::desktop::ubuntu::unity::launcher { 'sqldeveloper':
      displayedName => 'Sqldeveloper',
      comment       => "Oracle SQL Developer",
      exec          => "/opt/sqldeveloper/sqldeveloper.sh",
      icon          => "/opt/sqldeveloper/icon.png"
    }
  } elsif $ensure == 'absent' {
    file { "/opt/$extractFolder":
      ensure  => 'absent',
      recurse => true
    }

    profile::applications::desktop::ubuntu::unity::launcher { 'sqldeveloper':
      ensure        => 'absent',
      displayedName => 'Sqldeveloper',
      comment       => "Oracle SQL Developer",
      exec          => "/opt/sqldeveloper/sqldeveloper.sh",
      icon          => "/opt/sqldeveloper/icon.png"
    }
  } else {
    fail("Unsupported ensure value: $ensure")
  }
}