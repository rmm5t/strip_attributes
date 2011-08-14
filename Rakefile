require "rake/testtask"
require "bundler/gem_tasks"
require "bundler/setup"

desc "Default: run unit tests."
task :default => :test

desc "Test the stripattributes plugin."
Rake::TestTask.new(:test) do |t|
  t.libs << "lib" << "test"
  t.pattern = "test/**/*_test.rb"
  t.verbose = true
end
