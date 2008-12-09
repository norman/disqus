module Disqus

  class Post
    attr_reader :id, :forum, :thread, :created_at, :message, :parent_post, :shown, :is_anonymous, :author
    
    def initialize(id, forum, thread, created_at, message, parent_post, shown, is_anonymous, author)
         @id, @forum, @thread, @created_at, @message, @parent_post, @shown, @is_anonymous, @author = id.to_i, forum, thread, Time.parse(created_at.to_s), message, parent_post, shown, is_anonymous, author
    end
    
    # Returns an array of Post objects representing all posts belonging to the
    # given thread. The array is sorted by the "created_at" date descending.
    def self.list(thread)
      response = Disqus::Api::get_thread_posts(:thread_id =>thread.id, :forum_api_key => thread.forum.key)
      if response["succeeded"]
        posts = response["message"].map do |post|
          author = nil
          if post["is_anonymous"] 
            author = AnonymousAuthor.new(
              post["anonymous_author"]["name"],
              post["anonymous_author"]["url"],
              post["anonymous_author"]["email_hash"]
            )
          else
            author = Author.new(
              post["author"]["id"].to_i,
              post["author"]["username"],
              post["author"]["display_name"],
              post["author"]["url"],
              post["author"]["email_hash"],
              post["author"]["has_avatar"]
            )
          end
          Post.new( 
            post["id"],
            thread.forum,
            thread,
            post["created_at"],
            post["message"],
            post["parent_post"],
            post["shown"],
            post["is_anonymous"],
            author
          )
        end
        posts.sort!{|a,b| a.created_at <=> b.created_at}
      end
    end
  end
end


