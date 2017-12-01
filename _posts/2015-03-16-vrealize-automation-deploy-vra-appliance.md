---
layout: post
title: vRealize Automation - Desplegando vRealize Appliance
---

En este post, procederemos a desplegar la appliance vRealize, tal y como hicimos con la Identity Appliance. Los datos de esta appliance en mi caso son los siguientes:

* Dirección IP: 192.168.1.246/24
* Gateway: 192.168.1.2
* Hostname: vcac.vfondevilla.local

Tras haber desplegado la appliance, nos conectaremos a la VAMI de la misma (https://vcac.vfondevilla.local:5480) y pincharemos sobre *vRA Settings*
En Host Settings marcaremos la opción de *Resolve Automatically* para que nos rellene el campo con el hostname y Generate Certificate que rellenaremos con los campos que creamos convenientes
![vRA setup]({{ site.url }}/img/vra/vra6.png)

Aplicaremos los cambios y procederemos a configurar la parte de SSO con el hostname *vcac-identity.vfondevilla.local*
![vRA setup]({{ site.url }}/img/vra/vra7.png)

Aceptamos el certificado de la vcac-identity y debería salirnos en verde con el estado *Connected*. En este paso pueden pasar varios minutos, paciencia
![vRA setup]({{ site.url }}/img/vra/vra8.png)
![vRA setup]({{ site.url }}/img/vra/vra9.png)

Metemos la licencia de la aplicación (obviamente aquí no pongo captura de pantalla :)) y esperamos unos minutos mientras aplica los cambios en el sistema.


Tras estos pasos, mirar que en la pestaña *Services* aparecen registered por lo menos los siguientes:

* authorization
* authentication
* eventlog-service
* shell-ui-app
* branding-service
* plugin-service

Tras esto solo queda acceder a https://vcac.vfondevilla.local/vcac y loguearse con los datos del SSO que se configuraron en el despliegue de la Identity Appliance, para comprobar que la parte de la gestión de vRA está operativa, solo nos quedaría la parte del IaaS, que trataremos en la siguiente parte.
