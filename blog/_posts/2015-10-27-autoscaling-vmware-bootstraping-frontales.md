---
layout: post
title: Autoscaling VMware - Bootstraping de los frontales
---

Con un template basado en Windows 2012 R2, procederemos a desplegar 2 VMs en la red del lab. Con los nombres de DNS chefwin-frontal01 y chefwin-frontal02.
En una primera versión de este ejercicio no añadiremos las VMs al Active Directory.

Estos templates, para simplificar la gestión de la plataforma que está en un entorno no productivo han sido configuradas con lo siguiente:

```
Winrm quickconfig
Winrm set winrm/config/client/auth @{Basic=”true”}
Winrm set winrm/config/service/auth @{Basic=”true”}
Winrm set winrm/config/service @{AllowUnencrypted=”true”}
```

Esto nos permitirá hacer el *bootstrapping* de una forma más sencilla.

Una vez las VMs están desplegadas, tomaremos nota de sus IPs, ya que las necesitaremos para hacer el proceso de bootstrapping.

Desde nuestro equipo de gestión de Chef, ejecutaremos lo siguiente:

```knife bootstrap windows winrm 192.168.30.35 --winrm-user administrator --winrm-password Password! --node-name chefwin-frontal01```

```knife bootstrap windows winrm 192.168.30.42 --winrm-user administrator --winrm-password Password! --node-name chefwin-frontal02```

Este comando iniciará el proceso de bootstrapping en los windows, instalando el chef-client que se encargará de contactar con el servidor de chef correspondiente para coger su configuración. En otro post tocaré la forma de configurar un cronjob para que contacte con el servidor de Chef.