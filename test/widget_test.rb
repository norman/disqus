require 'test/unit'
require 'disqus'

class DisqusWidgetTest < Test::Unit::TestCase
  
  def setup
    Disqus::defaults[:account] = "tests"
  end

  def test_thread
    assert Disqus::Widget::thread
  end

  def test_comment_counts
    assert Disqus::Widget::comment_counts
  end
  
  def test_combo
    assert Disqus::Widget::combo
  end

  def test_recent_comments
    assert Disqus::Widget::recent_comments
  end

  def test_popular_threads
    assert Disqus::Widget::popular_threads
  end

  def test_top_commenters
    assert Disqus::Widget::top_commenters
  end

  def test_invalid_default_tab
    assert_raises ArgumentError do
      Disqus::Widget::combo(:default_tab => "test")
    end
  end

  def test_invalid_color
    assert_raises ArgumentError do
      Disqus::Widget::combo(:color => "test")
    end
  end

  def test_invalid_num_items
    assert_raises ArgumentError do
      Disqus::Widget::combo(:num_items => 100)
    end
  end

  def test_invalid_avatar_size
    assert_raises ArgumentError do
      Disqus::Widget::top_commenters(:avatar_size => 100)
    end
  end

end