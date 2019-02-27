class role::web {
  contain profile::applications::nodejs
  contain profile::applications::angular_cli
  contain profile::java
  #contain profile::oracle::instantclient
  #contain profile::php
  #contain profile::php::phploc
  #contain profile::php::xdebug_manager
  #contain profile::apache::http
  #contain profile::apache::http::mod_php
  #contain profile::mysql
  #contain profile::mysql::phpmyadmin
}
