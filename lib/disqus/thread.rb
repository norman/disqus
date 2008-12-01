module Disqus

  class Thread
    attr_reader :id, :forum, :slug, :title, :created_at, :allow_comments, :url, :identifier, :forum, :posts
    
    def initialize(id, forum, slug, title, created_at, allow_comments, url, identifier)
      @id, @forum, @slug, @title, @created_at, @allow_comments, @url, @identifier = id.to_i, forum, slug, title, created_at, allow_comments, url, identifier
      @posts = []
    end

    def ==(other_thread)
      id             == other_thread.id             &&
      forum          == other_thread.forum          &&
      slug           == other_thread.slug           &&
      title          == other_thread.title          &&
      created_at     == other_thread.created_at     &&
      allow_comments == other_thread.allow_comments &&
      url            == other_thread.url            &&
      identifier     == other_thread.identifier
    end
    
    def self.list(forum, opts = {})
      response = Disqus::Api::get_thread_list(opts.merge(:forum_id =>forum.id, :forum_api_key => forum.key))
      if response["succeeded"]
        list = response["message"].map do |thread| 
          Thread.new( thread["id"],
                      forum,
                      thread["slug"],
                      thread["title"],
                      thread["created_at"],
                      thread["allow_comments"],
                      thread["url"],
                      thread["identifier"] )
        end
      end
    end
    
    def load_posts(opts = {})
      @posts = Post.list(self, opts)
    end
    
    def update(opts = {})
      result = Disqus::Api::update_thread(opts.merge( :forum_api_key  => forum.key,
                                                      :thread_id      => id,
                                                      :title          => title,
                                                      :slug           => slug,
                                                      :url            => url,
                                                      :allow_comments => allow_comments))
      return result["succeeded"]
    end
    
  end
  
end
