module Disqus

  module RailsViewHelpers
    
    def disqus_thread(options = {})
      Disqus::Widget::thread(options)
    end
    
    def disqus_comment_counts(options = {})
      Disqus::Widget::comment_counts(options)
    end
    
    def disqus_top_commenters(options = {})
      Disqus::Widget::top_commenters(options)
    end
    
    def disqus_popular_threads(options = {})
      Disqus::Widget::popular_threads(options)
    end
    
    def disqus_recent_comments(options = {})
      Disqus::Widget::recent_comments(options)
    end
    
    def disqus_combo(options = {})
      Disqus::Widget::combo(options)
    end
    
  end

end