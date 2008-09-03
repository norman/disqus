require 'test/unit'
require 'disqus'
require 'disqus/view_helpers'

class ViewHelpersTest < Test::Unit::TestCase
  
  include Disqus::ViewHelpers
  
  def setup
    Disqus::defaults[:account] = "tests"
  end

  def test_disqus_thread
    assert disqus_thread
  end
  
  def test_disqus_comment_counts
    assert disqus_comment_counts
  end
  
  def test_disqus_top_commenters
    assert disqus_top_commenters
  end
  
  def test_disqus_popular_threads
    assert disqus_popular_threads
  end
  
  def test_disqus_recent_comments
    assert disqus_recent_comments
  end
  
  def test_disqus_combo
    assert disqus_combo
  end
  
end