require "bundler/gem_tasks"
require "rake/testtask"

desc 'Run tests'
Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/*_test.rb'
  t.verbose = true
end

task default: :test

