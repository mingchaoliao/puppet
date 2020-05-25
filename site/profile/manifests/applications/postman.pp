class profile::applications::postman (
  String $ensure = 'present',
  String $source = 'https://dl.pstmn.io/download/latest/linux64'
) {
  $release = Float($facts['os']['release']['major'])

  if $facts['os']['name'] == 'Ubuntu' and $release >= 18 {
    package {'postman':
      ensure => $ensure,
      provider => snap
    }
  } else {
    if($ensure == 'absent') {
      file { '/opt/Postman':
        ensure => 'absent'
      }
      profile::applications::desktop::ubuntu::unity::launcher { 'postman':
        ensure => 'absent'
      }
    } else {
      archive { "/tmp/puppet/postman.tar.gz":
        source       => $source,
        extract      => true,
        extract_path => '/opt',
        creates      => "/opt/Postman"
      }
      -> profile::applications::desktop::ubuntu::unity::launcher { 'postman':
        displayedName => 'Postman',
        comment       => "Postman Application",
        exec          => "/opt/Postman/Postman",
        icon          => "/opt/Postman/app/resources/app/assets/icon.png"
      }
    }
  }
}