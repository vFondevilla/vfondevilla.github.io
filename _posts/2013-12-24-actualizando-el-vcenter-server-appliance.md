---
layout: post
title: Actualizando el vCenter Server Appliance
date: 2013-12-24 13:12
author: victor
comments: true
categories: [VCSA, vmware, vmware]
---
Al parecer la 5.5.0.5100 no funciona muy bien el SSO (estoy intentando integrarlo en mi laboratorio), así que han sacado un update.

El proceso para actualizar el VCSA es el siguiente:

1. Entramos en la URL del VCSA (por ejemplo https://vcenter:5480/) y nos logueamos con el usuario root

2. Vamos a la opción de "Update" y seleccionamos revisamos si hay updates. De haberlos, los aplicamos.

3. Si quereis ver el avance del update, podéis entrar por ssh al VCSA y  haciendo un tail -f /opt/vmware/var/log/vami/updatecli.log veréis los avances.

4. Una vez actualizado, reiniciamos el VCSA
