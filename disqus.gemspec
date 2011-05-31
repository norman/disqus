require 'lib/disqus/version'

spec = Gem::Specification.new do |s|

  s.name              = "disqus"
  s.version           = Disqus::Version::STRING
  s.rubyforge_project = "disqus"
  s.authors           = ['Norman Clarke', 'Matthew Van Horn']
  s.email             = ['norman@njclarke.com', 'mattvanhorn@gmail.com']
  s.summary           = "Integrates Disqus commenting system into your Ruby-powered site."
  s.description       = 'Integrates Disqus into your Ruby-powered site. Works with any Ruby website, and has view helpers for Rails and Merb.'
  s.homepage          = 'http://github.com/norman/disqus'
  s.platform          = Gem::Platform::RUBY

  s.files             = Dir["lib/**/*.rb", "lib/**/*.rake", "*.rdoc", "LICENSE", "Rakefile", "test/**/*.*"]
  s.test_files        = Dir.glob "test/**/*_test.rb"

  s.add_dependency 'json'
  s.add_development_dependency 'mocha'

end
