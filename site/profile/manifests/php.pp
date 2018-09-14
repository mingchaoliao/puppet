class profile::php (
  $phploc = true,
  $ensure = present
) {
  class { '::php':
    ensure       => $ensure,
    manage_repos => true,
    fpm          => false,
    dev          => true,
    composer     => true,
    pear         => true,
    phpunit      => true,
    settings     => {
      'Date/date.timezone'      => 'America/New_York',
      'PHP/max_execution_time'  => '90',
      'PHP/max_input_time'      => '300',
      'PHP/memory_limit'        => '64M',
      'PHP/post_max_size'       => '32M',
      'PHP/upload_max_filesize' => '32M',
    },
    extensions   => {
      ldap     => {
        ensure => $ensure ? {
          absent => absent,
          default => present
        }
      },
      soap     => {
        ensure => $ensure ? {
          absent => absent,
          default => present
        }
      },
      xmlrpc   => {
        ensure => $ensure ? {
          absent => absent,
          default => present
        }
      },
      mcrypt   => {
        ensure => $ensure ? {
          absent => absent,
          default => present
        }
      },
      mbstring => {
        ensure => $ensure ? {
          absent => absent,
          default => present
        }
      },
      zip      => {
        ensure => $ensure ? {
          absent => absent,
          default => present
        }
      },
      gd       => {
        ensure => $ensure ? {
          absent => absent,
          default => present
        }
      },
      soap     => {
        ensure => $ensure ? {
          absent => absent,
          default => present
        }
      },
      imap     => {
        ensure => $ensure ? {
          absent => absent,
          default => present
        }
      },
      yaml     => {
        ensure => $ensure ? {
          absent => absent,
          default => present
        }
      },
      curl     => {
        ensure => $ensure ? {
          absent => absent,
          default => present
        }
      },
      ssh2     => {
        ensure => $ensure ? {
          absent => absent,
          default => present
        }
      },
      oci8     => {
        provider => pecl,
        ensure => $ensure ? {
          absent => absent,
          default => present
        }

      },
      mysql    => {
        so_name => 'mysqli',
        ensure => $ensure ? {
          absent => absent,
          default => present
        }
      },
      xdebug   => {
        ensure => $ensure ? {
          absent => absent,
          default => present
        }
        ,
        zend     => true,
        settings => {
          'xdebug.remote_enable'           => 1,
          'xdebug.idekey'                  => 'phpstorm-xdebug',
          'xdebug.profiler_enable'         => 0,
          'xdebug.profiler_enable_trigger' => 1,
          'xdebug.profiler_output_dir'     => '/tmp/xdebug_profiles/web'
        }
      }
    }
  }

  contain profile::oracle::instantclient
  contain '::php'

  file { '/usr/local/bin/phploc':
    ensure => $ensure ? {
      absent => absent,
      default => file
    },
    source  => 'https://phar.phpunit.de/phploc.phar',
    mode    => '0755',
    require => Class['::php']
  }

  file { '/usr/local/bin/xdebug':
    ensure => $ensure ? {
      absent => absent,
      default => file
    },
    content => file('profile/commands/xdebug.sh'),
    owner   => 'root',
    group   => 'root',
    mode    => '4755',
    require => Class['::php']
  }
}