class profile::baidupcs (
  $ensure = 'present',
  $extractFolderName          = 'BaiduPCS-Go-v3.5.6-linux-amd64',
  $url     = "https://github.com/iikira/BaiduPCS-Go/releases/download/v3.5.6/BaiduPCS-Go-v3.5.6-linux-amd64.zip",
) {
  if($ensure == 'absent') {
    file {"/opt/$extractFolderName":
      ensure => 'absent',
      force => true
    }
    ->file {"/usr/local/bin/baidupcs":
      ensure => 'absent'
    }
  } else {
    archive { "/tmp/puppet/baidupcs.zip":
      source       => $url,
      extract      => true,
      extract_path => '/opt',
      creates      => "/opt/$extractFolderName"
    }
    ->file {"/opt/$extractFolderName/BaiduPCS-Go":
      ensure => 'file',
      mode => '0755'
    }
    ->file {"/usr/local/bin/baidupcs":
      ensure => 'link',
      target => "/opt/$extractFolderName/BaiduPCS-Go"
    }
  }
}
