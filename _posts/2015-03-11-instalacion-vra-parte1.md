---
layout: post
title: vRealize Automation - Pre-requisitos y desplegando SSO
---

Empiezo esta serie de posts respecto al despliegue de la suite *vRealize Automation*, anteriormente conocida como *vCloud Automation Center* o vCAC. Para los que no conozcan esta suite de VMware, es la evolución de *vCloud Director*, añadiendo la posibilidad de desplegar workloads en cloud público (Amazon, vCloud Air...)


En este caso, vamos a desplegar 3 VMs para dar el servicio, que son la Identity Appliance (o SSO), el componente IaaS y la appliance *vRealize Automation* y aprovecharé un servidor con SQL Server 2014 que ya tengo desplegado en el homelab para alojar la BBDD de vRA.

Como pre-requisitos, debemos tener un *Active Directory* presente, con sus funciones de DNS ya que el software requiere de trabajar con FQDNs. En este caso vamos a trabajar con el dominio vfondevilla.local que es el dominio de mi homelab

Para la parte de SQL Server del componente IaaS, necesitaremos:

* Que el protocolo TCP/IP esté habilitado en MS SQL Server
* Microsoft Distributed Transaction Coordinator Service (MS DTC) en todos los nodos de SQL
* Puertos entre las distintas máquinas abiertos, si tienes dudas de cuales son, revisa la documentación de *vRealize Automation*


Procedemos a desplegar la Identity Appliance, rellenando los menús del OVF correspondientes, en este caso los datos de mi laboratorio son los siguientes:

* Dirección IP: 192.168.1.247/24
* Gateway: 192.168.1.2
* Hostname: vcac-identity.vfondevilla.local


Tras haber desplegado la appliance, procederemos a conectarnos a https://vcac-identity.vfondevilla.local:5480, donde nos aparecerá la VAMI de la appliance y nos logaremos con las credenciales introducidas en el momento de desplegar la appliance.

Configuraremos la zona horaria, en mi caso Europe/Madrid, y en la pestaña Admin/Time Settings, lo configuraremos en modo "Use Time Server" e introduciremos la IP del controlador de dominio.
![vRA setup]({{ site.url }}/img/vra/vra1.png)

Como curiosidad, la contraseña de administrador de la appliance caduca en un año, y por lo que he visto no se puede deshabilitar que caduque, así que ojito con la bomba de tiempo que nos deja VMware!

La siguiente parte será la configuración del SSO, donde introduciremos la contraseña del usuario *administrator* del dominio *vsphere.local* que es el de por defecto.
![vRA setup]({{ site.url }}/img/vra/vra2.png)

 Tras haber cambiado la contraseña (puede tardar un par de minutos), pasaremos a la sección *Host settings* donde verificaremos que el nombre es correcto. En otras versiones de *vRealize Automation* o *vCAC* en esta parte había que añadir :7444 en el hostname de la appliance, pero en la versión 6.2 ya no nos hará falta hacerlo.


A continuación generaremos un certificado autofirmado (o si teneis un SSL, lo procederemos a importar)
![vRA setup]({{ site.url }}/img/vra/vra5.png)


Por último, uniremos nuestro appliance al *Active Directory* para el control del login, en la pestaña *Active Directory*, introduciremos los datos del *Active Directory* y presionaremos en apply.
En mi caso en un primer momento me dió error:
*Warning: Cannot resolve domain controller IP address 192.168.1.252.
There is a network misconfiguration. Check the host name, DNS Servers, and DHCP settings on the Network tab. You may need to restart the appliance after changing the network configuration.*

Esto es debido a que no podía resolver la ip del DNS, en la pestaña Network, Address vi que falta el Domain Name, lo añadí y ya se unió correctamente al dominio.

Tras esto, hemos completado de desplegar la Identity Appliance del vRA en nuestro laboratorio.
