# Disqus

<hr/>
**NOTE** I am no longer using this library and would like to hand if off to
another maintainer. If you're interested in using this and would like to take
over, please send me a message.
<hr/>

The Disqus Gem helps you easily integrate the [Disqus](http://disqus.com)
commenting system into your Ruby-based website. It includes a Ruby wrapper for
[Disqus's REST API](http://wiki.disqus.net/API), and views helpers to generate
their Javasript widgets.

## What is Disqus?

From the Disqus website:

> "Disqus, pronounced "discuss", is a service and tool for web comments and
> discussions. The Disqus comment system can be plugged into any website, blog,
> or application. Disqus makes commenting easier and more interactive, while
> connecting websites and commenters across a thriving discussion community."
>
> "Disqus is a free service to the general public with absolutely no inline advertisements."


### Getting it

    gem install disqus

### Using it

#### Configure it

  Disqus::defaults[:account] = "my_disqus_account"
  # Optional, only if you're using the API
  Disqus::defaults[:api_key] = "my_disqus_api_key"


#### Options

    :api_key         => "" # your api key
    :account         => "", # your disqus account
    :developer       => false, # allows threads to work on localhost
    :container_id    => 'disqus_thread', # desired thread container
    :avatar_size     => 48, # squared pixel size of avatars
    :color           => "grey", # theme color
    :default_tab     => "popular", # default widget tab
    :hide_avatars    => false, # hide or show avatars
    :hide_mods       => true, # hide or show moderation
    :num_items       => 15, # number of comments to display
    :show_powered_by => true, # show or hide powered by line
    :orientation     => "horizontal" # comment orientation

#### Show the comment threads widget on a post page

    # Loads the commenting system
    <%= raw(disqus_thread) %>

    # Sets the inner html to the comment count for any links on the page that
    # have the anchor "disqus_thread". For example, "View Comments" below would
    # be replaced by "1 comment" or "23 comments" etc.
    # <a href="http://my.website/article-permalink#disqus_thread">View Comments</a>
    # <a href="http://my.website/different-permalink#disqus_thread">View Comments</a>
    disqus_comment_counts

#### Show the combo widget on a post page

    disqus_combo(:color => "blue", :hide_mods => false, :num_items => 20)

#### Show the comment count on a permalink

    link_to("Permalink", post_path(@post, :anchor => "disqus_thread"))
    ...
    disqus_comment_counts

#### Work with the Disqus API

See the Disqus::Api class for more info on the Disqus API. You can also read the
[Disqus developer info here](http://disqus.com/docs/api/).

### Hack it

Github repository:

[http://github.com/norman/disqus](http://github.com/norman/disqus)

### Learn more about Disqus:

[http://disqus.com](http://disqus.com)

### Thanks to the following contributors:

* [Matt Van Horn](http://github.com/mattvanhorn) - Disqus API
* [Quin Hoxie](http://github.com/qhoxie) - Merb support

### Legal Stuff

The Disqus Ruby gem was not created by, nor is officially supported by
Disqus.com or Big Head Labs, Inc. Use it at your own risk and your own
responsibility under the terms of the MIT License.

Copyright (c) 2008-2010 Norman Clarke. Released under the MIT license
