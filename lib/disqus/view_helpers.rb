# Shortcuts to access the widgets as simple functions as opposed to using
# their full qualified names.
%w[combo comment_counts popular_threads recent_comments thread top_commenters].each do |method|
  eval(<<-EOM)
    def disqus_#{method}(options = {})
      Disqus::Widget.#{method}(options)
    end
  EOM
end