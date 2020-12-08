---
layout: post
title: Como montar un Exchange 2013 en un Resource Forest - Parte 2
---

En este caso seguiremos con el despliegue de Exchange 2013 en la VM que hemos desplegado con Windows 2012R2.

Instalaremos los pre-requisitos necesarios

```Powershell
Add-WindowsFeature Web-Asp-Net,Web-Client-Auth,Web-Dir-Browsing,Web-Http-Errors,Web-Http-Logging,Web-Http-Redirect,Web-Lgcy-Mgmt-Console,Web-Metabase,Web-WMI,Web-Net-Ext,Web-Basic-Auth,Web-Digest-Auth,Web-Dyn-Compression,Web-Stat-Compression,Web-Windows-Auth,Web-ISAPI-Filter,Web-Request-Monitor,Web-Static-Content,Web-Http-Tracing,WAS-Process-Model,Web-Mgmt-Console,Desktop-Experience,NET-Framework-Core,RPC-over-HTTP-Proxy,Telnet-Client,RSAT-Clustering,RSAT-ADDS,GPMC,Failover-Clustering,RSAT-Clustering-CmdInterface –Restart
```

Instalaremos los roles de CAS y de Mailbox en el servidor (lo siento, pero no tengo capturas de pantalla de esto, estaba fuera mientras se hacía :) )
Una vez instalado y reiniciado, empezaremos a meternos en materia.

En el AD del dominio cliente.local crearemos la OU de UsuariosExchange y un conjunto de usuarios de origen.

```Powershell
Import-Module ActiveDirectory
New-ADOrganizationalUnit -Name UsuariosExchange -Path 'dc=cliente,dc=local' -ProtectedFromAccidentalDeletion:$false

$password="P@ssw0rd!"
1..100 | Foreach-Object {
$r = Get-Random -Minimum 0 -Maximum 10
New-ADUser -Name "newtestuser$_" -Path "ou=UsuariosExchange,dc=cliente,dc=local" -Enabled $True -AccountPassword (ConvertTo-SecureString $password -AsPlainText -force) -PasswordNeverExpires $True}
```

Tras esto podremos comprobar en el DC que los usuarios existen
![User Creation]({{ site.url }}/img/exchange/Exchange02-10ret.png)

En el Exchange entramos en la EAC (https://localhost/ecp/) con las credenciales de test\Administrator, configuraremos la zona horaria (esto solo has de hacerlo la primera vez que entras)
En el listado de Destinatarios (Mailboxes en inglés), crearemos un nuevo Buzón vinculado ("linked mailbox")
![User Creation]({{ site.url }}/img/exchange/Exchange02-5.png)

Seleccionamos el Bosque ("Forest") de confianza.
![User Creation]({{ site.url }}/img/exchange/Exchange02-2.png)

Al ser una confianza en un único sentido, necesitareis introducir las credenciales de una cuenta con permisos del dominio cliente.local (yo he usado Administrator).
![User Creation]({{ site.url }}/img/exchange/Exchange02-6.png)

Seleccionaremos la cuenta que queremos linkar
![User Creation]({{ site.url }}/img/exchange/Exchange02-7.png)
![User Creation]({{ site.url }}/img/exchange/Exchange02-4.png)

En el siguiente paso definiremos cual es la cuenta del Resource Forest que vamos a crear.
![User Creation]({{ site.url }}/img/exchange/Exchange02-8.png)
**Nota:** Las cuentas que se creen se van a crear en la OU que tú les digas quedando desactivadas, te recomiendo las dejes por separado para no liar las cuentas :)

Y con esto se termina! Ya tenéis las cuentas linkadas entre los dominios Resource y Account, puedes verificarlo en el listado de Buzones
![User Creation]({{ site.url }}/img/exchange/Exchange02-1.png)

Desde un equipo del otro dominio accedes a la URL del ECP (https://192.168.30.30/owa/) y accedemos con las credenciales de cliente\newtestuser1.
![User Creation]({{ site.url }}/img/exchange/Exchange02-3.png)

Tras esto, habréis accedido al buzón del usuario. ¿Fácil no? Pues esto solo es una pequeña muestra de lo que puedes conseguir. Próximamente haremos cosas más avanzadas con el Exchange 2013
