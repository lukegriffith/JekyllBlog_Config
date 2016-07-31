---
layout: post
title:  "Cross Platform PowerShell Testing."
date:   2016-07-23 17:00:21 +0100
categories: PowerShell Pester Mac VirtualBox
author: Luke
---

# The Problems.
So, my home rig is a custom build desktop PC running windows 10 but before i discovered PowerShell i was trying to learn Python and UNIX systems so i bought a mac and started learning BASH. When i got into PowerShell development I made the (terrible) decision to install win10 using bootcamp. The reliability of Windows with the price tag of a Mac (Why oh why!!) 

So Bootcamp is a bad idea, the operating system has terrible hardware access and things like battery consumption during sleep made the laptop pretty useless and not very portable. So now we're on OSx el capitan. My first problem... How the hell do i develop PowerShell on this bad boy? Ok ok... I've got VS Code it has native PowerShell syntax highlighting, but thats not really \*nix enough for me, VIM has an extension for PowerShell syntax highlighting - woo, ok so thats installed. Step one I have a colourful editor. 

Second problem. Although PowerShell is roumered to be going OpenSource and maybe one day we'll see a linux port but currently... I can't really run PowerShell and Pester on Mac, so what can I do?

# The Solution

So, first off I needed a hypervisori to run windows on and the only one I know thats cross platforms is Oracles VirtualBox - the command line interface is a bit clunkly but VBoxManage appaers to work OK, i can start VM's i can query states - for what I need this should do.

The operating system, so far I've not really played with server 2016, so I grabbed the iso from MSDN and installed it unfortunately I haven't automated the setup of the VM but potentially this could come later. After installing the Operating System I needed to setup a shared machine folder so I can have a share between my Mac and the windows server, using the shared folders in virtual box I was able to setup my TestingFramework share. 

Next I configured winlogon to automatically login an Administrative user setting the default username, default password and changing the shell to execute PowerShell.exe natively on boot, the script i used to alter these settings can be found here [link](https://github.com/lukemgriffith/TestLauncher/blob/master/posh/TestUser.ps1)

So now when the VM starts it immediately logs in and starts PowerShell. Now I need to initiate my testing framework to execute what I need and extract the results. PowerShell natively loads profile.ps1 when it starts so I can leverage this to start my workflow. 

## Powershell Scripts
The below scripts control the automation for when the Windows Server starts, it controls what is tests how it executes them tests in what conditions and then shuts the server down capturing a transcript of the whole process. See below for details


# Profile.ps1
[link](https://github.com/lukemgriffith/TestLauncher/blob/master/posh/profile.ps1) 

The PowerShell profile loads from the users WindowsPowerShell folder located in the users documents folder and can be found via the variable $PROFILE, as the profile I will be developing will be located in the TestingFramework shared folder, I first need to deploy a basic copy that checks for updates from the share. For this is use a function called CheckProfileUpdate this obtains a filehash of both the TestingFolder profile and the local profile and if they differ the local will be over written and the machine restarted. 
 
Following this i initiate a transcript thats logged out, and then import dependant modules Pester and psake from the modules folder in testing framework. After that step i initiate the launch.ps1 script located in TestingFramework

# Launch.ps1
[link](https://github.com/lukemgriffith/TestLauncher/blob/master/posh/launch.ps1)

This script at the moment is reletively simple - It sets the location of the shell to the Development Modules folder and Invoke-Pester, with the NUnitOutput exported to the TestingFramework. This script it tasked with executing your tests, it might need to import modules, it can invoke a psake task list but for now its a simple invoke-pester.

# Shutdown.ps1
[link](https://github.com/lukemgriffith/TestLauncher/blob/master/posh/shutdown.ps1)

Very simple, as it states it shuts the server down after testing is completed.



## BASH scripts

# startvm.sh
This script probably took me the most time and took a little bit of Google Foo to completed. This is actually my first bash script and I'm rather proud of it. Very simply it uses VBoxManage to start the windows server headlessly, as the previous parts have stated from boot it will execute PowerShell and start the scripted process and end with turning the server back off after completing the testing. 

While the windows server is performing its testing process, i have the shell script enter a wait loop and it queries VBoxManage to check the state of the VM, once it sees its turned off it ends the loop and launches less on the recent transcript. This allows me to jump straight into the results of my tests following the execution and if any issues occured during the run. 


 






