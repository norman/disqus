module Disqus

  # Shortcuts to access the widgets as simple functions as opposed to using
  # their full qualified names. These helpers are loaded automatically in
  # Rails and Merb apps. 
  #
  # For Sinatra, Camping, Nitro or other frameworks, you can include the
  # helper if you wish, or use the fully-qualified names. Really this is just
  # here for aesthetic purposes and to make it less likely to step on anyone's
  # namespace.
  module ViewHelpers
    
    # See Disqus::Widget.thread
    def disqus_thread(options = {})
      Disqus::Widget::thread(options)
    end
    
    # See Disqus::Widget.comment_counts
    def disqus_comment_counts(options = {})
      Disqus::Widget::comment_counts(options)
    end
    
    # See Disqus::Widget.top_commenters
    def disqus_top_commenters(options = {})
      Disqus::Widget::top_commenters(options)
    end
    
    # See Disqus::Widget.popular_threads
    def disqus_popular_threads(options = {})
      Disqus::Widget::popular_threads(options)
    end
    
    # See Disqus::Widget.recent_comments
    def disqus_recent_comments(options = {})
      Disqus::Widget::recent_comments(options)
    end
    
    # See Disqus::Widget.combo
    def disqus_combo(options = {})
      Disqus::Widget::combo(options)
    end
    
  end

end