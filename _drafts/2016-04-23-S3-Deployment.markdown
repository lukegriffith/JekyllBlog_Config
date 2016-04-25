---
layout: post
title:  "Deploying a Jekyll blog to S3 via PowerShell."
date:   2016-04-23 17:00:21 +0100
categories: jekyll aws powershell s3
---

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