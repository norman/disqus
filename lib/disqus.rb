require 'disqus/widget'
  

# Disqus is a javascript embed that enhances your blog's comments and
# integrates it with a fully moderated community forum. The Disqus gem helps
# you quickly and easily integrate Disqus's widgets into your Ruby-based 
# website. To use it, please first create an account on Disqus.
module Disqus
  
  @defaults = {
    :account => "",
    :avatar_size => 48,
    :color => "grey",
    :default_tab => "popular",
    :hide_avatars => false,
    :hide_mods => true,
    :num_items => 15,
    :show_powered_by => true,
    :orientation => "horizontal"
  }
  
  def self.defaults
    @defaults
  end
  
  def self.enable_rails
    return if ActionView::Base.instance_methods.include? 'disqus_thread'
    require 'disqus/view_helpers'
    ActionView::Base.class_eval { include Disqus::ViewHelpers }
  end

  def self.enable_merb
    return if Merb::Controller.instance_methods.include? 'disqus_thread'
    require 'disqus/view_helpers'
    Merb::Controller.class_eval { include Disqus::ViewHelpers }
  end

end

if defined?(Rails) and defined?(ActionView)
  Disqus::enable_rails
elsif defined?(Merb)
  Disqus::enable_merb
end
