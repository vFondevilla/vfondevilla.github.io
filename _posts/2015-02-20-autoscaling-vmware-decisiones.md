---
layout: post
title: Autoscaling en VMware - Diseño Parte 2 - Decisiones
---

En este post detallaré las decisiones que tomo en cuanto al diseño y detallo un poco más la infraestructura a usar.

En cuanto a la infraestructura a usar, lo haré sobre mi homelab, con 2 ESX (1 de gestión y 1 de "producción"), 1 NAS Synology DS412+ y un Switch Cisco SG300-10.
Provisiono una red 192.168.30.0/24 que será la red principal del escenario. El *default gateway* será el propio Cisco, con un SVI (*Switch Virtual Interface*) en la Vlan30.

La configuración pertinente del Cisco en cuanto al SVI es esta

```
interface vlan 30
 name VM-Network-to-NUC-and-ESX
 ip address 192.168.30.1 255.255.255.0
 ip dhcp relay enable
!
```
Como veis, he activado el dhcp relay, ya que tengo un DHCP funcionando sobre Windows 2012R2 en mi ESX de Management, y será el encargado de repartir las direcciones en el scope de la Vlan30. La configuración es la siguiente:

```
ip dhcp relay address 192.168.1.252
ip dhcp relay enable
ip dhcp information option
```


En cuanto a nivel de software:

* En la capa de hypervisor se usará VMware vSphere 5.5U2
* Se desplegará la appliance vCenter Orchestrator (ya que uso el vCenter Server Appliance como vCenter del homelab) para crear los flows que hará el *kick-off* del despliegue de una VM
* Usaré un servidor on-premise de Chef, en su versión gratuita
* Se creará una customization para el template que configurará el NTP, el usuario Administrator y la contraseña común a las distintas VMs, sin necesidad de apoyarse en un dominio de Active Directory
* Usaré Windows 2012R2, con una template preparada con un poco del conocimiento propio y mucho del conocimiento de Google :)
* Usaré la versión Standard de SQL Server 2014