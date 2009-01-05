require File.dirname(__FILE__) + '/test_helper'

class ApiTest < Test::Unit::TestCase
  
  def setup
    require 'disqus'
    Disqus.defaults[:api_key] = DISQUS_TEST["api_key"]
  end
  
  def test_create_post
    mock_post_response('create_post.json')
    the_post = Disqus::Api::create_post()
    assert_equal "This is a mock post", the_post["message"]["message"]
  end
  
  def test_get_forum_list
    mock_get_response('get_forum_list.json')
    forum_list = Disqus::Api::get_forum_list
    assert_equal "Disqus Test", forum_list["message"][0]["name"]
  end
  
  def test_get_forum_api_key
    mock_get_response('get_forum_api_key.json')
    forum_api_key = Disqus::Api::get_forum_api_key(:forum_id => 1234, :user_api_key=>"FAKE_KEY")
    assert_equal "FAKE_FORUM_API_KEY", forum_api_key["message"]
  end
  
  def test_get_thread_list
    mock_get_response('get_thread_list.json')
    thread_list = Disqus::Api::get_thread_list(:forum_api_key=>"FAKE_KEY")
    assert_equal "this_is_the_thread_identifier", thread_list["message"].first["identifier"]
  end
  
  def test_get_num_posts
    mock_get_response('get_num_posts.json')
    nums = Disqus::Api::get_num_posts(:thread_ids => [123,456], :forum_api_key=>"FAKE_KEY")
    assert_equal [10,12], nums["message"][nums["message"].keys.first]
  end
  
  def test_get_thread_by_url
    mock_get_response('get_thread_by_url.json')
    thread = Disqus::Api::get_thread_by_url(:url => "FAKE_URL", :forum_api_key=>"FAKE_KEY")
    assert_equal "test_thread", thread["message"]["slug"]
  end
  
  def test_get_thread_posts
    mock_get_response('get_thread_posts.json')
    thread_posts = Disqus::Api::get_thread_posts(:thread_id =>1234, :forum_api_key => "FAKE_KEY")
    assert_equal "This is a mock post", thread_posts["message"].first["message"]
  end
  
  def test_thread_by_identifier
    mock_post_response('thread_by_identifier.json')
    thread = Disqus::Api::thread_by_identifier(:identifier =>'foo_bar', :title => "Foo Bar", :forum_api_key => "FAKE_KEY")
    assert_equal "Test thread", thread["message"]["thread"]["title"]
  end
  
  def test_update_thread
    mock_post_response('update_thread.json')
    result = Disqus::Api::thread_by_identifier(:thread_id =>123, :title => "Foo Bar", :forum_api_key => "FAKE_KEY")
    assert result["succeeded"]
  end
  
  def test_comment_form
    c = Disqus::Api::comment_form("myforum", "mythread")
    assert_match(/myforum/, c)
    assert_match(/mythread/, c)
  end
  
  private
  
  def mock_get_response(file)
    Disqus::Api.expects(:get).returns(File.read(File.dirname(__FILE__) + "/responses/#{file}"))  
  end
  
  def mock_post_response(file)
    Disqus::Api.expects(:post).returns(File.read(File.dirname(__FILE__) + "/responses/#{file}"))  
  end

end