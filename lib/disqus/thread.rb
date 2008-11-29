module Disqus

  class Thread
    attr_reader :id, :forum, :slug, :title, :created_at, :allow_comments, :url, :identifier
    
    def initialize(id, forum, slug, title, created_at, allow_comments, url, identifier)
      @id, @forum, @slug, @title, @created_at, @allow_comments, @url, @identifier = id.to_i, forum, slug, title, created_at, allow_comments, url, identifier
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
    
  end
  
end
