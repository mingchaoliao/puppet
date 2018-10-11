class profile::applications::jetbrains::intellij {
  profile::applications::jetbrains { 'intellij':
    url                    => 'https://download-cf.jetbrains.com/idea/ideaIU-2018.2.4.tar.gz',
    extractedDirectoryName => 'idea-IU-182.4505.22',
    displayedName          => 'IntelliJ IDEA'
    }
  }