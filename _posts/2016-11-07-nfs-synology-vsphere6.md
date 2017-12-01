---
layout: post
title: Plugin NFS VAAI de Synology en VMware vSphere 6.0
---
Como no es la primera vez que me lo preguntan, sí, el plugin de VAAI de vSphere, que según el README de Synology es solo para versión 5.5, funciona correctamente en VMware vSphere 6.0. Lo he instalado en los hosts del laboratorio, con el comando que detalla el README, añadiendo --no-sig-check al final.

Quedaría de la siguiente forma:
```
esxcli software vib install -v /esx-nfsplugin.vib --no-sig-check
```

Después de reiniciar los hosts, veremos que en la opción de "Hardware Acceleration" aparecerá "Supported"