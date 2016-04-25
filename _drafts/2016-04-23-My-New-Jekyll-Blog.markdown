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

I can create a new blank Jekyll site by running

{% highlight powershell %}
jekyll create
{% endhighlight %}

and I can host the site using the Jekyll webserver with

{% highlight powershell %}
jekyll serve 
{% endhighlight %}




