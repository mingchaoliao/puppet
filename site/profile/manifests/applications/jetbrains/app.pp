define profile::applications::jetbrains::app(
  String $ensure          = 'present',
  String $applicationName = $title,
  String $url,
  String $extractedDirectoryName,
  String $displayedName
) {
  if($applicationName == undef or $url == undef or $extractedDirectoryName == undef) {
    fail("applicationName, url or extractedDirectoryName must be specified")
  }

  if $ensure == 'present' {
    archive { "/tmp/puppet/${applicationName}.tar.gz":
      source       => $url,
      extract      => true,
      extract_path => '/opt',
      creates      => "/opt/$extractedDirectoryName"
    }
    -> profile::applications::desktop::ubuntu::unity::launcher { $applicationName:
      displayedName => $displayedName,
      comment       => "${displayedName} Application",
      exec          => "/opt/$extractedDirectoryName/bin/${applicationName}.sh",
      icon          => "/opt/$extractedDirectoryName/bin/${applicationName}.png"
    }
  } elsif $ensure == 'absent' {
    file { "/opt/$extractedDirectoryName":
      ensure  => 'absent',
      recurse => true
    }
    profile::applications::desktop::ubuntu::unity::launcher { $applicationName:
      ensure => 'absent'
    }
  } else {
    fail("Unsupported ensure value: $ensure")
  }
}