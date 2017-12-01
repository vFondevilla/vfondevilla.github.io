---
layout: post
title: vVNX en el homelab
---

Hoy os traigo este post, en el que os explicaré como he montado la vVNX de EMC, la appliance virtual de storage, en mi homelab. 

Empezamos descargandola directamente desde la web de [EMC](https://www.emc.com/products-solutions/trial-software-download/vvnx.htm), donde obtendremos el fichero OVA que conformará nuestra cabina de discos virtual.

Desplegamos el "nuevo cacharro que cuesta varios miles de €" en nuestra infraestructura de VMware, pero ojo! Pide **2 vCPU y 12GB de RAM**, así que aseguraos que hay suficiente RAM disponible.

Una vez hayamos desplegado la OVA, obtendrá la IP por DHCP y podremos acceder a la interfaz por el puerto https.

Las credenciales por defecto, son
Usuario: 

``` admin ```

Contraseña: 

``` Password123# ```

Una vez nos loguemos, tendremos que pasar por el Wizard de configuración de la vVNX, con los típicos pasos:

* EULA
* Cambio de contraseña de administrador

Y llegaremos a la parte del licenciamiento, donde nos tocará acceder al [sitio de soporte de EMC](https://www.emc.com/auth/elmeval.htm) donde introduciremos el System UUID, con esto nos devolverán un fichero LIC, que es la licencia de nuestra appliance.

Seguimos configurando:

* DNS
* NTP

Y llegaremos a la parte propiamente dicha de almacenamiento, donde podremos crear los storage pools que queramos.

Aquí hay varias opciones:

* Usar VMDKs
* Usar RDMs
* Passthrough de la controladora RAID o HBA a la VM

En mi caso, ya que no tengo tarjetas RAID ni HBAs ni tengo budget asignado para comprarlas, he usado RDMs, ya trataré en otro post como crear estos RDMs sin tarjetas RAID ni HBA.

En mi caso, he creado dos Storage Pool distintos, cada uno en un SSD distinto, asignando el más pequeño de los dos el rol de "Performance Tier" y al más grande el de "Capacity Tier", aunque en este caso no tiene ningún tipo de diferencia. 
Tener dos Tiers distintos nos permite hacer uso del Autotiering de EMC, moviendo los datos calientes al Performance Tier, teniendo la licencia correcta

![screen shot 2016-01-05 at 21 23 33](https://cloud.githubusercontent.com/assets/10423165/12126664/dddd9094-b3f2-11e5-8373-2ac18d4af1d0.png)


Seleccionaremos los discos que funcionarán con este Storage Pool

![screen shot 2016-01-05 at 21 23 59](https://cloud.githubusercontent.com/assets/10423165/12126666/ddde5a2e-b3f2-11e5-85f2-476c87b222dd.png)

![screen shot 2016-01-05 at 21 24 11](https://cloud.githubusercontent.com/assets/10423165/12126665/ddde02e0-b3f2-11e5-8d14-332a9aed7f3a.png)

Posteriormente, podremos configurar iSCSI/NFS (según nuestras preferencias), en mi caso he creado dos interfaces iSCSI en dos subnets distintas, con el fin de aplicar Multipathing en el Nested Lab.

![screen shot 2016-01-05 at 21 27 40](https://cloud.githubusercontent.com/assets/10423165/12126733/339627c6-b3f3-11e5-8ff1-66f72b1c7a2a.png)

No configuramos la replicación, aunque podríamos con otro sistema vVNX y montar escenarios que hagan uso de Site Recovery Manager!

Tras haber creado el almacenamiento, pasaremos a configurar los Host ESX en la interfaz de nuestra vVNX. Haremos clic en "Hosts" y posteriormente "VMware Hosts". En la parte inferior de la página, pulsaremos en "Find ESX Hosts".

![screen shot 2016-01-05 at 21 32 39](https://cloud.githubusercontent.com/assets/10423165/12127456/9bd41524-b3f7-11e5-81c3-476b0ac2578b.png)

Introduciremos el nombre de nuestro vCenter y pulsaremos sobre "Find", nos pedirá las credenciales de nuestro usuario (de vCenter) y añadiremos los hosts a la vVNX.

![screen shot 2016-01-05 at 21 34 00](https://cloud.githubusercontent.com/assets/10423165/12127458/9bd82c7c-b3f7-11e5-9f6c-c299315f46e6.png)

<img width="501" alt="screen shot 2016-01-05 at 21 34 26" src="https://cloud.githubusercontent.com/assets/10423165/12127459/9bd8b19c-b3f7-11e5-9fe3-f13a235a284c.png">

Pasaremos a crear nuestro Datastore, pinchando sobre "Storage" y a su vez en "VMware Datastores".

Una vez nos pongamos a crear el Datastore, seleccionaremos la tecnología que queramos usar (NFS/VMFS)

<img width="754" alt="screen shot 2016-01-05 at 21 37 25" src="https://cloud.githubusercontent.com/assets/10423165/12127457/9bd618ba-b3f7-11e5-8fca-29e4fe352078.png">

Introduciremos el nombre y la descripción (esto último es opcional)

<img width="755" alt="screen shot 2016-01-05 at 21 38 12" src="https://cloud.githubusercontent.com/assets/10423165/12127461/9bdf4a16-b3f7-11e5-8b4b-d99f36f8736d.png">

Seleccionaremos el Storage Pool sobre el que vamos a crear el Datastore

<img width="753" alt="screen shot 2016-01-05 at 21 39 16" src="https://cloud.githubusercontent.com/assets/10423165/12127462/9c025e16-b3f7-11e5-82fa-feb3a991f70e.png">

Seleccionamos la política de Snapshots automáticos a nivel de VNX (en mi caso lo he deshabilitado)

Configuramos los accesos de los Hosts que añadimos anteriormente, dando acceso a las LUN a los hosts.

Y ya podemos dar por finalizado la configuración!

La propia VNX se encargará de logarse contra el vCenter, y en los hosts que se lo hayamos indicado, crear el Datastore.