Disqus Ruby Gem

The Disqus Gem helps you easily integrate the Disqus commenting system into your website. It works for any site programmed in Ruby, not just Rails.

Get it

Stable release:

gem install disqus

Bleeding edge:

gem install norman-disqus --source http://gems.github.com

Use it:

Configure it:


  Disqus::defaults[:account] = "my_account" 

Show the comment threads on a post page:


  # Loads the commenting system
  Disqus::Widget::thread
  # Or if you're using Rails:
  disqus_thread

  # Appends the comment count to a end of link text for a url that ends with
  # #disqus_thread. For example:
  # <a href="http://my.website/article-permalink#disqus_thread">View Comments</a>
  Disqus::Widget::comment_counts
  # Or if you're using Rails:
  disqus_comment_counts

Show the combo widget on a post page:


  Disqus::Widget::combo(:color => "blue", :hide_mods => false, :num_items => 25)
  # Or if you're using Rails:
  disqus_combo(:color => "blue", :hide_mods => false, :num_items => 25)

Show the comment count on a permalink:


  link_to("Permalink", post_path(@post, :anchor => "disqus_thread"))
  ...
  Disqus::Widget::comment_counts
  # Or for Rails:
  disqus_comment_counts

Hack it:

Github repository: http://github.com/norman/disqus

Complain about it:

norman@randomba.org

Learn more about Disqus:

http://disqus.com

Copyright© 2008 Norman Clarke, released under the MIT license