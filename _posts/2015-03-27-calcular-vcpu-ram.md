---
layout: post
title: Como calcular vCPUs y vRAM provisionadas en un cluster de VMware
---

Muchas veces nos preguntamos cuantas vCPUs tenemos provisionadas para mantener la contención controlada, al igual que la RAM que tenemos provisional (que no activa) en las VMs. Desde la PowerCLI de VMware podemos ejecutar lo siguiente:

**Memoria RAM provisionada**

```Powershell
(get-datacenter virtualdatacenterName | get-cluster | get-vm | measure-object 'memoryGB' -sum).sum
```

**vCPUs provisionadas**

```Powershell
(get-datacenter virtualdatacenterName | get-cluster | get-vm | measure-object 'numcpu' -sum).sum
```

Con esto, obtentendreis los valores :)