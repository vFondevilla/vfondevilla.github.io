---
layout: post
title: Problemas usando el instalador de VCSA 6.5 en MacOS Sierra
---

Al ir a actualizar mi laboratorio (sí, voy tarde, lo sé), desde MacOS Sierra, me he encontrado con algún bug del instalador.


Al llegar al paso número 6, que es seleccionar el tamaño del appliance VCSA, da un error *Error: ovftool is not available*. Esto pasa porque por algún motivo, en vez de ir a /Applications el instalador busca en /private.


Si te descargas el log del instalador (desde la misma ventana), tendrás una línea similar a esta:

```
2016-12-22T19:44:58.727Z - error: could not find ovftoolCmd: /private/var/folders/f0/gzgd0d8j52s8q5x17j12dq6w0000gn/T/AppTranslocation/vcsa/ovftool/mac/ovftool
```

La solución es tan simple como copiar el directorio vcsa de de la ISO al directorio de /private/var/folders/f0/randomstring/T/AppTranslocation/

Un vez instalado, ya podrás ejecutar la instalación.