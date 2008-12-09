require File.dirname(__FILE__) + '/test_helper'

class ThreadTest < Test::Unit::TestCase
  
  def setup
    require 'disqus'
    Disqus.defaults[:api_key] = DISQUS_TEST["api_key"]
    stub_api_call(:get_forum_api_key)
  end

  def test_thread_list
    mock_api_call(:get_thread_list)
    forum = create_forum
    list = Disqus::Thread.list(forum)
    assert_equal 1,  list.size
    assert_equal list, [Disqus::Thread.new( 12345, 
                        create_forum, 
                        "this_is_a_thread", 
                        "This is a thread", 
                        "2008-01-03 14:44:07.627492", 
                        true,
                        "http://www.example.com/testthread",
                        "this_is_the_thread_identifier" )]
  end

end


