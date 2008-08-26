module Disqus

  class Widget
  
    class Error < StandardError ; end
    
    VALID_COLORS = ['blue', 'grey', 'green', 'red', 'orange']
    VALID_NUM_ITEMS = 5..20
    VALID_DEFAULT_TABS = ['people', 'recent', 'popular']
    VALID_AVATAR_SIZES = [24, 32, 48, 92, 128]
    VALID_ORIENTATIONS = ['horizontal', 'vertical']

    ROOT_PATH = 'http://disqus.com/forums/%s/'
    THREAD = ROOT_PATH + 'embed.js'
    COMBO = ROOT_PATH + 'combination_widget.js?num_items=%d&color=%s&default_tab=%s&hide_mods=%d'
    RECENT = ROOT_PATH + 'recent_comments_widget.js?num_items=%d&avatar_size=%d&hide_mods=%d&hide_avatars=%d'
    POPULAR = ROOT_PATH + 'popular_threads_widget.js?num_items=%d&hide_mods=%d'
    TOP = ROOT_PATH + 'top_commenters_widget.js?num_items=%d&avatar_size=%d&hide_avatars=%d&orientation=%s'
    class << self
      
      # Show the main Disqus thread widget. Options:
      # * <tt>account:</tt> Your Discus account (required).
      def thread(opts)
        opts[:show_powered_by] ||= true
        opts[:view_thread_text] ||= "View the discussion thread"
        opts[:view_thread_text] ||= true
        validate_opts!(opts)
        t = '<div id="disqus_thread"></div>'
        t << '<script type="text/javascript" src="' + THREAD + '"></script>'
        t << '<noscript><a href="http://%s.disqus.com/?url=ref">'
        t << opts[:view_thread_text]
        t << '</a></noscript>'
        if opts[:show_powered_by]
          t << '<a href="http://disqus.com" class="dsq-brlink">blog comments '
          t << 'powered by <span class="logo-disqus">Disqus</span></a>'
        end
        t % [opts[:account], opts[:account]]
      end
      
      # Loads Javascript to show the number of comments for the page. Options:
      # * <tt>account:</tt> Your Discus account (required).
      def show_comment_count(opts)
        validate_opts!(opts)
        <<-WHIMPER
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
        		document.write('<script type="text/javascript" src="#{ROOT_PATH}#{opts[:account]}/get_num_replies.js' + query + '"></' + 'script>');
        	})();
        //]]>
        </script>
        WHIMPER
      end
      
      # Show the main Disqus thread widget. Options:
      # * <tt>account:</tt> Your Discus account (required).
      # * <tt>header:</tt> HTML snipper with header (default h2) tag and text.
      # * <tt>show_powered_by:</tt> Show or hide the powered by Disqus text.
      # * <tt>num_items:</tt>: How many items to show.
      # * <tt>hide_mods:</tt> Don't show moderators.
      # * <tt>hide_avatars:</tt> Don't show avatars.
      # * <tt>avatar_size:</tt> Avatar size.
      def top_commenters(opts)
        opts[:header] ||= '<h2 class="dsq-widget-title">Top Commenters</h2>'
        opts[:show_powered_by] ||= true
        opts[:num_items] ||= 5
        opts[:hide_mods] ||= false
        opts[:hide_avatars] ||= false
        opts[:orientation] ||= 'horizontal'
        opts[:hide_mods] = opts[:hide_mods] ? 1 : 0
        opts[:hide_avatars] = opts[:hide_avatars] ? 1 : 0
        validate_opts!(opts)        
        tc = '<div id="dsq-topcommenters" class="dsq-widget">'
        tc << opts[:header]
        tc << '<script type="text/javascript" src="' + TOP + '"></script>'
        tc << '</div>'
        if opts[:show_powered_by]
          tc << '<a href="http://disqus.com">Powered by Disqus</a>'
        end
        tc % [opts[:account], opts[:num_items], opts[:avatar_size],
          opts[:hide_avatars], opts[:hide_mods]]
      end
      
      # Show the main Disqus thread widget. Options:
      # * <tt>account:</tt> Your Discus account (required).
      # * <tt>header:</tt> HTML snipper with header (default h2) tag and text.
      # * <tt>num_items:</tt>: How many items to show.
      # * <tt>hide_mods:</tt> Don't show moderators.
      def popular_threads(opts)
        opts[:header] ||= '<h2 class="dsq-widget-title">Popular Threads</h2>'
        opts[:show_powered_by] ||= true
        opts[:num_items] ||= 5
        opts[:hide_mods] ||= false
        opts[:hide_mods] = opts[:hide_mods] ? 1 : 0
        validate_opts!(opts)
        pt = '<div id="dsq-popthreads" class="dsq-widget">'
        pt << opts[:header]
        pt << '<script type="text/javascript" src="' + POPULAR + '"></script>'
        pt << '</div>'
        if opts[:show_powered_by]
          pt << '<a href="http://disqus.com">Powered by Disqus</a>'
        end
        pt % [opts[:account], opts[:num_items], opts[:hide_mods]]
      end
    
      # Show the main Disqus thread widget. Options:
      # * <tt>account:</tt> Your Discus account (required).
      # * <tt>header:</tt> HTML snipper with header (default h2) tag and text.
      # * <tt>num_items:</tt>: How many items to show.
      # * <tt>hide_mods:</tt> Don't show moderators.
      # * <tt>hide_avatars:</tt> Don't show avatars.
      # * <tt>avatar_size:</tt> Avatar size.
      def recent_comments(opts)
        opts[:header] ||= '<h2 class="dsq-widget-title">Recent Comments</h2>'
        opts[:show_powered_by] ||= true
        opts[:num_items] ||= 5
        opts[:hide_mods] ||= false
        opts[:hide_avatars] ||= false
        opts[:avatar_size] ||= 48
        opts[:hide_mods] = opts[:hide_mods] ? 1 : 0
        opts[:hide_avatars] = opts[:hide_avatars] ? 1 : 0
        validate_opts!(opts)
        rc = '<div id="dsq-recentcomments" class="dsq-widget">'
        rc << opts[:header]
        rc << '<script type="text/javascript" src="' + RECENT + '"></script>'
        rc << '</div>'
        if opts[:show_powered_by]
          rc << '<a href="http://disqus.com">Powered by Disqus</a>'
        end
        rc % [opts[:account], opts[:num_items], opts[:avatar_size],
          opts[:hide_mods], opts[:hide_avatars]]
      end
    
      # Show the main Disqus thread widget. Options:
      # * <tt>account:</tt> Your Discus account (required).
      # * <tt>num_items:</tt>: How many items to show.
      # * <tt>hide_mods:</tt> Don't show moderators.
      def combo(opts)
        opts[:num_items] ||= 5
        opts[:hide_mods] ||= false 
        opts[:color] ||= 'blue'
        opts[:default_tab] ||= 'popular'
        opts[:hide_mods] = opts[:hide_mods] ? 1 : 0
        validate_opts!(opts)
        "<script type=\"text/javascript\" src=\"#{COMBO}\"></script>" %
          [opts[:account], opts[:num_items], opts[:color],
            opts[:default_tab], opts[:hide_mods]]
      end
      
      private

      def validate_opts!(opts)
        raise Error.new("You must specify an :account") if !opts[:account]
        raise Error.new("Invalid color") if opts[:color] && !VALID_COLORS.include?(opts[:color])
        raise Error.new("Invalid num_items") if opts[:num_items] && !VALID_NUM_ITEMS.include?(opts[:num_items])
        raise Error.new("Invalid default_tab") if opts[:default_tab] && !VALID_DEFAULT_TABS.include?(opts[:default_tab])
        raise Error.new("Invalid avatar size") if opts[:avatar_size] && !VALID_AVATAR_SIZES.include?(opts[:avatar_size])
        raise Error.new("Invalid hide_mods") if opts[:hide_mods] && ![0, 1].include?(opts[:hide_mods])
        raise Error.new("Invalid hide_avatars") if opts[:hide_avatars] && ![0, 1].include?(opts[:hide_avatars])
        raise Error.new("Invalid orientation") if opts[:orientation] && !VALID_ORIENTATIONS.include?(opts[:orientation])
      end
      
    end
  
  end

end