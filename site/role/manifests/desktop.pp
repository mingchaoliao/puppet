class role::desktop {
  contain profile::applications::chrome
  contain profile::applications::slack

  contain profile::applications::oracle::virtualbox
  contain profile::applications::oracle::sqldeveloper
  contain profile::applications::jetbrains
  contain profile::minikube
  contain profile::applications::postman
}