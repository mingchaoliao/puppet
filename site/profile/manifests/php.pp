class profile::php () {
  class { '::php::globals':
    php_version => '7.1',
  } -> class { '::php':
    ensure         => present,
    package_prefix => 'php7.1-',
    manage_repos   => true,
    fpm            => false,
    dev            => true,
    composer       => true,
    pear           => true,
    phpunit        => true,
    settings       => {
      'Date/date.timezone'      => 'America/New_York',
      'PHP/max_execution_time'  => '90',
      'PHP/max_input_time'      => '300',
      'PHP/memory_limit'        => '64M',
      'PHP/post_max_size'       => '32M',
      'PHP/upload_max_filesize' => '32M',
    },
    extensions     => {
      ldap     => {},
      soap     => {},
      xmlrpc   => {},
      mcrypt   => {},
      mbstring => {},
      zip      => {},
      gd       => {},
      yaml     => {},
      mysql    => {
        so_name => 'mysqli'
      },
      xdebug   => {
        ensure   => installed,
        zend => true,
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

  contain '::php'
}