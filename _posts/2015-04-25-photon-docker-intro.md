---
layout: post
title: Empezando con Docker y VMware Photon
---

Esta semana VMware ha dado un paso adelante en el mundo de los contenedores, publicando VMware Photon, una distribución linux super-ligera (mismo estilo que CoreOS) enfocada a trabajar con contenedores (docker,rkt...) y LightWave, una solución de gestión de identidades para estos contenedores, que sinceramente están muy que muy interesantes.

Ahora quiero empezar a tocar el mundo de Docker debido a un nuevo proyecto en el que me estoy embarcando y qué mejor manera que empezar usando Photon.

Podemos descargarnos la imagen desde [aqui](https://dl.bintray.com/vmware/photon/iso/1.0TP1/x86_64/photon-1.0TP1.iso) y revisar el repo en https://vmware.github.io/photon/ donde van subiendo el nuevo contenido.

Procedemos a instalar la ISO en nuestro software de virtualización (en este caso yo estoy usando VMware Fusion), donde solo tarda 40 segundos, y eso siendo la versión completa. Os recomiendo seguir la [guía de VMware](https://vmware.github.io/photon/assets/files/getting_started_with_photon_on_vmware_fusion.pdf)

Una vez hecho esto, podemos proceder a encender la máquina virtual y conectarnos a ella por la Remote Console, donde habilitaremos el acceso por el usuario root (no hagas esto en producción, niños) y añadiremos nuestra clave en el listado de authorized_keys del daemon ssh. Por defecto Photon lleva nano como editor de texto, pero podemos añadir vim con el siguiente comando:

```bash
tdnf install vim
```

Una vez hecho esto añadimos nuestra clave pública dentro del usuario root con los siguientes comandos
En Photon:

```bash
 mkdir .ssh
```

En nuestro host:

```bash
cat .ssh/id_rsa.pub | ssh 172.16.32.159 -l root 'cat >> .ssh/authorized_keys' 
```

Tras esto ya podremos loguearnos sin contraseña al entrar con el usuario root. Una vez hecho esto, toca meterse con Docker, pero en este artículo lo único que haremos será arrancar un contenedor de Ubuntu 14.04 con Bash :)

```bash
docker run -t -i ubuntu:14.04 /bin/bash
```

Et voilà! Hemos levantado nuestro primer docker. En próximos artículos entraremos más en detalle :)
