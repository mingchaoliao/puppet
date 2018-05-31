# role/oracle/banner.pp
# All Banner servers
#

class profile::oracle {
  contain '::profile::java'
  contain '::profile::oracle::client'
  contain '::profile::oracle::instantclient'
}
