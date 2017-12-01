---
layout: post
title: Reservas DHCP en VMware Fusion
---

Debido a que tengo multitud de máquinas en mi MBPr que no se terminan de llevar muy bien con DHCP (Hola, que tal Microsoft Active Directory?), creo este post sobre las reservas DHCP en VMware Fusion, que viene muy bien de cara a mantener cierta "coherencia" en el arranque.

En VMware Fusion, la configuración dhcp de las distintas redes se encuentra localizada en ```/Library/Preferences/VMware\ Fusion/vmnet[loquesea]/dhcpd.conf```

Para poder asignar reservas a las distintas VMs, necesitaremos conocer la MAC de la VM, esto se puede hacer rápidamente de la siguiente forma:

```
➜  ~  cat Documents/Virtual\ Machines.localized/BootCamp.vmwarevm/BootCamp.vmx | grep "ethernet0.generatedAddress =" 
```
Lo que nos devolverá la MAC de la VM

```
ethernet0.generatedAddress = "00:0C:29:38:E3:9D"
```

Con este dato, procedemos a editar el fichero dhcpd.conf correspondiente, después de la última línea, añadiremos lo siguiente:
```
host BootCamp {
	hardware ethernet 00:0C:29:38:E3:9D;
	fixed-address 172.16.32.3;
	}
```
Con esto, una vez la VM arranca, siempre tendrá asignada la misma IP, sin tener que mirar la IP que le ha asignado el dhcp de VMware Fusion.

Tras esto, solo tenemos que reiniciar el servicio de networking
```sudo /Applications/VMware\ Fusion.app/Contents/Library/vmnet-cli --stop && sudo /Applications/VMware\ Fusion.app/Contents/Library/vmnet-cli --start```