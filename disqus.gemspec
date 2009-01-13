# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{disqus}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Norman Clarke", "Matthew Van Horn"]
  s.date = %q{2009-01-12}
  s.description = %q{Integrates Disqus into your Ruby-powered site. Works with any Ruby website, and has view helpers for Rails and Merb.}
  s.email = ["norman@randomba.org", "mattvanhorn@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.rdoc"]
  s.files = ["History.txt", "MIT-LICENSE", "Manifest.txt", "README.rdoc", "Rakefile", "config/website.yml", "disqus.gemspec", "init.rb", "lib/disqus.rb", "lib/disqus/api.rb", "lib/disqus/author.rb", "lib/disqus/forum.rb", "lib/disqus/post.rb", "lib/disqus/thread.rb", "lib/disqus/version.rb", "lib/disqus/view_helpers.rb", "lib/disqus/widget.rb", "tasks/rcov.rake", "test/api_test.rb", "test/config.yml.sample", "test/forum_test.rb", "test/merb_test.rb", "test/post_test.rb", "test/rails_test.rb", "test/responses/bad_api_key.json", "test/responses/create_post.json", "test/responses/get_forum_api_key.json", "test/responses/get_forum_list.json", "test/responses/get_num_posts.json", "test/responses/get_thread_by_url.json", "test/responses/get_thread_list.json", "test/responses/get_thread_posts.json", "test/responses/thread_by_identifier.json", "test/responses/update_thread.json", "test/test_helper.rb", "test/thread_test.rb", "test/view_helpers_test.rb", "test/widget_test.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://disqus.rubyforge.org}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{disqus}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Integrates Disqus commenting system into your Ruby-powered site.}
  s.test_files = ["test/rails_test.rb", "test/view_helpers_test.rb", "test/thread_test.rb", "test/post_test.rb", "test/api_test.rb", "test/widget_test.rb", "test/forum_test.rb", "test/merb_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_development_dependency(%q<newgem>, [">= 1.2.3"])
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<newgem>, [">= 1.2.3"])
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<newgem>, [">= 1.2.3"])
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
