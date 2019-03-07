class profile::applications::jetbrains (
  $apps = lookup('profile::applications::jetbrains::apps', Hash, 'deep', {})
) {
  create_resources('profile::applications::jetbrains::app', $apps)
}