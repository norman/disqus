require 'test/unit'
require 'yaml'
require 'disqus/api'
require 'disqus/forum'
require 'disqus/thread'
require 'disqus/post'
require 'disqus/author'
require 'mocha'

DISQUS_TEST = YAML.load(File.read(File.dirname(__FILE__) + "/config.yml"))

def create_forum 
  forum = Disqus::Forum.new(1234, "disqus-test", "Disqus Test", "2008-01-03 14:44:07.627492")
  forum.stubs(:key).returns("FAKE_FORUM_API_KEY")
  forum
end

def create_thread
  mock_forum = mock()
  mock_forum.stubs(:key).returns("FAKE_FORUM_API_KEY")
  Disqus::Thread.new("7651269", mock_forum, "test_thread", "Test thread", "2008-11-28T01:47", true, "FAKE_URL", nil)
end


def mock_api_call(method_name)
  Disqus::Api.expects(method_name.to_sym).returns(JSON.parse(File.read(File.dirname(__FILE__) + "/responses/#{method_name}.json"))) 
end

def stub_api_call(method_name)
  Disqus::Api.stubs(method_name.to_sym).returns(JSON.parse(File.read(File.dirname(__FILE__) + "/responses/#{method_name}.json"))) 
end

