module Disqus

  # Disqus Widget generator.
  #
  # All of the methods accept various options, and "account" is required for
  # all of them. You can avoid having to pass in the account each time by
  # setting it in the defaults like this:
  #
  #  Disqus::defaults[:account] = "my_account"
  class Widget
  
    VALID_COLORS = ['blue', 'grey', 'green', 'red', 'orange']
    VALID_NUM_ITEMS = 5..20
    VALID_DEFAULT_TABS = ['people', 'recent', 'popular']
    VALID_AVATAR_SIZES = [24, 32, 48, 92, 128]
    VALID_ORIENTATIONS = ['horizontal', 'vertical']

    ROOT_PATH = 'http://disqus.com/forums/%s/'
    THREAD = ROOT_PATH + 'embed.js'
    COMBO = ROOT_PATH + 'combination_widget.js?num_items=%d&color=%s&default_tab=%s'
    RECENT = ROOT_PATH + 'recent_comments_widget.js?num_items=%d&avatar_size=%d'
    POPULAR = ROOT_PATH + 'popular_threads_widget.js?num_items=%d'
    TOP = ROOT_PATH + 'top_commenters_widget.js?num_items=%d&avatar_size=%d&orientation=%s'
    class << self
      
      # Show the main Disqus thread widget.
      # Options:
      # * <tt>account:</tt> Your Discus account (required).
      def thread(opts = {})
        opts = Disqus::defaults.merge(opts)
        opts[:view_thread_text] ||= "View the discussion thread"
        validate_opts!(opts)
        s = ''
        if opts[:developer]
          s << '<script type="text/javascript">var disqus_developer = 1;</script>'
        end
        s << '<div id="disqus_thread"></div>'
        s << '<script type="text/javascript" src="' + THREAD + '"></script>'
        s << '<noscript><a href="http://%s.disqus.com/?url=ref">'
        s << opts[:view_thread_text]
        s << '</a></noscript>'
        if opts[:show_powered_by]
          s << '<a href="http://disqus.com" class="dsq-brlink">blog comments '
          s << 'powered by <span class="logo-disqus">Disqus</span></a>'
        end
        s % [opts[:account], opts[:account]]
      end
      
      # Loads Javascript to show the number of comments for the page.
      #
      # The Javascript sets the inner html to the comment count for any links
      # on the page that have the anchor "disqus_thread". For example, "View
      # Comments" below would be replaced by "1 comment" or "23 comments" etc.
      #
      #   <a href="http://my.website/article-permalink#disqus_thread">View Comments</a>
      #   <a href="http://my.website/different-permalink#disqus_thread">View Comments</a>
      # Options:
      # * <tt>account:</tt> Your Discus account (required).
      def comment_counts(opts = {})
        opts = Disqus::defaults.merge(opts)        
        validate_opts!(opts)
        s = <<-WHIMPER
        <script type="text/javascript">
        //<[CDATA[
        (function() {
            var links = document.getElementsByTagName('a');
            var query = '?';
            for(var i = 0; i < links.length; i++) {
              if(links[i].href.indexOf('#disqus_thread') >= 0) {
                query += 'url' + i + '=' + encodeURIComponent(links[i].href) + '&';
              }
            }
            document.write('<' + 'script type="text/javascript" src="#{ROOT_PATH}get_num_replies.js' + query + '"></' + 'script>');
          })();
        //]]>
        </script>
        WHIMPER
        s % opts[:account]
      end
      
      # Show the top commenters Disqus thread widget.
      # Options:
      # * <tt>account:</tt> Your Discus account (required).
      # * <tt>header:</tt> HTML snipper with header (default h2) tag and text.
      # * <tt>show_powered_by:</tt> Show or hide the powered by Disqus text.
      # * <tt>num_items:</tt>: How many items to show.
      # * <tt>hide_mods:</tt> Don't show moderators.
      # * <tt>hide_avatars:</tt> Don't show avatars.
      # * <tt>avatar_size:</tt> Avatar size.
      def top_commenters(opts = {})
        opts = Disqus::defaults.merge(opts)
        opts[:header] ||= '<h2 class="dsq-widget-title">Top Commenters</h2>'
        validate_opts!(opts)        
        s = '<div id="dsq-topcommenters" class="dsq-widget">'
        s << opts[:header]
        s << '<script type="text/javascript" src="'
        s << TOP
        s << '&hide_avatars=1' if opts[:hide_avatars]
        s << '&hide_mods=1' if opts[:hide_mods]
        s << '"></script>'
        s << '</div>'
        if opts[:show_powered_by]
          s << '<a href="http://disqus.com">Powered by Disqus</a>'
        end
        s % [opts[:account], opts[:num_items], opts[:avatar_size], opts[:orientation]]
      end
      
      # Show the popular threads Disqus widget.
      # Options:
      # * <tt>account:</tt> Your Discus account (required).
      # * <tt>header:</tt> HTML snipper with header (default h2) tag and text.
      # * <tt>num_items:</tt>: How many items to show.
      # * <tt>hide_mods:</tt> Don't show moderators.
      def popular_threads(opts = {})
        opts = Disqus::defaults.merge(opts)
        opts[:header] ||= '<h2 class="dsq-widget-title">Popular Threads</h2>'
        validate_opts!(opts)
        s = '<div id="dsq-popthreads" class="dsq-widget">'
        s << opts[:header]
        s << '<script type="text/javascript" src="'
        s << POPULAR
        s << '&hide_mods=1' if opts[:hide_mods]
        s << '"></script>'
        s << '</div>'
        s << '<a href="http://disqus.com">Powered by Disqus</a>' if opts[:show_powered_by]
        s % [opts[:account], opts[:num_items]]
      end
    
      # Show the recent comments Disqus widget.
      # Options:
      # * <tt>account:</tt> Your Discus account (required).
      # * <tt>header:</tt> HTML snipper with header (default h2) tag and text.
      # * <tt>num_items:</tt>: How many items to show.
      # * <tt>hide_avatars:</tt> Don't show avatars.
      # * <tt>avatar_size:</tt> Avatar size.
      def recent_comments(opts = {})
        opts = Disqus::defaults.merge(opts)
        opts[:header] ||= '<h2 class="dsq-widget-title">Recent Comments</h2>'
        validate_opts!(opts)
        s = '<div id="dsq-recentcomments" class="dsq-widget">'
        s << opts[:header]
        s << '<script type="text/javascript" src="'
        s << RECENT 
        s << '&hide_avatars=1' if opts[:hide_avatars]
        s << '"></script>'
        s << '</div>'
        if opts[:show_powered_by]
          s << '<a href="http://disqus.com">Powered by Disqus</a>'
        end
        s % [opts[:account], opts[:num_items], opts[:avatar_size]]
      end
    
      # Show the Disqus combo widget. This is a three-tabbed box with links
      # popular threads, top posters, and recent threads.
      # Options:
      # * <tt>:account:</tt> Your Discus account (required).
      # * <tt>:num_items:</tt> How many items to show.
      # * <tt>:hide_mods:</tt> Don't show moderators.
      # * <tt>:default_tab:</tt> Should be 'people', 'recent', or 'popular'.
      def combo(opts = {})
        opts = Disqus::defaults.merge(opts)
        validate_opts!(opts)
        s = '<script type="text/javascript" src="'
        s << COMBO
        s << '&hide_mods=1' if opts[:hide_mods]
        s << '"></script>' 
        s % [opts[:account], opts[:num_items], opts[:color], opts[:default_tab]]
      end
      
      private

      def validate_opts!(opts)
        raise ArgumentError.new("You must specify an :account") if !opts[:account]
        raise ArgumentError.new("Invalid color") if opts[:color] && !VALID_COLORS.include?(opts[:color])
        raise ArgumentError.new("Invalid num_items") if opts[:num_items] && !VALID_NUM_ITEMS.include?(opts[:num_items])
        raise ArgumentError.new("Invalid default_tab") if opts[:default_tab] && !VALID_DEFAULT_TABS.include?(opts[:default_tab])
        raise ArgumentError.new("Invalid avatar size") if opts[:avatar_size] && !VALID_AVATAR_SIZES.include?(opts[:avatar_size])
        raise ArgumentError.new("Invalid orientation") if opts[:orientation] && !VALID_ORIENTATIONS.include?(opts[:orientation])
      end
      
    end
  
  end

end
