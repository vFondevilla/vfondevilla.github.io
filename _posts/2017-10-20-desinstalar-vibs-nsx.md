---
layout: post
title: Como eliminar VIBs de NSX manualmente
---
Hay ciertos momentos en que la desinstalación de los VIBs de NSX falla, por diversos motivos, por ejemplo por un problema de comunicación entre vCenter y los hosts ESXi. En ese caso, tendremos que desinstalar de forma manual los VIBs que se utilizan por NSX, siendo este el procedimiento:

1. Ponemos el host en modo mantenimiento
2. Entramos por SSH al host
3. Ejecutamos: ```esxcli software vib remove -n esx-vxlan``` que nos debería devolver el siguiente resultando:
```
   Removal Result
   Message: Operation finished successfully.
   Reboot Required: false
   VIBs Installed:
   VIBs Removed: VMware_bootbank_esx-vxlan_6.5.0-0.0.5534171
   VIBs Skipped:
```
4. Ejecutamos: ```esxcli software vib remove -n esx-vsip``` que nos debería devolver el siguiente resultado:
```
Removal Result
   Message: Operation finished successfully.
   Reboot Required: false
   VIBs Installed:
   VIBs Removed: VMware_bootbank_esx-vsip_6.5.0-0.0.5534171
   VIBs Skipped:
```

Tras estos comando solo nos queda reiniciar el host para que quede completamente limpio de los VIBs.