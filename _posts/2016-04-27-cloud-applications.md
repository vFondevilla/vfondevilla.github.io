---
layout: post
title: Reflexiones sobre el Cloud y sus aplicaciones
---

A raíz de unas jornadas en mi actual empleador, hemos estado hablando sobre el estado del Cloud y sobre el portfolio de una nueva empresa que se ha incorporado al grupo, provocando que por una vez le de al coco. Voy a evitar hablar sobre *Devops*, *Infrastructure as Code*, *Continuous integration*, *Continuous development* y demás términos que muchos ya estamos acostumbrados, y voy a centrarme en otro aspecto mucho menos tenido en cuenta, pero que marca una diferencia brutal. La arquitectura.

##### ¿Qué se define exactamente como Cloud?
Según el NIST, y cito textualmente:

>Cloud computing is a model for enabling ubiquitous, convenient, on-demand network access to a shared
pool of configurable computing resources (e.g., networks, servers, storage, applications, and services) that can be rapidly provisioned and released with minimal management effort or service provider interaction. This cloud model is composed of five essential characteristics, three service models, and four deployment
models.

Con las siguientes características:

>On-demand self-service.

>Broad network access.

>Resource pooling.

>Rapid elasticity.

>Measured service.


Esto significa que no es posible hablar de Cloud fuera de las grandes casas (Amazon Web Services, Microsoft Azure, Google Cloud Platform)? Para nada, se puede desarrollar un cloud interno, apoyado por tecnologías ahora mismo disponibles para las empresas, como VMware vSphere y OpenStack, pero hay mucho proveedor "cloud" que no lo es, por mucho que se empeñen en decir que lo son.

Pero todos sabemos que queda muy *cool* decir que tal o cual empresa ya está en la nube, cuando realmente sus aplicaciones ni son *cloud-ready* ni *cloud-native-applications*.

Y se llega al quid de la cuestión, ¿todas las empresas pueden tener su infraestructura en la nube? Y aquí llega la respuesta de consultor: "Depende".

Por poder puedes tener la infraestructura que quieras en la nube, pero puede que no le estés sacando todo el rendimiento que crees ni podrás hacerlo, si tus aplicaciones no están pensadas para funcionar en la nube. Lo primero que acarrea el Cloud, es un cambio en el paradigma de la arquitectura de aplicaciones, más que un cambio en la forma de operar las mismas (el archiconocido *devops*) donde la aplicación deberá ser capaz de funcionar bajo eliminaciones aleatorias de instancias, problemas de conectividad y mil calamidades más.

Este cambio de paradigma queda reflejado en los [Twelve factors](http://12factor.net), que toda aplicación realmente *Cloud-Native* debería cumplir, actualmente fijados en lo siguiente:

>I. Codebase

>One codebase tracked in revision control, many deploys

>II. Dependencies

>Explicitly declare and isolate dependencies

>III. Config

>Store config in the environment

>IV. Backing services

>Treat backing services as attached resources

>V. Build, release, run

>Strictly separate build and run stages

>VI. Processes

>Execute the app as one or more stateless processes

>VII. Port binding

>Export services via port binding

>VIII. Concurrency

>Scale out via the process model

>IX. Disposability

>Maximize robustness with fast startup and graceful shutdown

>X. Dev/prod parity

>Keep development, staging, and production as similar as possible

>XI. Logs

>Treat logs as event streams

>XII. Admin processes

>Run admin/management tasks as one-off processes
```

¿Qué significan estos *factors*? Un cambio en la forma de diseñar las aplicaciones. Un cambio en la mentalidad de la arquitectura. Pasar de *pets* a *cattles*. Pasar de *monolytic architecture* a *distributed architecture*. Pasar de conexiones directas entre servicios al uso de APIs y mensajería asíncrona.

Si no eres capaz de asumir este cambio, lo siento, tu aplicación no está hecha para funcionar en la nube. Por lo menos no permitiéndote mantener tu salud mental. Ni la de tu equipo de Operaciones.
