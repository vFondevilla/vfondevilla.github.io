---
layout: post
title: Primeros pensamientos sobre VMware Integrated OpenStack
---
He desplegado (parcialmente) VMware Integrated OpenStack en mi homelab, y he de decir que ha sido un poco dulce-amargo, dulce por la posibilidad de poder usar un nuevo estándar de facto como OpenStack encima del hypervisor que probablemente ya esté en producción, y amargo porque los requerimientos por defecto de VMware son totalmente abrumadores, y para muestra os pego los requisitos de la suite.

![OpenStack Requirements]({{ site.url }}/img/openstack1.png)

192 GB de RAM, 56 vCPUs y 605 GB de Storage. Tendré que mirar cuanto puedo reducirlo y si entrará en 40GB de RAM siendo minimamente usable, porque si no veo pidiéndole a la empresa que me monte un laboratorio *enterprise-grade* para poder jugar con ello.

Como ventajas que le veo:

* Soportado por VMware, siendo el soporte opcional. Mientras no lo tengas en producción, el coste que te ahorras.
* Upgrades probados por VMware, siendo completamente *drop-in*
* Abstracción de la capa de hypervisor, facilitando una posible integración de nuevos hypervisores.

Como desventajas principales:

* Los requisitos mínimos marcados por VMware, 15 VMs, 56 vCPU y 192 GB de RAM, prácticamente te comes un servidor en la infraestructura OpenStack
* Para sacarle el máximo jugo posible necesitas tener NSX instalado en el entorno, si no pierdes parte de las funcionalidades de red como segmentación de capa 2 y parte de los servicios de capa 3 como routers virtuales e IPs flotantes.


Solo me queda decir que estoy emocionado con esta nueva suite y espero poder probarla a fondo estos días. ¡Gracias VMware!
