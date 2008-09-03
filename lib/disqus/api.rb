require 'open-uri'
require 'rubygems'
require 'json'

module Disqus

  class Api
    
    ROOT = 'http://disqus.com/api'
  
    class << self
      
      def get_forum_list(opts = {})
        opts[:api_key] ||= Disqus::defaults[:api_key]
        JSON.parse(get('get_forum_list', :user_api_key => opts[:api_key]))
      end
      
      def get_forum_api_key(opts = {})
        opts[:api_key] ||= Disqus::defaults[:api_key]
        JSON.parse(get('get_forum_api_key', :user_api_key => opts[:api_key], :forum_id => opts[:forum_id]))
      end
      
      private

      def escape(string)
        URI::encode(string, /[^a-z0-9]/i)
      end
      
      def get(*args)
        open(make_url(*args)) {|u| u.read }
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