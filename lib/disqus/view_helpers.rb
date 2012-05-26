# Shortcuts to access the widgets as simple functions as opposed to using
# their full qualified names.
%w[combo comment_counts popular_threads recent_comments thread top_commenters sso_login sso_logout].each do |method|
  eval(<<-EOM)
    def disqus_#{method}(options = {})
      Disqus::Widget.#{method}(options)
    end
  EOM
end
