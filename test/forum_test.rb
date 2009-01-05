require File.dirname(__FILE__) + '/test_helper'

class ForumTest < Test::Unit::TestCase
  
  def setup
    require 'disqus'
    Disqus.defaults[:api_key] = DISQUS_TEST["api_key"]
    stub_api_call(:get_forum_api_key).returns("FAKE_FORUM_API_KEY")
  end

  def test_forum_list
    mock_api_call(:get_forum_list)
    list = Disqus::Forum.list
    expected = [create_forum]
    assert_equal 1,  list.size
    assert_equal expected, list
  end

  def test_forum_find
    mock_api_call(:get_forum_list)
    forum = Disqus::Forum.find(1234)
    assert_equal "disqus-test", forum.shortname
  end

  def test_forum_find_bad_id
    mock_api_call(:get_forum_list)
    forum = Disqus::Forum.find(666)
    assert_equal nil, forum
  end

  def test_forum_find_no_forums
    Disqus::Api.expects(:get_forum_list).returns({"succeeded"=>true, "code"=>"", "message" => []}) 
    forum = Disqus::Forum.find(1234)
    assert_equal nil, forum
  end

  def test_key
    mock_api_call(:get_forum_api_key)
    forum = Disqus::Forum.new(1234, "disqus-test", "Disqus Test", "2008-01-03 14:44:07.627492")
    assert_equal "FAKE_FORUM_API_KEY", forum.key
  end
  
  def test_forum_threads
    forum = create_forum
    Disqus::Thread.expects(:list).with(forum).returns([thread = mock()])
    assert_equal [thread], forum.forum_threads
  end
  
  def test_get_thread_by_url
    mock_api_call(:get_thread_by_url)
    forum = create_forum
    thread = forum.get_thread_by_url("http://www.example.com")
    expected = Disqus::Thread.new("7651269", forum, "test_thread", "Test thread", "2008-11-28T01:47", true, "FAKE_URL", nil)
    assert_equal expected, thread
  end
  
  def test_thread_by_identifier
    mock_api_call(:thread_by_identifier)
    forum = create_forum
    thread = forum.thread_by_identifier("FAKE_IDENTIFIER", "")
    expected = Disqus::Thread.new("7651269", forum, "test_thread", "Test thread", "2008-11-28T01:47", true, "FAKE_URL", "FAKE_IDENTIFIER")
    assert_equal expected, thread
  end
  
  def test_update_thread
    Disqus::Api.expects(:update_thread).with({:thread_id => 1234, :forum_api_key => "FAKE_FORUM_API_KEY", :title => 'Title', :slug => "a_slug", :url => "http://www.example.com", :allow_comments => true}).returns({"succeeded" => true})
    forum = create_forum
    forum.update_thread(1234, :title => 'Title', :slug => "a_slug", :url => "http://www.example.com", :allow_comments => true)
  end
end
