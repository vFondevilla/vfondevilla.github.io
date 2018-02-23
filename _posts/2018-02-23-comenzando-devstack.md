---
layout: post
title: Comenzando con OpenStack en una única máquina
---

En el post de hoy, comenzaremos desplegando OpenStack en una máquina física, en este caso un Intel NUC que tengo por casa muerto de risa, con un disco de 60GB SSD. En este caso usaremos DevStack que es la distribución de OpenStack pensada para desarrolladores, basada en la última release disponible de OpenStack. Es la forma más rápida de comenzar con OpenStack en nuestro laboratorio y con la que comenzaré a jugar.

Comenzaremos desplegando el sistema operativo, en mi caso CentOS 7.3 minimal y asignando una IP estática al equipo. El resto de la configuración la realizo mediante ansible, donde básicamente cargo claves de ssh e instalo diversos paquetes.

Una vez el sistema está configurado, el primer paso es crear el usuario bajo el que funcionará OpenStack, en este caso lo llamaré *stack*
```
sudo useradd -s /bin/bash -d /opt/stack -m stack
```
Una vez creado, le configuraremos una contraseña con el comando:
```
sudo passwd stack
```
Y cambiaremos a ese usuario con
```
sudo su stack
```
Por lo menos en mi instalación de CentOS 7.3 cuando intentaba desplegar DevStack, me daba el siguiente error "Failed to add dependency on syslog.target,iptables.service, ignoring: Invalid argument", esto es debido a que un error de sintaxis en el fichero /usr/lib/systemd/system/ip6tables.service originalmente aparece así:
```
After=syslog.target,iptables.service
```
Pero debería estar escrito así:
```
After=syslog.target iptables.service
```
Realizamos el cambio y reiniciamos systemctl, tras esto, podremos continuar con la instalación de DevStack. Dentro de nuestra home, clonaremos el repositorio de Git de DevStack y entraremos dentro del directorio resultante:
```
git clone https://git.openstack.org/openstack-dev/devstack
cd devstack
```
Cogeremos la configuración que trae de ejemplo y rellenaremos ciertos datos relevantes:
```
cp samples/local.conf .
```
En mi caso la configuración queda de la siguiente manera (mucho ojo porque el script no hace validación de la configuración y si hay alguna errata pasará desapercibida):
```
[[local|localrc]]
ADMIN_PASSWORD=Passw0rdSuperComplicada
DATABASE_PASSWORD=stackdb
RABBIT_PASSWORD=stackqueue
SERVICE_PASSWORD=$ADMIN_PASSWORD
LOGFILE=$DEST/logs/stack.sh.log
LOGDAYS=2
SWIFT_HASH=66a3d6b56c1f479c8b4e70ab5c2000f5
SWIFT_REPLICAS=1
SWIFT_DATA_DIR=$DEST/data
FLOATING_RANGE=10.1.0.224/27
FIXED_RANGE=10.11.12.0/24
FIXED_NETWORK_SIZE=256
FLAT_INTERFACE=eno1
```
FLOATING_RANGE indica cual es el rango de IPs que usaremos como Floating IPs para acceder a las instancias
FIXED_RANGE indica la subred dedicada internamente para las instancias, en este caso utilizo una red completamente aislada de mi red.

Tras haber completado la instalación, simplemente nos quedará ejecutar la instalación con el comando
```
./stack.sh
```
Y podremos irnos a tomar un café, porque tardará un rato largo. En caso de que de algún error, podemos ejecutar
```
./unstack.sh 
``` 
para que deshaga todo lo que haya hecho y empezar de 0.

Una cosa importante que me tuvo parado 4 horas, el script configura iptables, pero no abre el puerto 80 para acceder al dashboard, así que acordaros de añadir la regla a iptables :)

Una vez haya terminado, podremos acceder al Dashboard de OpenStack (Horizon) desde nuestro navegador.
