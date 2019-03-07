class profile::applications::postman (
  String $ensure = 'present',
  String $source = 'https://dl.pstmn.io/download/latest/linux64'
) {
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