require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Run unit tests.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc "Build gem"
task :gem do
  sh "gem build disqus.gemspec"
end

desc "Run rcov"
task :rcov do
  rm_f "coverage"
  rm_f "coverage.data"
  if PLATFORM =~ /darwin/
    exclude = '--exclude "gems"'
  else
    exclude = '--exclude "rubygems"'
  end
  rcov = "rcov --rails -Ilib:test --sort coverage --text-report #{exclude} --no-validator-links"
  cmd = "#{rcov} #{Dir["test/**/*.rb"].join(" ")}"
  sh cmd
end

desc 'Generate rdocs.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = 'Disqus'
  rdoc.main = "README.rdoc"
  rdoc.options << '--line-numbers' << '--inline-source' << '-c UTF-8'
  rdoc.rdoc_files.include('lib/**/*.rb')
  rdoc.rdoc_files.include('README.rdoc')
end