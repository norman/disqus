require File.dirname(__FILE__) + '/test_helper'

class PostTest < Test::Unit::TestCase
  
  def setup
    require 'disqus'
    Disqus.defaults[:api_key] = DISQUS_TEST["api_key"]
  end

  def test_post_list
    mock_api_call(:get_thread_posts)
    list = Disqus::Post.list(create_thread)
    assert_equal 2,  list.size
    assert_equal list.first.message, "This is a mock post"
  end
  
  
end