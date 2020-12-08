---
layout: post
title: NSX-T y el trafico BUM
---


El tráfico BUM (Broadcast, Unknow Unicast and Multicast traffic) es un factor a tener en cuenta en las soluciones SDN en datacenters distintos, ya que se está descargando las funcionalidades de routing distribuido sobre los hipervisores, incluyendo la replicación de los paquetes BUM. Dada la arquitectura aquí presente:

Donde DC1 y DC2 son dos datacenters en los que está desplegada la solución NSX-T, con 3 hipervisores cada uno y 2 VNI (Virtual Network Identifier). Los DCs tiene un direccionamiento de underlay distinto para cada uno.

![img_8832](https://user-images.githubusercontent.com/10423165/31818384-2cd686f8-b598-11e7-9bec-e83eb6439761.JPG)

NSX-T ofrece dos modalidades de replicación de tráfico BUM:
* Hierarchical Two-Tier
* Head

Por defecto NSX-T utiliza el modo "Hierarchical Two-Tier", que viene a funcionar de la siguiente manera:

1. La VM A situada en el DC1-H2 emite tráfico BUM que ha de ser inundado por todo el VNI, 
2. para esto DC1-H2 inspecciona la tabla de VTEP para ver que hosts están en el VNI 5002, tras ver que DC2-H2 y DC2-H3 están en una red distinta a la propia de DC1-H2, este designa un nodo replicador en la red de DC2, siendo en este caso DC2-H2
3. manda una copia del paquete BUM a DC1-H3
4. manda otra copia al nodo replicador del DC2 (DC2-H2)
5. el cual hace llegar una copia del paquete BUM a DC2-H3. 

En el caso de utilizar el modo "Head" es el propio DC1-H2 que manda una copia del paquete BUM a cada endpoint TEP, dando igual el direccionamiento que tenga.