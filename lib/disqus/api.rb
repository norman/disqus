require 'open-uri'
require 'rubygems'
require 'json'
require 'net/http'
require 'uri'

module Disqus

  class Api
    
    ROOT = 'http://disqus.com/api'
  
    class << self
      
      
      def create_post(opts = {})
        opts[:api_key] ||= Disqus::defaults[:api_key]
        JSON.parse(post('create_post',  :forum_api_key => opts[:forum_api_key],
                                        :thread_id     => opts[:thread_id],
                                        :message       => opts[:message],
                                        :author_name   => opts[:author_name],
                                        :author_email  => opts[:author_email],
                                        :parent_post   => opts[:parent_post],
                                        :created_at    => opts[:created_at],   #UTC timestring, format: %Y-%m-%dT%H:%M  
                                        :author_url    => opts[:author_url],
                                        :ip_address    => opts[:ip_address]))
      end
      
      def get_forum_list(opts = {})
        opts[:api_key] ||= Disqus::defaults[:api_key]
        JSON.parse(get('get_forum_list', :user_api_key => opts[:api_key]))
      end
      
      def get_forum_api_key(opts = {})
        opts[:api_key] ||= Disqus::defaults[:api_key]
        JSON.parse(get('get_forum_api_key', :user_api_key => opts[:api_key], :forum_id => opts[:forum_id]))
      end
      
      def get_thread_list(opts = {})
        opts[:api_key] ||= Disqus::defaults[:api_key]
        JSON.parse(get('get_thread_list', :forum_id => opts[:forum_id], :forum_api_key => opts[:forum_api_key]))
      end
      
      def get_num_posts(opts = {})
        opts[:api_key] ||= Disqus::defaults[:api_key]
        JSON.parse(get('get_num_posts', :thread_ids => opts[:thread_ids].join(","), :forum_api_key => opts[:forum_api_key]))
      end
      
      def get_thread_by_url(opts = {})
        opts[:api_key] ||= Disqus::defaults[:api_key]
        JSON.parse(get('get_thread_by_url', :url => opts[:url], :forum_api_key => opts[:forum_api_key]))
      end

      def get_thread_posts(opts = {})
        opts[:api_key] ||= Disqus::defaults[:api_key]
        JSON.parse(get('get_thread_posts', :thread_id => opts[:thread_id], :forum_api_key => opts[:forum_api_key]))
      end
      
      def thread_by_identifier(opts = {})
        opts[:api_key] ||= Disqus::defaults[:api_key]
        JSON.parse(post('thread_by_identifier', :forum_api_key => opts[:forum_api_key],
                                                :identifier => opts[:identifier],
                                                :title => opts[:title] ))
      end
      
      def update_thread(opts = {})
        opts[:api_key] ||= Disqus::defaults[:api_key]
        JSON.parse(post('update_thread', :forum_api_key  => opts[:forum_api_key],
                                         :thread_id      => opts[:thread_id],
                                         :title          => opts[:title],
                                         :slug           => opts[:slug],
                                         :url            => opts[:url],
                                         :allow_comments => opts[:allow_comments] ))
      end
      

      private

      def escape(string)
        URI::encode(string, /[^a-z0-9]/i)
      end
      
      def get(*args)
        open(make_url(*args)) {|u| u.read }
      end
      
      def post(*args)
        url = ROOT + '/' + args.shift 
        post_params = {}
        args.shift.each { |k, v| post_params[k.to_s]=v.to_s }
        Net::HTTP.post_form(URI.parse(url),post_params)
      end

      def make_url(*args)
        url = ROOT + '/' + args.shift + '/?'
        args.shift.each { |k, v| url += "#{k}=#{escape(v.to_s)}&" }
        return url.chomp('&')
      end

      def validate_opts!(opts)
        raise ArgumentError.new("You must specify an :api_key") if !opts[:api_key]
      end
      
    end
  
  end

end