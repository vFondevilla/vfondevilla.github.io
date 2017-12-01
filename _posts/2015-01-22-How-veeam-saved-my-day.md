---
layout: post
title: How veeam saved my day (at homelab)
---

I was deploying PernixData (great software btw) when by some reason (I don't know why yet) after rebooting vCenter Server Appliance, I had a blank screen and 99% CPU usage.
I tried to do a Instant Recovery with my Veeam Backup & Replication v8, but I had my managed servers under my vCenter in Veeam, so I had a big problem, I couldn't recover my VCSA (albeit I had a Veeam Backup of that same afternoon). If you meet sometime in this situation, I can tell you... That's FUBAR.

But there's a fix (always there's a fix), just simply add another *Managed Server* on the other way you can identify it (If in your vCenter you are using IP, use FQDN to add it) and make a full recovery :)

That will fix it!

P.S: I'm reading this post right now and I realize that It seems wrote by some-3-years-old kid, but in the moment I wrote this I had been awake 24 hours in a row (an incident with the bigger client), so I'm sorry if the writing offends your eyes ;)
