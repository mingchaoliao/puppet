class profile::jetbrains(
  $apps = lookup('profile::jetbrains::merged_apps', Hash, 'deep', {})
) {
  create_resources('profile::jetbrains::app', $apps)

  sysctl {'fs.inotify.max_user_watches':
    ensure => $apps.length > 0 ? {true => 'present', default => 'absent'},
    value => 524288,
    comment => 'increase inotify for jetbran IDEs'
  }
}
