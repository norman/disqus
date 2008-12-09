require 'open-uri'
require 'rubygems'
require 'json'
require 'net/http'
require 'uri'

module Disqus
  
  # == Disqus API
  #
  # The Api class implements the Disqus API directly. It is not really
  # intended to be used directly, but rather to use the domain objects of
  # Forum, Thread, Post, Author and AnonymousAuthor. For full information on
  # the Disqus API, please see the {Disqus developer info}[http://disqus.com/docs/api/].
  #
  # Each method in the Api class takes as a single argument a hash of options,
  # and returns a Hash with 3 keys:
  #
  # * 'succeeded' - contains true or false indicating whether the API call succeeded
  # * 'code' - if the API call did not succeed, this will contain an error code.
  # * 'message' - contains the object being returned on success, or an error message on failure.
  #
  # === API Keys
  # 
  # There are two different kinds of API keys: 
  #
  # ==== User Keys
  #
  # Every Disqus account has a User Key; it is used to perform actions
  # associated with that account. This can be passed in as an option, or
  # configured as follows:
  #
  #   Disqus::defaults[:api_key] = "the_user_api_key"
  #  
  # ==== Forum Keys
  #
  # Every Disqus forum has a Forum Key. It can be shared among trusted
  # moderators of a forum, and is used to perform actions associated with that
  # forum. The creator of a forum can get the forum's key through the API.
  class Api
    
    ROOT = 'http://disqus.com/api'
  
    class << self

      # Creates a new post on the thread. Does not check against spam filters or ban list. 
      # This is intended to allow automated importing of comments.
      # 
      # Returns a Hash containing a representation of the post just created:
      # 
      # Required options hash elements:
      #
      # * <tt>:forum_api_key</tt> - the API key for the forum
      # * <tt>:thread_id</tt> - the thread to post to
      # * <tt>:message</tt> - the content of the post
      # * <tt>:author_name</tt> - the post creator's name
      # * <tt>:author_email</tt> - the post creator's email address
      #
      # Optional:
      #
      # * <tt>:parent_post</tt> - the id of the parent post
      # * <tt>:created_at</tt> - the UTC date this post was created, in the format <tt>%Y-%m-%dT%H:%M</tt> (the current time will be used by default)
      # * <tt>:author_url</tt> - the author's homepage
      # * <tt>:ip_address</tt> - the author's IP address
      def create_post(opts = {})
        opts[:api_key] ||= Disqus::defaults[:api_key]
        JSON.parse(post('create_post',
          :forum_api_key => opts[:forum_api_key],
          :thread_id     => opts[:thread_id],
          :message       => opts[:message],
          :author_name   => opts[:author_name],
          :author_email  => opts[:author_email],
          :parent_post   => opts[:parent_post],
          :created_at    => opts[:created_at], #UTC timestring, format: %Y-%m-%dT%H:%M
          :author_url    => opts[:author_url],
          :ip_address    => opts[:ip_address])
        )
      end

      # Returns an array of hashes representing all forums the user owns. The
      # user is determined by the API key. 
      #
      # Options:
      #
      # * <tt>:api_key</tt> - The User's API key (defaults to
      #   Disqus::defaults[:api_key])
      def get_forum_list(opts = {})
        opts[:api_key] ||= Disqus::defaults[:api_key]
        JSON.parse(get('get_forum_list', :user_api_key => opts[:api_key]))
      end

      # Returns A string which is the Forum Key for the given forum.
      # 
      # Required options hash elements:
      #
      # * <tt>:forum_id</tt> - the unique id of the forum
      #
      # Optional:
      #
      # * <tt>:api_key</tt> - The User's API key (defaults to Disqus::defaults[:api_key])
      def get_forum_api_key(opts = {})
        opts[:api_key] ||= Disqus::defaults[:api_key]
        JSON.parse(get('get_forum_api_key', :user_api_key => opts[:api_key], :forum_id => opts[:forum_id]))
      end
      
      # Returns: An array of hashes representing all threads belonging to the
      # given forum. 
      #  
      # Required options hash elements:
      #
      # * <tt>:forum_api_key</tt> - the API key for the forum
      # * <tt>:forum_id</tt> - the unique id of the forum
      def get_thread_list(opts = {})
        JSON.parse(get('get_thread_list', :forum_id => opts[:forum_id], :forum_api_key => opts[:forum_api_key]))
      end
      
      # Returns a hash having thread_ids as keys and 2-element arrays as
      # values. 
      #
      # The first array element is the number of visible comments on on the
      # thread; this would be useful for showing users of the site (e.g., "5
      # Comments"). 
      #
      # The second array element is the total number of comments on the
      # thread. 
      #
      # These numbers are different because some forums require moderator
      # approval, some messages are flagged as spam, etc.
      #  
      # Required options hash elements:
      #
      # * <tt>:forum_api_key</tt> - the API key for the forum
      # * <tt>:thread_ids</tt> - an array of thread IDs belonging to the given forum.
      def get_num_posts(opts = {})
        opts[:api_key] ||= Disqus::defaults[:api_key]
        JSON.parse(get('get_num_posts', :thread_ids => opts[:thread_ids].join(","), :forum_api_key => opts[:forum_api_key]))
      end

      # Returns a hash representing a thread if one was found, otherwise null.
      #
      # It only finds threads associated with the given forum.
      #
      # Note that there is no one-to-one mapping between threads and URL's; a
      # thread will only have an associated URL if it was automatically
      # created by Disqus javascript embedded on that page. Therefore, we
      # recommend using thread_by_identifier whenever possible. This method is
      # provided mainly for handling comments from before your forum was using
      # the API.
      #
      # Required options hash elements:
      #
      # * <tt>:forum_api_key</tt> - the API key for the forum
      # * <tt>:url</tt> - the URL to check for an associated thread
      def get_thread_by_url(opts = {})
        JSON.parse(get('get_thread_by_url', :url => opts[:url], :forum_api_key => opts[:forum_api_key]))
      end

      # Returns an array of hashes representing representing all posts
      # belonging to the given forum. 
      #      
      # Required options hash elements:
      #
      # * <tt>:forum_api_key</tt> - the API key for the forum
      # * <tt>:thread_id</tt> - the ID of a thread belonging to the given forum
      def get_thread_posts(opts = {})
        JSON.parse(get('get_thread_posts', :thread_id => opts[:thread_id], :forum_api_key => opts[:forum_api_key]))
      end
      
      # Create or retrieve a thread by an arbitrary identifying string of your
      # choice. For example, you could use your local database's ID for the
      # thread. This method allows you to decouple thread identifiers from the
      # URL's on which they might be appear. (Disqus would normally use a
      # thread's URL to identify it, which is problematic when URL's do not
      # uniquely identify a resource.) If no thread exists for the given
      # identifier yet (paired with the forum), one will be created.
      #      
      # Returns a  hash with two keys: 
      #
      # * "thread", which is a hash representing the thread corresponding to the identifier; and 
      # * "created", which indicates whether the thread was created as a result of this method call. If created, it will have the specified title.
      #
      # Required options hash elements:
      #
      # * <tt>:forum_api_key</tt> - the API key for the forum
      # * <tt>:title</tt> - the title of the thread to possibly be created
      # * <tt>:identifier</tt> - a string of your choosing
      def thread_by_identifier(opts = {})
        JSON.parse(post('thread_by_identifier', :forum_api_key => opts[:forum_api_key],
                                                :identifier => opts[:identifier],
                                                :title => opts[:title] ))
      end
      
      # Sets the provided values on the thread object.
      #
      # Returns an empty success message.
      #
      # Required options hash elements:
      #
      # * <tt>:forum_api_key</tt> - the API key for the forum
      # * <tt>:thread_id</tt> - the ID of a thread belonging to the given forum
      #
      # Optional:
      #
      # * <tt>:title</tt> - the title of the thread
      # * <tt>:slug</tt> - the per-forum-unique string used for identifying this thread in disqus.com URL's relating to this thread. Composed of underscore-separated alphanumeric strings.
      # * <tt>:url</tt> - the URL this thread is on, if known.
      # * <tt>:allow_comment</tt> - whether this thread is open to new comments
      def update_thread(opts = {})
        raise opts.inspect
        JSON.parse(post('update_thread',
          :forum_api_key  => opts[:forum_api_key],
          :thread_id      => opts[:thread_id],
          :title          => opts[:title],
          :slug           => opts[:slug],
          :url            => opts[:url],
          :allow_comments => opts[:allow_comments])
        )
      end
      
      # Widget to includes a comment form suitable for use with the Disqus
      # API. This is different from the other widgets in that you can specify
      # the thread identifier being commented on.
      def comment_form(forum_shortname, thread_identifier)
        url = 'http://disqus.com/api/reply.js?' + 
          "forum_shortname=#{escape(forum_shortname)}&" + 
          "thread_identifier=#{escape(thread_identifier)}"
        s = '<div id="dsq-reply">'
        s << '<script type="text/javascript" src="%s"></script>' % url
        s << '</div>'
        return s
      end
      
      private

      def escape(string)
        URI::encode(string, /[^a-z0-9]/i)
      end
      
      def get(*args)
        open(make_url(*args)) {|u| u.read }
      end
      
      def post(*args)
        url = ROOT + '/' + args.shift 
        post_params = {}
        args.shift.each { |k, v| post_params[k.to_s]=v.to_s }
        Net::HTTP.post_form(URI.parse(url),post_params)
      end

      def make_url(*args)
        url = ROOT + '/' + args.shift + '/?'
        args.shift.each { |k, v| url += "#{k}=#{escape(v.to_s)}&" }
        return url.chomp('&')
      end

      def validate_opts!(opts)
        raise ArgumentError.new("You must specify an :api_key") if !opts[:api_key]
      end
      
    end
  
  end

end