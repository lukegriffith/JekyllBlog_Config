---
layout: post
title:  "Class based DSC, and the limitations."
date:   2016-06-16 20:00:21 +0100
categories: PowerShell DSC
author: Luke
---

## Inheritance 

A great explanation of inheritance, within the context of PowerShell can be found [here](https://www.youtube.com/watch?v=Lfx_H36GRKg) and is basically a way of defining a base class. If I'm a car, I will always have wheels but I might be a hatchback or an estate that will have other properties.     

With class based DSC providers, you might be tricked into thinking you might be able to do this, I've been testing things for a while but haven't managed yet. Potentially I'm missing something simple but I think otherwise.

It looks like the DSC framework does some static analysis of some type to determine if the resource is valid. Likely behind the scenes something like WMF4 schema.mof is generated.

If you look at this [project](https://github.com/lukemgriffith/DSCInheritance) I've setup the deployment of my environment via psake, and everything is available to test my hypothesis.

Running the test task, the DSC framework managed to compile a MOF based on my inheritedResource, if I call Get-DSCResource, I can see the resource and its properties as you'd expect them to be, or that you would see if you instantiated a new instance of the class. 

{% highlight powershell %}

PS wrk:\> Get-DscResource -Name InheritedResource

ImplementedAs   Name                      ModuleName                     Version    Properties
-------------   ----                      ----------                     -------    ----------
PowerShell      InheritedResource         InheritedResource              1.0        {Enforce, Ensure, SettingName, DependsOn...}

 {% endhighlight %}

So the framework lets me compile my mof and has the instructions, yet when the psake job gets to actually applying the configuration we fall short. 



{% highlight powershell %}

PS wrk:\> Invoke-psake -buildFile .\build.ps1 -taskList test
psake version 4.6.0
Copyright (c) 2010-2014 James Kovacs & Contributors

Executing test



Describing InheritedResource
   Context Compiling
    [+] Has build mof from configuration. 274ms
Tests completed in 274ms
Passed: 1 Failed: 0 Skipped: 0 Pending: 0 Inconclusive: 0
VERBOSE: Perform operation 'Invoke CimMethod' with following parameters, ''methodName' = SendConfigurationApply,'className' = MSFT_DSCLocalConfigurationManager,'namespaceName' = root/Microsoft/Windows/DesiredStateConfiguration'.
VERBOSE: An LCM method call arrived from computer LGDESKTOP with user sid S-1-5-21-344822527-548070493-3557901143-1001.
VERBOSE: [LGDESKTOP]: LCM:  [ Start  Set      ]
VERBOSE: [LGDESKTOP]: LCM:  [ End    Set      ]
Error: 16/06/2016 20:37:53:
 +     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ [<<==>>] Exception: The PowerShell DSC resource InheritedResource from module <InheritedResource,1.0> does not exist at the PowerShell module path nor is it registered as a WMI DSC resource.
 {% endhighlight %}

The error I get is that the resource isn't registered as a WMI Resource, or at the PS Module path. This isn't entirely correct it is present in my PowerShell module path - but it’s not registered as a WMI DSC Resource.

If I look at the DSC namespace, I can see my other custom class based resource providers are registered, for example PSClient. I get to see the properties and the class name. 

{% highlight powershell %}

PS wrk:\> Get-CimClass -Namespace  root/Microsoft/Windows/DesiredStateConfiguration | ? {$_.CimClassName -eq "PSClient"}


   NameSpace: ROOT/Microsoft/Windows/DesiredStateConfiguration

CimClassName                        CimClassMethods      CimClassProperties
------------                        ---------------      ------------------
PSClient                            {}                   {ConfigurationName, DependsOn, ModuleName, ModuleVersion...}

 {% endhighlight %}

 Unfortunately my inheritedResource isn't registered.
 
 
 In WMF4 to register a DSC resource in this manner you have to create a MOF class, and register the properties against it, defining keys etc. This was why the implementation of classes in WMF5 was so exciting as it removed that restriction but unfortunately it looks like when you start doing some complex object models the framework cannot flesh out the details.

 Potentially I've done something wrong, if anyone think they can correct me send me a tweet, or even pull the repo and fix it :) Would love to see a working implementation of this. 
 
   

