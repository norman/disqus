Gem::Specification.new do |s|
  s.name = "disqus-api"
  s.version = "0.1.1"
  s.date = "2008-09-03"
  s.rubyforge_project = 'disqus-api'  
  s.summary = "Integrates Disqus commenting system into your Ruby-powered site."
  s.email = 'norman@randomba.org'
  s.homepage = 'http://randomba.org'
  s.description = 'Integrates Disqus into your Ruby-powered site. Works with any Ruby website, and has view helpers for Rails and Merb.'
  s.has_rdoc = true
  s.authors = ['Norman Clarke','Matt Van Horn']
  s.files = [
    "MIT-LICENSE",
    "README.textile",
    "init.rb",
    "lib/disqus.rb",
    "lib/disqus/api.rb",
    "lib/disqus/author.rb",
    "lib/disqus/forum.rb",
    "lib/disqus/post.rb",
    "lib/disqus/thread.rb",
    "lib/disqus/view_helpers.rb",
    "lib/disqus/widget.rb"
    "Rakefile",
    ]
  s.test_files = [
    
    "test/api_test.rb",
    "test/forum_test.rb",
    "test/thread_test.rb",
    "test/view_helpers_test.rb",
    "test/widget_test.rb",
  ]
  s.rdoc_options = ["--main", "README.textile", "--inline-source", "--line-numbers"]
  s.extra_rdoc_files = ["README.textile"]
end
