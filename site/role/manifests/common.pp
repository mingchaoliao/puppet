class role::common {
  contain git
  contain profile::user
  contain profile::java
  contain profile::applications::onepassword_cli
}