require 'test/unit'
require 'yaml'
require 'disqus'
require 'disqus/api'
require 'disqus/forum'
require 'disqus/thread'
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
  
  def test_load_threads
    forum = create_forum
    Disqus::Thread.expects(:list).with(forum).returns([thread = mock()])
    forum.load_threads
    assert_equal [thread], forum.threads
  end
  
  def test_get_thread_by_url
    mock_api_call(:get_thread_by_url)
    forum = create_forum
    thread = forum.get_thread_by_url("http://www.example.com")
    expected = Disqus::Thread.new("7651269", forum, "test_thread", "Test thread", "2008-11-28T01:47", true, "FAKE_URL", nil)
    assert_equal expected, thread
  end
  
  def test_get_thread_by_identifier
    mock_api_call(:thread_by_identifier)
    forum = create_forum
    thread = forum.get_thread_by_identifier("FAKE_IDENTIFIER", "")
    expected = Disqus::Thread.new("7651269", forum, "test_thread", "Test thread", "2008-11-28T01:47", true, "FAKE_URL", "FAKE_IDENTIFIER")
    assert_equal expected, thread
  end
  

  
  
  private
  
  def create_forum 
    Disqus::Forum.new(1234, "disqus-test", "Disqus Test", "2008-01-03 14:44:07.627492")
  end
  
  def create_thread
    Disqus::Thread.new("7651269", forum, "test_thread", "Test thread", "2008-11-28T01:47", true, "FAKE_URL", nil)
  end
  
  def mock_api_call(method_name)
    Disqus::Api.expects(method_name.to_sym).returns(JSON.parse(File.read(File.dirname(__FILE__) + "/responses/#{method_name}.json"))) 
  end
  
  
end

