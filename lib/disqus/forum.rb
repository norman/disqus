module Disqus

  class Forum
    attr_reader :id, :shortname, :name
    def self.initialize(id, shortname, name)
      @id, @shortname, @name = id, shortname, name
    end
  end
end
