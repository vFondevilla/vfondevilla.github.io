---
layout: post
title: Como montar un Exchange 2013 en un Resource Forest - Parte 1
---

En mi papel como Solution Architect en Claranet, a veces tengo que vérmelas con entornos no estándar. Como apunte para mí en futuras ocasiones y para cualquier otra persona que pueda encontrarse con la misma situación, voy a desplegar un Exchange 2013 en un resource forest.

Para las personas que no sepan lo que es un *Exchange en resource forest*, es una modalidad de despliegue del Exchange que separa los objetos del AD original (usuarios principalmente) de los objetos de AD de Exchange (y otras aplicaciones corporativas que puedan llegar a desplegarse en este esquema).
Mediante relaciones de confianza y *linkando* los mailbox con los usuarios, haremos que funcionen de forma coordinada, aumentando la seguridad y también un poco la complejidad administrativa del entorno.

Desplegamos varias VMs (en mi caso sobre mi homelab, sobre VMware vSphere 5.5), en un portgroup aislado, en este caso desplegaremos dos Domain Controllers y un servidor de Exchange 2013.
Para las distintas VMs asignaremos los siguientes recursos:

* Domain Controller Exchange - 1 vCPU - 2GB RAM - 60 GB HD

* Domain Controller Cliente - 1 vCPU - 2GB RAM - 60 GB HD

* Exchange 2013 - 1 vCPU - 6GB RAM - 60 GB HD

Instalamos los distintos *Domain Controllers* mediante Powershell. En este caso, desplegamos el dominio *cliente.local* que será nuestro *account domain*

```Powershell
add-windowsfeature AD-Domain-Services DNS GPMC RSAT RSAT-Role-Tools RSAT-AD-Tools RSAT-AD-PowerShell RSAT-ADDS RSAT-AD-AdminCenter RSAT-ADDS-Tools RSAT-DNS-Server
Import-Module ADDSDeployment
Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "Win2012R2" `
-DomainName "cliente.local" `
-DomainNetbiosName "CLIENTE" `
-ForestMode "Win2012R2" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true
```

Repetimos el mismo paso con el Domain Controller del dominio test.local

Tras estos pasos, procedemos a configurar los forwarders de DNS desde el DNS Manager

Desplegamos el árbol del servidor
![DNS Forwarder]({{ site.url }}/img/exchange/Exchange11.png)

En Conditional Forwarders, vamos a crear uno nuevo
![DNS Forwarder]({{ site.url }}/img/exchange/Exchange13.png)

Añadimos el nombre del Dominio y la dirección del Domain Controller
![DNS Forwarder]({{ site.url }}/img/exchange/Exchange14.png)

Tras esto, crearemos desde el *Resource Forest* una confianza *Outgoing* hacia el dominio cliente.local
![Domain trust creation]({{ site.url }}/img/exchange/Exchange01.png)
![Domain trust creation]({{ site.url }}/img/exchange/Exchange02.png)
![Domain trust creation]({{ site.url }}/img/exchange/Exchange03.png)
![Domain trust creation]({{ site.url }}/img/exchange/Exchange04.png)
![Domain trust creation]({{ site.url }}/img/exchange/Exchange05.png)
![Domain trust creation]({{ site.url }}/img/exchange/Exchange6.png)
![Domain trust creation]({{ site.url }}/img/exchange/Exchange7.png)
![Domain trust creation]({{ site.url }}/img/exchange/Exchange8.png)
![Domain trust creation]({{ site.url }}/img/exchange/Exchange9.png)
![Domain trust creation]({{ site.url }}/img/exchange/Exchange10.png)

Tras haberla creado, podremos ver en Active Directory Domains and Trusts de cliente.local la confianza.
![Domain trust creation]({{ site.url }}/img/exchange/Exchange15.png)
Para los que sois Powershell lovers... os dejo el snippet para hacerlo mediante PS!
En la última línea es donde fijais el tipo de confianza a Outbound (podeis usar Inbound o Bidirectional, pero en este caso aplica la Outbound)

```Powershell
$localforest = [System.DirectoryServices.ActiveDirectory.Forest]::getCurrentForest()
$strRemoteForest = ‘cliente.local’
$strRemoteUser = ‘administrator’
$strRemotePassword = ‘Passw0rd!nventada’
$remoteContext = New-Object System.DirectoryServices.ActiveDirectory.DirectoryContext(‘Forest’, $strRemoteForest,$strRemoteUser,$strRemotePassword)
$remoteForest = [System.DirectoryServices.ActiveDirectory.Forest]::getForest($remoteContext)
$localForest.CreateTrustRelationship($remoteForest,’Outbound’)
```

Con esto, doy por terminado el primer paso de configurar los Domain Controllers
