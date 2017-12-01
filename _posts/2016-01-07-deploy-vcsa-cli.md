---
layout: post
title: Desplegando VCSA sobre línea de comandos
---

Mientras estoy mirando como automatizar la creación de un *nested lab* (sí, ya sé que existe AutoLab, *but just because*) os explico como desplegar un VCSA 6.0 desde línea de comandos, usando una fantástica utilidad llamada *vcsa-deploy*. Mediante un fichero JSON, podemos invocar la utilidad y automáticamente desplegará un VCSA con la configuración que le hagas llegar por el fichero JSON.

El fichero JSON es el siguiente

{% gist 71136dfbacc8936d494d %}
	
Desde nuestro equipo, montaremos la ISO y dentro del directorio vcsa-cli-installer encontraremos los directorios para los distintos sistemas operativos soportados. En mi caso usaré el de OS X

```./vcsa-deploy ~/repos/homelab/vcsa.json  --accept-eula```

Ejecutando eso, empezará a desplegar el VCSA. Para que os hagáis una idea de los tiempos, sobre una conexión Wifi con 200Mbps de ancho de banda, tardó 13 minutos en todo el proceso!

Sin lugar a dudas, muy útil.