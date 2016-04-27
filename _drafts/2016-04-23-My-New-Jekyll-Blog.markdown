---
layout: post
title:  "My new Jekyll blog."
date:   2016-04-23 17:00:21 +0100
categories: jekyll update
author: Luke
---

I've move my blog to a Jekyll backed static page site, needless to say I'm very happy with how simplistic the setup is.

# Install

Installing the required bits to my development environment was two commands using [chocolatey](https://chocolatey.org/)

{% highlight powershell %}
choco install ruby -y
gem install jekyll
{% endhighlight %}

Chocolately installs ruby what inturn allows me to install Jekyll what is a ruby gem. 

I can create a new blank Jekyll site by running the following after installing Jekyll.

{% highlight powershell %}
jekyll create
{% endhighlight %}

and I can host the site using the Jekyll webserver with

{% highlight powershell %}
jekyll serve 
{% endhighlight %}

# configuration and posts

The _config.yml file allows you to set specific site variables, like description, title and input your github and Twitter usernames. Making a new blog post is simple, create a new markdown file in the _posts folder with the filename representative of the location, for example www.lukemgriffith.CO.UK/2016/04/27/myfirstblogpost.HTML would be a file called 2016-04-27-myfirstblogpost.markdown. 

More to come on how I've automated my build an release process, this is more of a hello I'm here again, with a new site type post.


