require 'test/unit'
require 'yaml'
require 'disqus'
require 'disqus/api'
require 'disqus/forum'
require 'disqus/thread'
require 'mocha'

DISQUS_TEST = YAML.load(File.read(File.dirname(__FILE__) + "/config.yml"))

class ThreadTest < Test::Unit::TestCase
  
  def setup
    Disqus.defaults[:api_key] = DISQUS_TEST["api_key"]
  end

  def test_thread_list
    mock_api_call(:get_thread_list)
    forum = create_forum
    list = Disqus::Thread.list(forum)
    assert_equal 1,  list.size
    assert_equal list, [create_thread]
  end

  private
  
  def create_thread
    Disqus::Thread.new( 12345, 
                        create_forum, 
                        "this_is_a_thread", 
                        "This is a thread", 
                        "2008-01-03 14:44:07.627492", 
                        true,
                        "http://www.example.com/testthread",
                        "this_is_the_thread_identifier" )
  end
  
  def create_forum
    Disqus::Forum.new(1234, "disqus-test", "Disqus Test", "2008-01-03 14:44:07.627492")
  end
  
  def mock_api_call(method_name)
    Disqus::Api.expects(method_name.to_sym).returns(JSON.parse(File.read(File.dirname(__FILE__) + "/responses/#{method_name}.json"))) 
  end
  
  
end

