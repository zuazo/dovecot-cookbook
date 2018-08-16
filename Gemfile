# More info at http://bundler.io/gemfile.html
#
# Many of the gem versions installed here are based on the versions installed
# by ChefDK.

source 'https://rubygems.org'

chef_version = ENV.key?('CHEF_VERSION') ? ENV['CHEF_VERSION'] : nil

group :doc do
  gem 'yard'
end

group :test do
  gem 'berkshelf', '~> 7.0'
  gem 'rake'
end

group :style do
  gem 'foodcritic', '~> 14.0.0'
  gem 'rubocop', '~> 0.58.0'
end

group :unit do
  gem 'chef', chef_version unless chef_version.nil?
  gem 'chefspec', '= 7.2.1'
  gem 'should_not', '~> 1.1.0'
  gem 'simplecov', '~> 0.16.1'
end

group :integration do
  gem 'test-kitchen'
end

group :integration_docker do
  gem 'kitchen-docker'
end

group :integration_vagrant do
  gem 'kitchen-vagrant'
  gem 'vagrant-wrapper'
end

group :integration_cloud do
  gem 'kitchen-digitalocean', '~> 0.9.5'
  gem 'kitchen-ec2', '~> 1.2'
end

group :guard do
  gem 'guard'
  gem 'guard-foodcritic'
  gem 'guard-kitchen'
  gem 'guard-rspec'
  gem 'guard-rubocop'
end

group :travis do
  gem 'coveralls', require: false
end
