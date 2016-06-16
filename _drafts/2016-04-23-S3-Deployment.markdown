---
layout: post
title:  "Deploying a Jekyll blog to S3 via PowerShell."
date:   2016-04-23 17:00:21 +0100
categories: jekyll aws powershell s3
---
I use Amazon web services to host this site, the content sits on an S3 bucket in Ireland and I use Amazon's CloudFront to ensure fast delivery to whoever requests. Because I use Jekyll the site is all static files meaning no external APIs are being called so there's no JavaScript plugin waiting around for content to be delivered back. 
All my site content it located within a git repository, and I use a powershell script with the AWS module for powershell to write that directory straight to the root of my S3 bucket, this is done after sanitising the environment (should probably remove the delete as the site would be unavailable),

The script is a simple few lines, and I have it executed via visual studio codes 


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


# Configuring CloudFront

