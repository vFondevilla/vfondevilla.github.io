---
layout: post
title: How to add a datastore to all vSphere Hosts
---
```Powershell
Connect-VIServer vcenter

get-vmhost | new-datastore -name syn-nfs-iso -nfs -path /volume7/iso2 -nfshost nfs.test.local
```
