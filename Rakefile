require 'bundler'
Bundler::GemHelper.install_tasks
require "rake/testtask"
require "rake/gempackagetask"
require "rake/rdoctask"
require "rake/clean"

CLEAN << "pkg" << "doc" << "coverage"

Rake::GemPackageTask.new(eval(File.read("disqus.gemspec"))) { |pkg| }
Rake::TestTask.new(:test) { |t| t.pattern = "test/*_test.rb" }

Rake::RDocTask.new do |r|
  r.rdoc_dir = "doc"
  r.rdoc_files.include "lib/**/*.rb"
end

begin
  require "rcov/rcovtask"
  Rcov::RcovTask.new do |r|
    r.test_files = FileList["test/**/*_test.rb"]
    r.verbose = true
    r.rcov_opts << "--exclude gems/*"
  end
rescue LoadError
end
