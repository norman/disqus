class DisqusWidgetTest < Test::Unit::TestCase
  
  def setup
    Disqus::defaults[:account] = "tests"
  end

  def test_thread
    assert disqus_thread
  end

  def test_comment_counts
    assert disqus_comment_counts
  end
  
  def test_combo
    assert disqus_combo
  end

  def test_recent_comments
    assert disqus_recent_comments
  end

  def test_popular_threads
    assert disqus_popular_threads
  end

  def test_top_commenters
    assert disqus_top_commenters
  end

  def test_invalid_default_tab
    assert_raises ArgumentError do
      disqus_combo(:default_tab => "test")
    end
  end

  def test_invalid_color
    assert_raises ArgumentError do
      disqus_combo(:color => "test")
    end
  end

  def test_invalid_num_items
    assert_raises ArgumentError do
      disqus_combo(:num_items => 100)
    end
  end

  def test_invalid_avatar_size
    assert_raises ArgumentError do
      disqus_top_commenters(:avatar_size => 100)
    end
  end

end