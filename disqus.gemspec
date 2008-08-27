Gem::Specification.new do |s|
  s.name = "disqus"
  s.version = "0.1.0"
  s.date = "2008-08-25"
  s.rubyforge_project = 'disqus'  
  s.summary = "Integrate Disqus commenting system into your Ruby-powered site."
  s.email = 'norman@randomba.org'
  s.homepage = 'http://randomba.org'
  s.description = 'Integrate Disqus into your Ruby-powered site. Works with any Ruby website, not just Rails.'
  s.has_rdoc = true
  s.authors = ['Norman Clarke']
  s.files = [
    "MIT-LICENSE",
    "README.textile",
    "README.txt",
    "init.rb",
    "lib/disqus.rb",
    "lib/disqus/widget.rb",
    "lib/disqus/rails_view_helpers.rb",
    "Rakefile",
    ]
  s.test_files = [
    "test/widget_test.rb",
    "test/rails_view_helpers_test.rb"
  ]
  s.rdoc_options = ["--main", "README.txt", "--inline-source", "--line-numbers"]
  s.extra_rdoc_files = ["README.txt"]

end
