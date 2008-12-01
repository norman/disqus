module Disqus

  class Forum
    attr_reader :id, :shortname, :name, :created_at, :threads
    
    def initialize(id, shortname, name, created_at)
      @id, @shortname, @name = id.to_i, shortname, name
      @key = nil
      @threads = []
    end

    def ==(other_forum)
      id        == other_forum.id        &&
      shortname == other_forum.shortname &&
      name      == other_forum.name      &&
      key       == other_forum.key
    end

    def self.list(opts = {})
      response = Disqus::Api::get_forum_list(opts)
      if response["succeeded"]
        list = response["message"].map{|forum| Forum.new(forum["id"], forum["shortname"], forum["name"], forum["created_at"])}
      end
    end
    
    def self.find(forum_id, opts = {})
      list = Forum.list(opts)
      if list
        list.select{|f| f.id == forum_id}.first
      end
    end
    
    def load_key(opts = {})
      response = Disqus::Api::get_forum_api_key(opts.merge(:forum_id => self.id))
      @key = response["message"] if response["succeeded"]
    end
    
    def key
      @key ||= load_key
    end
    
    def load_threads
      @threads = Disqus::Thread.list(self)
    end

    def get_thread_by_url(url, opts = {})
      response = Disqus::Api::get_thread_by_url(opts.merge(:url => url, :forum_api_key => key))
      if response["succeeded"]
        t = response["message"]
        Thread.new(t["id"], self, t["slug"], t["title"], t["created_at"], t["allow_comments"], t["url"], t["identifier"])
      end
    end
    
    def get_thread_by_identifier(identifier, title, opts = {})
      # TODO - should we separate thread retrieval from thread creation? The API to me seems confusing here.
      response = Disqus::Api::thread_by_identifier(opts.merge(:identifier => identifier, :title => title, :forum_api_key => key))
      if response["succeeded"]
        t = response["message"]["thread"]
        Thread.new(t["id"], self, t["slug"], t["title"], t["created_at"], t["allow_comments"], t["url"], t["identifier"])
      end
    end
    
    def update_thread(id, title, slug, url, allow_comments, opts = {})
      result = Disqus::Api::update_thread(opts.merge(:forum_api_key  => key,
                                            :thread_id      => id,
                                            :title          => title,
                                            :slug           => slug,
                                            :url            => url,
                                            :allow_comments => allow_comments))
      return result["succeeded"]
    end
    
  end
end
