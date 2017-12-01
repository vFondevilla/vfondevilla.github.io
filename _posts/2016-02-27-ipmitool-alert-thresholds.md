---
layout: post
title: Modificando umbrales de alerta de los ventiladores en Supermicro
---

En el post de hoy, voy a cubrir lo que hay que hacer para poder cambiar los umbrales de alerta de los ventiladores en las placa base de Supermicro. Si habeis leído la información sobre mi lab, tengo un par de máquinas Supermicro (un Xeon D-1520 y un D-1540), siendo la 1520 *fanless* y sinceramente, se calienta **mucho**. Así que le he puesto un ventilador Noctua como he podido, pero funciona tan bien que bajaba a 300 revoluciones, y hacía que saltara una alarma tanto en la IPMI como en vCenter, saturándome el correo siendo muy molesto.

La solución? Modificar los umbrales de la IPMI, pero esto no puede hacerse desde la interfaz web, pero sí mediante línea de comandos.

Primeros instalaremos la herramienta IPMITOOL, en mi caso usando Brew (estoy en un Mac).

A continuación, ejecutaremos el siguiente comando:
```ipmitool -U ADMIN -P ADMIN -H IP sensor thresh lower FAN2 150 225 300```

Donde el primer valor (150) es el error Lower Non-Recoverable, el segundo (225) es el Lower Critical y 300 es el Lower Non-Critical. Con esto, conseguimos modificar los valores. En mi caso no me hizo falta reiniciar, y ya dejaron de llegarme los avisos.