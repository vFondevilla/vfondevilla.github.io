---
layout: post
title: Comprobar la versión de Exchange [Versión Quick&Dirty]
date: 2014-07-03 10:04
author: victor
comments: true
categories: [Uncategorized]
---
En una ventana de EMS ejecutar:

gcm exsetup | %{$_.fileversioninfo}

&nbsp;

Y con el ProductVersion, compararlo en esta página:

http://social.technet.microsoft.com/wiki/contents/articles/240.exchange-server-and-update-rollups-build-numbers.aspx
