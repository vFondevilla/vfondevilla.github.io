---
layout: post
title: La estandarización de los toolchains
---

> Bueno... voy a aplicar estos cambios en la infraestructura y...
>
> *Error refreshing state: state snapshot was created by Terraform v0.12.24, which is newer than current v0.12.23; upgrade to Terraform v0.12.24 or greater to work with this state*
>
> Facepalm

¿A quién no le ha pasado esto alguna vez? Porque a mí me ha pasado varias, y de ellas un porcentaje no muy pequeño ha sido fallo mío al hacer un *brew upgrade* sin mirarme las versiones. 

Pues este, es uno de los pain points que me he encontrado más de 1 y de 2 veces implantando los principios de Infrastructure as Code en diversos equipos, versiones que no concuerdan de herramientas, estados más nuevos que mis herramientas, bugs en las propias herramientas porque he actualizado el binario sin darme cuenta (Te estoy mirando a tí Ansible)...

Pero tenemos la solución mucho más cerca de lo que pensamos, y es bastante posible que de hecho la estemos usando en producción. Docker. Tal cual.

¿Por qué no paquetizar todo nuestro toolset en un contenedor y ejecutarlo teniendo la certeza de que TODO el equipo va a estar funcionando con las mismas versiones y la misma experiencia de usuario?

Todo tan sencillo como hacer un *docker run --rm -v /home/michachidirectorio/work:/home/user ContenedorDeToolchainChachi* y si hemos hecho los deberes y tenemos las configuraciones en nuestro directorio, podremos utilizar siempre las mismas versiones, sin miedo.

En mi caso particular, he cogido una imagen de Ubuntu 20.04 LTS (aunque realmente podrías coger cualquier imagen, incluso Alpine) y he añadido todas las herramientas de CLI que utilizo en mi día a día, por ejemplo Terraform, terraform-docs, aws-cli o Kubectl, también he puesto como shell por defecto ZSH con Oh-My-Zsh, de tal forma que va a leer mi configuración local para poder tener la experiencia más transparente respecto a trabajar en mi portátil siempre. Esto abre la puerta a poder depende exclusivamente de tu equipo que es quien tiene las configuraciones, pero este problema ya existe en cuanto haces que las herramientas necesiten configuraciones, por ejemplo el ~/.aws/credentials así que decidí hacer un all-in. En todo caso, al instalar por completo OhMyZsh en el contenedor, si cambiáramos de máquina donde ejecutamos el contenedor, por lo menos tendríamos la configuración por defecto.

¿Que no te gusta Zsh y prefieres Bash? Tan sencillo como coger como base el contenedor y añadir un cambio de shell a Bash, sh o la que escojas :)

Personalmente, llevo varios días trabajando exclusivamente desde el contenedor para todo lo que está relacionado con mi trabajo, y ni tan mal oye.

He dejado mi caso particular en mi [repositorio](https://github.com/vFondevilla/cloud-shell), por si a alguien le puede servir de algo :)





