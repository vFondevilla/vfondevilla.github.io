---
layout: post
title: Problemas de resolucion DNS en Sierra
---
A veces el sistema operativo Sierra de Apple no resuelve correctamente las direcciones ip por ping pero sí correctamente mediante nslookup. 

```
➜  ~ ping controller.openstack.vfondevilla.com
PING controller.openstack.vfondevilla.com (1.2.3.4): 56 data bytes
Request timeout for icmp_seq 0
^C
--- controller.openstack.vfondevilla.com ping statistics ---
2 packets transmitted, 0 packets received, 100.0% packet loss
```

El arreglo es fácil
```sudo killall -HUP mDNSResponder```

Tras esto, comprobamos que funciona correctamente
```
➜  ~ ping controller.openstack.vfondevilla.com
PING controller.openstack.vfondevilla.com (1.1.1.1): 56 data bytes
64 bytes from 1.1.1.1: icmp_seq=0 ttl=62 time=3.265 ms
````


