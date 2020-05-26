class profile::applications::jetbrains (
  $apps = lookup('profile::applications::jetbrains::apps', Hash, 'deeper', {})
) {
  create_resources('profile::applications::jetbrains::app', $apps)
}