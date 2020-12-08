---
layout: post
title: "Adding all VMX in a Datastore"
---

After some weird network failure on one of my homelab's host, I unregistered all the VMs of a datastore.. After fixing the problem I had to re-register them in vCenter. I hate doing clicky-clicky a lot of times so... From PowerCli I executed this one-liner

```Powershell
dir 'vmstores:\vCenterHostnameOrIP@443\DataCenterName\DatastoreName\*\*.vmx' | foreach {New-VM -Host $esxhost -VMFilePath $_.DatastoreFullPath}
 ```

 And voilá! All the VMs got automagically registered.

 PowerCLI Baby!!
