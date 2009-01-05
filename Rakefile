require 'newgem'
require 'lib/disqus/version'

$hoe = Hoe.new("disqus", Disqus::Version::STRING) do |p|
  p.rubyforge_name = "disqus"
  p.author = ['Norman Clarke', 'Matthew Van Horn']
  p.email = ['norman@randomba.org', 'mattvanhorn@gmail.com']
  p.summary = "Integrates Disqus commenting system into your Ruby-powered site."
  p.description = 'Integrates Disqus into your Ruby-powered site. Works with any Ruby website, and has view helpers for Rails and Merb.'
  p.url = 'http://disqus.rubyforge.org'
  p.test_globs = ['test/**/*_test.rb']
  p.extra_deps << ['json']
  p.extra_dev_deps = [
    ['newgem', ">= #{::Newgem::VERSION}"],
    ['mocha']
  ]
  p.rsync_args = '-av --delete --ignore-errors'
  changes = p.paragraphs_of('History.txt', 0..1).join("\n\n")
  p.remote_rdoc_dir = ""
end

require 'newgem/tasks'
Dir['tasks/**/*.rake'].each { |t| load t }