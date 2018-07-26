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
  gem 'rake', '~> 12.0'
end

group :style do
  gem 'foodcritic'
  gem 'rubocop'
end

group :unit do
  gem 'chef', chef_version unless chef_version.nil?
  gem 'chefspec'
  gem 'should_not'
  gem 'simplecov'
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
