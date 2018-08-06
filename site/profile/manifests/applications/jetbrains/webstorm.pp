class profile::applications::jetbrains::webstorm {
  profile::applications::jetbrains { 'webstorm':
    url                    => 'https://download-cf.jetbrains.com/webstorm/WebStorm-2018.1.4.tar.gz',
    extractedDirectoryName => 'WebStorm-181.5087.27',
    displayedName          => 'WebStorm'
  }
}