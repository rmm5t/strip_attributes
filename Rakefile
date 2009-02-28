require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the stripattributes plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the stripattributes plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Stripattributes'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

desc 'Publishes rdoc to rubyforge server'
task :publish_rdoc => :rdoc do
  cmd = "scp -r rdoc/* rmm5t@rubyforge.org:/var/www/gforge-projects/stripattributes"
  puts "\nPublishing rdoc: #{cmd}\n\n"
  system(cmd)
end

