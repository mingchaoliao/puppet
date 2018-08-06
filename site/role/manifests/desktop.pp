class role::desktop {
  contain '::profile::applications::chrome'
  contain '::profile::applications::slack'

  contain '::profile::applications::oracle::virtualbox'
  contain '::profile::applications::oracle::sqldeveloper'
  contain '::profile::applications::jetbrains::phpstorm'
  contain '::profile::applications::jetbrains::webstorm'
  contain '::profile::applications::jetbrains::rubymine'
}