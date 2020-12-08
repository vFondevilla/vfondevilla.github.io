---
layout: post
title: Configurando iSCSI a golpe de Powercli
---

Hoy os traigo una breve entrada sobre como configurar iSCSI sobre uno (o varios) hosts vSphere a golpe de teclado. Podríamos usar ansible, pero como estoy repasando para el VCAP-DCA... Lo haremos a base de Powershell!

Conectamos con el vCenter

```Connect-VIServer vcenter.vfondevilla.com -User administrator@vsphere.local -Password P@ssw0rd!```

Creamos el adaptador iSCSI

```Get-VMHostStorage -VMhost vesx01.vfondevilla.com | Set-VMHostStorage -SoftwareIScsiEnabled $True```

Creamos el target iSCSI en la HBA que acabamos de crear

```get-vmhost vesx01.vfondevilla.com | get-vmhosthba -type "iscsi" |New-IScsiHbaTarget -Address 192.168.30.254```

Bindeamos el adaptador a la interfaz VMK

```(get-esxcli -VMHost vesx01.vfondevilla.com).iscsi.networkportal.add("vmhba33", $true, "vmk0")```

Tras esto, haremos un rescan de las HBA

```Get-VMHostStorage vesx03.vfondevilla.com -RescanAllHba```

*Et voilá*, ya tenemos las LUNs disponibles para nuestros hosts!