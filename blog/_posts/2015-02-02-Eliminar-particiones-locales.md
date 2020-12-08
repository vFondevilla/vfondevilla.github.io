---
layout: post
title: Eliminar particiones locales de un disco en ESXi
---

Hoy enchufando un disco SATA de 2.5mm proveniente de mi Synology 412+ a mi Intel NUC i3 me he encontrado con el problema de no poder añadir el storage ya que tenía 3 particiones MBR creadas por el Synology.

Mediante PartedUtil de VMware puedes borrar las particiones locales dejando un disco en blanco listo para ser usado.
Primero listamos los dispositivos con sus particiones, los que me interesan son los de t10.ATA\_\_\_\_\_Hitachi_HTS545050B9A300_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_\_110529PBN408372UDSUE que corresponde a un disco Hitachi de portátil

```
~ # ls /dev/disks/
mpx.vmhba32:C0:T0:L0
mpx.vmhba32:C0:T0:L0:5
mpx.vmhba32:C0:T0:L0:6
mpx.vmhba32:C0:T0:L0:7
mpx.vmhba32:C0:T0:L0:8
mpx.vmhba32:C0:T0:L0:9
t10.ATA_____Hitachi_HTS545050B9A300_________________110529PBN408372UDSUE
t10.ATA_____Hitachi_HTS545050B9A300_________________110529PBN408372UDSUE:1
t10.ATA_____Hitachi_HTS545050B9A300_________________110529PBN408372UDSUE:2
t10.ATA_____Hitachi_HTS545050B9A300_________________110529PBN408372UDSUE:3
t10.ATA_____KINGSTON_SMS200S360G____________________50026B724A079750____
t10.ATA_____KINGSTON_SMS200S360G____________________50026B724A079750____:1
vml.0000000000766d68626133323a303a30
vml.0000000000766d68626133323a303a30:5
vml.0000000000766d68626133323a303a30:6
vml.0000000000766d68626133323a303a30:7
vml.0000000000766d68626133323a303a30:8
vml.0000000000766d68626133323a303a30:9
vml.010000000031313035323950424e3430383337325544535545486974616368
vml.010000000031313035323950424e3430383337325544535545486974616368:1
vml.010000000031313035323950424e3430383337325544535545486974616368:2
vml.010000000031313035323950424e3430383337325544535545486974616368:3
vml.010000000035303032364237323441303739373530202020204b494e475354
vml.010000000035303032364237323441303739373530202020204b494e475354:1
```

Una vez localizados (los número :1, :2, :3 son las particiones del disco), podemos proceder a eliminarlos de la tabla de particiones del disco, para poder dejarlo en blanco

```
~ # partedUtil delete "/vmfs/devices/disks/t10.ATA_____Hitachi_HTS545050B9A300__
_______________110529PBN408372UDSUE" 1
~ # partedUtil delete "/vmfs/devices/disks/t10.ATA_____Hitachi_HTS545050B9A300__
_______________110529PBN408372UDSUE" 2
~ # partedUtil delete "/vmfs/devices/disks/t10.ATA_____Hitachi_HTS545050B9A300__
_______________110529PBN408372UDSUE" 3
```

Una vez eliminados el disco está listo para ser usado por nuestro ESX como storage local.
