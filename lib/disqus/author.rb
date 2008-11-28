module Disqus
  class BaseAuthor
    attr_reader :url, :email_hash
  end
  
  class Author < BaseAuthor
    attr_reader :id, :username, :display_name, :has_avatar
    def initialize(id, username, display_name, url, email_hash, has_avatar)
      @id, @username, @display_name, @url, @email_hash, @has_avatar = id, username, display_name, url, email_hash, has_avatar
    end
  end
  
  class AnonymousAuthor < BaseAuthor
    attr_reader :name
    def initialize(name, url, email_hash)
      @name, @url, @email_hash = name, url, email_hash
    end
  end
end

