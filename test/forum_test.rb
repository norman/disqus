require 'test/unit'
require 'yaml'
require 'disqus'
require 'disqus/api'
require 'disqus/forum'
require 'mocha'

DISQUS_TEST = YAML.load(File.read(File.dirname(__FILE__) + "/config.yml"))

class ForumTest < Test::Unit::TestCase
  
  def setup
    Disqus.defaults[:api_key] = DISQUS_TEST["api_key"]
  end

  def test_forum_list
    mock_api_call(:get_forum_list)
    list = Disqus::Forum.list
    assert_equal 1,  list.size
    assert_equal list, [create_forum]
  end

  def test_forum_find
    mock_api_call(:get_forum_list)
    forum = Disqus::Forum.find(1234)
    assert_equal "disqus-test", forum.shortname
  end

  def test_load_key
    mock_api_call(:get_forum_api_key)
    forum = create_forum
    assert_equal "FAKE_FORUM_API_KEY", forum.load_key
  end
  
  
  private
  
  def create_forum
    Disqus::Forum.new(1234, "disqus-test", "Disqus Test", "2008-01-03 14:44:07.627492")
  end
  
  def mock_api_call(method_name)
    Disqus::Api.expects(method_name.to_sym).returns(JSON.parse(File.read(File.dirname(__FILE__) + "/responses/#{method_name}.json"))) 
  end
  
  
end

