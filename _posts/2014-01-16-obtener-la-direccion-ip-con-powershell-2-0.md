---
layout: post
title: Obtener la dirección IP con Powershell 2.0
date: 2014-01-16 14:37
author: victor
comments: true
categories: [powershell, Uncategorized, Windows, windows]
---
En los servidores que aún tienen Powershell 2.0 (Windows 2008R2 principalmente), si necesitais sacar la dirección IP únicamente (y no quereis hacer string-mangling), podeis obtenerla con el siguiente comando:

(Get-WmiObject Win32_NetworkAdapterConfiguration -Namespace "rootCIMV2" | where{$_.IPEnabled -eq "True"}).IpAddress
