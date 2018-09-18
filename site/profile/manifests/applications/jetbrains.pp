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
  $extractPath = '/tmp/puppet/tmp'
  $extractedDirectoryPath = "${extractPath}/${extractedDirectoryName}"
  $applicationPath = "/opt/${applicationName}"
  $unityLauncherDesktopFilePath = "/usr/share/applications/${applicationName}.desktop"

  archive { $archivePath:
    source       => $url,
    extract      => true,
    extract_path => $extractPath,
    creates      => "${extractedDirectoryPath}"
  }
  -> file { "${applicationPath}":
    recurse => true,
    source  => "${extractedDirectoryPath}"
  }
  -> profile::applications::desktop::ubuntu::unity::launcher { $applicationName:
    displayedName => $displayedName,
    comment       => "${displayedName} Application",
    exec          => "${applicationPath}/bin/${applicationName}.sh",
    icon          => "${applicationPath}/bin/${applicationName}.png"
  }
}