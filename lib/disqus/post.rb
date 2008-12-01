module Disqus

  class Post
    attr_reader :id, :forum, :thread, :created_at, :message, :parent_post, :shown, :is_anonymous, :author
    
    def initialize(id, forum, thread, created_at, message, parent_post, shown, is_anonymous, author)
         @id, @forum, @thread, @created_at, @message, @parent_post, @shown, @is_anonymous, @author = id.to_i, forum, thread, created_at, message, parent_post, shown, is_anonymous, author
    end
    
    def self.list(thread, opts = {})
      response = Disqus::Api::get_thread_posts(opts.merge(:thread_id =>thread.id, :forum_api_key => thread.forum.key))
      if response["succeeded"]
        posts = response["message"].map do |post|
          author = nil
          if post["is_anonymous"] 
            author = AnonymousAuthor.new( post["anonymous_author"]["name"],
                                          post["anonymous_author"]["url"],
                                          post["anonymous_author"]["email_hash"])
          else
            author = Author.new(post["author"]["id"].to_i,
                                post["author"]["username"],
                                post["author"]["display_name"],
                                post["author"]["url"],
                                post["author"]["email_hash"],
                                post["author"]["has_avatar"] )
          end
          Post.new( post["id"],
                    thread.forum,
                    thread,
                    post["created_at"],
                    post["message"],
                    post["parent_post"],
                    post["shown"],
                    post["is_anonymous"],
                    author )
        end
      end
    end
  end
end