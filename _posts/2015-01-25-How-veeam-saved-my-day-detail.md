---
layout: post
title: How veeam saved my day (at homelab) - Explained in detail
---

After writing the post [How veeam saved my day (at homelab)] ({% post_url 2015-01-22-How-veeam-saved-my-day %}) and some DMs and mentions about it, I'm writing some-detailed how-to. Enjoy it :)

When I restarted my VCSA appliance, It got stuck on boot, showing nothing, being unresponsive and consuming 100% CPU, so I tried to recover from Veeam Backup v8( thank to Veeam for the NFR! ). I had some big troubles because my ESX host was dependant from VCSA and Veeam couldn't contact vCenter Server for registering and deploying the new machine.

Searching on Google I stumbled upon a post in Veeam forum who directed me to the solution.

1. Open the Veeam B&R console and press the "Backup Infrastructure" button
![veeam backup infrastructure]({{ site.url }}/img/veeam/backup1.png)

2. Open the "Managed Servers" display list
![veeam backup managed servers]({{ site.url }}/img/veeam/backup2.png)

3. Right clic on "VMware vSphere" and "Add Server"
![veeam backup managed servers]({{ site.url }}/img/veeam/backup3.png)

4. Add the server. If you used IP for adding it on your vCenter, use FQDN to add it on Veeam. If you used FQDN, use IP.
![veeam backup managed servers]({{ site.url }}/img/veeam/backup4.png)


Now you can do a new restore, on the new host and overwrite the old one, recovering the VCSA
