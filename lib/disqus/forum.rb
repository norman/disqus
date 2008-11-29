module Disqus

  class Forum
    attr_reader :id, :shortname, :name, :created_at, :key
    
    def initialize(id, shortname, name, key=nil)
      @id, @shortname, @name = id.to_i, shortname, name
    end

    def ==(other_forum)
      id        == other_forum.id       
      shortname == other_forum.shortname
      name      == other_forum.name     
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

  end
end

