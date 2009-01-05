module Disqus

  class Forum
    attr_reader :id, :shortname, :name, :created_at, :threads
    
    def initialize(id, shortname, name, created_at, include_threads = false)
      @id, @shortname, @name, @created_at = id.to_i, shortname, name, Time.parse(created_at.to_s)
      @key = nil
      @forum_threads = include_threads ? load_threads : []
    end

    def ==(other_forum)
      id        == other_forum.id        &&
      shortname == other_forum.shortname &&
      name      == other_forum.name      &&
      key       == other_forum.key
    end

    # Returns an array of Forum objects belonging to the user indicated by the API key.
    def self.list(user_api_key = nil)
      opts = user_api_key ? {:api_key => user_api_key} : {}
      response = Disqus::Api::get_forum_list(opts)
      if response["succeeded"]
        return response["message"].map{|forum| Forum.new(forum["id"], forum["shortname"], forum["name"], forum["created_at"])}
      else
        raise_api_error(response)
      end
    end
    
    # Returns a Forum object corresponding to the given forum_id or nil if it was not found.
    def self.find(forum_id, user_api_key = nil)
      opts = user_api_key ? {:api_key => user_api_key} : {}
      list = Forum.list(opts)
      if list
        list.select{|f| f.id == forum_id}.first
      end
    end
    
    # Returns the forum API Key for this forum.
    def key(user_api_key = nil)
      @key ||= load_key(user_api_key)
    end
    
    # Returns an array of threads belonging to this forum.
    def forum_threads(force_update = false)
      if (@forum_threads.nil? or @forum_threads.empty? or force_update)
        @forum_threads = Disqus::Thread.list(self)
      end
      @forum_threads
    end
    
    # Returns a thread associated with the given URL.
    #
    # A thread will only have an associated URL if it was automatically
    # created by Disqus javascript embedded on that page.
    def get_thread_by_url(url)
      response = Disqus::Api::get_thread_by_url(:url => url, :forum_api_key => key)
      if response["succeeded"]
        t = response["message"]
        Thread.new(t["id"], self, t["slug"], t["title"], t["created_at"], t["allow_comments"], t["url"], t["identifier"])
      else
        raise_api_error(response)
      end
    end
    
    # Create or retrieve a thread by an arbitrary identifying string of your
    # choice. For example, you could use your local database's ID for the
    # thread. This method allows you to decouple thread identifiers from the
    # URL's on which they might be appear. (Disqus would normally use a
    # thread's URL to identify it, which is problematic when URL's do not
    # uniquely identify a resource.) If no thread exists for the given
    # identifier (paired with the forum) yet, one will be created.
    #
    # Returns a Thread object representing the thread that was created or
    # retrieved.
    def thread_by_identifier(identifier, title)
      # TODO - should we separate thread retrieval from thread creation? The API to me seems confusing here.
      response = Disqus::Api::thread_by_identifier(:identifier => identifier, :title => title, :forum_api_key => key)
      if response["succeeded"]
        t = response["message"]["thread"]
        Thread.new(t["id"], self, t["slug"], t["title"], t["created_at"], t["allow_comments"], t["url"], t["identifier"])
      else
        raise_api_error(response)
      end
    end
    
    # Sets the provided values on the thread object.
    #
    # Returns an empty success message.
    #
    # Options:
    #
    # * <tt>:title</tt> - the title of the thread
    # * <tt>:slug</tt> - the per-forum-unique string used for identifying this thread in disqus.com URL's relating to this thread. Composed of underscore-separated alphanumeric strings.
    # * <tt>:url</tt> - the URL this thread is on, if known.
    # * <tt>:allow_comment</tt> - whether this thread is open to new comments
    def update_thread(thread_id, opts = {})
      result = Disqus::Api::update_thread(
        :forum_api_key  => key,
        :thread_id      => thread_id,
        :title          => opts[:title],
        :slug           => opts[:slug],
        :url            => opts[:url],
        :allow_comments => opts[:allow_comments]
      )
      return result["succeeded"]
    end
    
    private
    
    def raise_api_error(response)
      raise "Error: #{response['code']}: #{response['message']}"
    end
    
    def load_key(user_api_key = nil)
      opts = user_api_key ? {:api_key => user_api_key} : {}
      response = Disqus::Api::get_forum_api_key(opts.merge(:forum_id => self.id))
      if response["succeeded"]
        return @key = response["message"] 
      else
        raise_api_error(response)
      end
    end
    
  end
end
