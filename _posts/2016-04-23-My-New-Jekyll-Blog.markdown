---
layout: post
title:  "My new Jekyll blog."
date:   2016-04-23 17:00:21 +0100
categories: jekyll update
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





# S3 Deployment

{% highlight powershell %}

Import-Module "C:\Program Files (x86)\AWS Tools\PowerShell\AWSPowerShell"

$VerbosePreference = 'Continue'

$data = ConvertFrom-StringData (Get-AwsCredential)

$cred = New-AWSCredentials -AccessKey $data.AWSAccessKeyId -SecretKey $data.AWSSecretKey

Write-Verbose "Cleaning bucket..."

Get-S3Object -BucketName $bucket -KeyPrefix "\" -Credential $cred | Remove-S3Object -BucketName $bucket -Force -Credential $cred

Write-Verbose "Starting Upload"

Write-S3Object -BucketName $bucket -Folder $_site -Recurse -Credential $cred -KeyPrefix '\' -Verbose

{% endhighlight %}
