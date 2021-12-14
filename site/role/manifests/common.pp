class role::common {
  contain profile::system::user
  contain profile::applications
  contain profile::oracle::java
  contain profile::sogoupinyin
}
