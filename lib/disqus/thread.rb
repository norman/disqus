module Disqus

  class Thread
    attr_reader :id, :forum, :slug, :title, :created_at, :allow_comments, :url, :identifier
    
    def self.initialize(id, forum, slug, title, created_at, allow_comments, url, identifier)
      @id, @forum, @slug, @title, @created_at, @allow_comments, @url, @identifier = id.to_i, forum, slug, title, created_at, allow_comments, url, identifier
    end
    
  end
  
end
