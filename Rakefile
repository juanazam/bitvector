require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:spec) do |t|
  t.pattern = "spec/**/*_spec.rb"
  t.verbose = true
end

task :default => :spec
task :test    => :spec
