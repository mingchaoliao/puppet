define profile::applications::jetbrains (
  $applicationName = $title,
  $url,
  $extractedDirectoryName,
  $displayedName
) {
  if($applicationName == undef or $url == undef or $extractedDirectoryName == undef) {
    fail("applicationName, url or extractedDirectoryName must be specified")
  }

  $archivePath = "/tmp/puppet/tmp/${applicationName}.tar.gz"
  $extractPath = '/opt'
  $extractedDirectoryPath = "${extractPath}/${extractedDirectoryName}"
  $applicationPath = "${extractPath}/${applicationName}"
  $unityLauncherDesktopFilePath = "/usr/share/applications/${applicationName}.desktop"

  archive { $archivePath:
    source       => $url,
    extract      => true,
    extract_path => $extractPath,
    creates      => "${applicationPath}"
  }
  -> exec { "/bin/mv ${extractedDirectoryPath} ${applicationPath}": }
  -> profile::applications::desktop::ubuntu::unity::launcher { $applicationName:
    displayedName => $displayedName,
    comment       => "${displayedName} Application",
    exec          => "${applicationPath}/bin/${applicationName}.sh",
    icon          => "${applicationPath}/bin/${applicationName}.png"
  }
  -> file { $archivePath:
    ensure => absent
  }
}