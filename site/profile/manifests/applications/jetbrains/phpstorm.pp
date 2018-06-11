class profile::applications::jetbrains::phpstorm {
  profile::applications::jetbrains {'phpstorm':
    url => 'https://download-cf.jetbrains.com/webide/PhpStorm-2018.1.5.tar.gz',
    extractedDirectoryName => 'PhpStorm-181.5281.19',
    displayedName => 'PhpStorm'
  }
}