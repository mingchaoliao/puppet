source ENV['GEM_SOURCE'] || 'https://rubygems.org'

gem 'librarian-puppet', :require => false
if (puppetversion = ENV['PUPPET_GEM_VERSION'])
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', '~> 5.4', :require => false
end
