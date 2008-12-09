require 'test/unit'
 
module Merb
  class Controller
  end
end
 
class MerbTest < Test::Unit::TestCase
  
  def test_view_helpers_should_be_included
    require 'disqus'
    assert Merb::Controller.new.disqus_thread
  end
  
end