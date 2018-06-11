class profile::applications::jetbrains::rubymine {
  profile::applications::jetbrains {'rubymine':
    url => 'https://download-cf.jetbrains.com/ruby/RubyMine-2018.1.3.tar.gz',
    extractedDirectoryName => 'RubyMine-2018.1.3',
    displayedName => 'RubyMine'
  }
}