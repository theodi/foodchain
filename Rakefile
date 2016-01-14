$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'foodchain'

namespace :inspections do
  task :import_all do
    if ENV['wallet']
      Foodchain::Inspections::Import.all(ENV['wallet'])
    else
      puts "Please specify a wallet ID"
    end
  end
end

RSpec::Core::RakeTask.new(:spec)
task :default => [:spec]
