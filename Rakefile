# encoding: UTF-8
# -*- mode: ruby -*-
# vi: set ft=ruby :
# Based on magic_shell cookbook code, thanks @sethvargo.

# More info at https://github.com/ruby/rake/blob/master/doc/rakefile.rdoc

require 'bundler/setup'

# Checks if we are inside Travis CI.
#
# @return [Boolean] whether we are inside Travis CI.
# @example
#   travis? #=> false
def travis?
  ENV['TRAVIS'] == 'true'
end

desc 'Generate Ruby documentation using yard'
task :yard do
  require 'yard'
  YARD::Rake::YardocTask.new do |t|
    t.stats_options = %w(--list-undoc)
  end
end

desc 'Generate Ruby documentation'
task doc: %w(yard)

namespace :style do
  require 'rubocop/rake_task'
  desc 'Run Ruby style checks using rubocop'
  RuboCop::RakeTask.new(:ruby)

  require 'foodcritic'
  desc 'Run Chef style checks using foodcritic'
  FoodCritic::Rake::LintTask.new(:chef)
end

desc 'Run all style checks'
task style: %w(style:chef style:ruby)

desc 'Run ChefSpec unit tests'
task :unit do
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.rspec_opts = '--color --format progress'
  end
end

namespace :integration do
  def run_kitchen
    sh "kitchen test #{ENV['KITCHEN_ARGS']} #{ENV['KITCHEN_REGEXP']}"
  end

  desc 'Run Test Kitchen integration tests using vagrant'
  task :vagrant do
    ENV.delete('KITCHEN_LOCAL_YAML')
    run_kitchen
  end

  desc 'Run Test Kitchen integration tests using docker'
  task :docker do
    ENV['KITCHEN_LOCAL_YAML'] = '.kitchen.docker.yml'
    run_kitchen
  end
end

desc 'Run Test Kitchen integration tests'
task integration: travis? ? %w(integration:docker) : %w(integration:vagrant)

desc 'Run doc, style, unit and integration tests'
task default: %w(doc style unit integration)
