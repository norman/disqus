%w[api author forum post thread version view_helpers widget].each do |file|
  require File.join(File.dirname(__FILE__), "disqus", file)
end

# == From the {Disqus Website}[http://disqus.com]:

# "Disqus, pronounced "discuss", is a service and tool for web comments and
# discussions. The Disqus comment system can be plugged into any website, blog,
# or application. Disqus makes commenting easier and more interactive, while
# connecting websites and commenters across a thriving discussion community."
# 
# "Disqus is a free service to the general public with absolutely no inline
# advertisements."

# The Disqus gem helps you quickly and easily integrate Disqus's Javascript
# widgets into your Ruby-based website. Adding Disqus to your site literally
# takes only a few minutes. The Disqus gem also provides a complete
# implementation of the Disqus API for more complex applications.

# To use this code, please first create an account on Disqus[http://disqus.com].
module Disqus
  
  @defaults = {
    :api_key         => "",
    :account         => "",
    :developer       => false,
    :container_id    => 'disqus_thread',
    :avatar_size     => 48,
    :color           => "grey",
    :default_tab     => "popular",
    :hide_avatars    => false,
    :hide_mods       => true,
    :num_items       => 15,
    :show_powered_by => true,
    :orientation     => "horizontal"
  }
  
  # Disqus defaults:
  #  :account         => "",
  #  :avatar_size     => 48,
  #  :color           => "grey",
  #  :default_tab     => "popular",
  #  :hide_avatars    => false,
  #  :hide_mods       => true,
  #  :num_items       => 15,
  #  :show_powered_by => true,
  #  :orientation     => "horizontal"
  def self.defaults
    @defaults
  end

end