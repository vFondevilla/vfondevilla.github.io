---
layout: post
title: esxtop no se muestra correctamente
---

Hoy, tras mucho tiempo sin hacer uso de la herramienta esxtop en mi lab, me he encontrado con que la consola me mostraba un galimatías sin sentido. Véase el pantallazo adjunto.

![galimatias](https://user-images.githubusercontent.com/10423165/31715858-c05d3852-b405-11e7-897b-35b0f48ea6ad.png) 

El problema viene de la configuración del iTerm2 (o consola que estés usando), que está presentando el terminfo como algo distinto que xterm. El arreglo es tan sencillo como cambiar la configuración para que presente xterm

![config](https://user-images.githubusercontent.com/10423165/31715864-c5513868-b405-11e7-98a8-23526d1c356d.png)


Tras aplicar este cambio, cuando inicies sesión en ESXi y lances un esxtop, te lo mostrará como siempre.

![bau](https://user-images.githubusercontent.com/10423165/31715870-ca357fb0-b405-11e7-9caa-05ff641be639.png)

Bonus points: Para arreglarlo sin tener que desconectar (solo funcionará durante la sesión que tienes abierta), es tan sencillo como escribir

```
TERM=xterm
```