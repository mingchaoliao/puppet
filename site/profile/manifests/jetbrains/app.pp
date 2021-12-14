define profile::jetbrains::app(
  Enum['present', 'absent'] $ensure,
  String $applicationName = $title
) {
  package {$applicationName:
    provider => snap,
    ensure => $ensure,
  }
}
