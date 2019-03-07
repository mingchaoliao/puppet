class role::desktop {
  contain profile::applications::chrome
  contain profile::applications::slack

  contain profile::applications::oracle::virtualbox
  contain profile::applications::oracle::sqldeveloper
  contain profile::applications::jetbrains
}