---
layout: post
title:  "Enter-PsHostProcess"
date:   2016-07-23 20:00:21 +0100
categories: powershell 
---

New to WMF 5 is a command called Enter-PSHostProcess, this allows you to point to the ID of a process that is running the Windows PowerShell engine ( this involves you creating a Runspace or PowerShell instance within your program. )  


This has a number of uses, one being its debugging and automation capabilities being able to configure app domain settings in an automated manner. 

https://gist.github.com/lukemgriffith/51dabd4f3aa62e8da5ecdff498df3338

[  ]

