require 'test/unit'

class Rails
end

module ActionView
  class Base
  end
end

class RailsTest < Test::Unit::TestCase
  
  def test_view_helpers_should_be_included
    require 'disqus'
    assert ActionView::Base.new.disqus_thread
  end
  
end