---
layout: post
title: Autoscaling en VMware - Diseño Parte 1
---

La compañía Cestas Asociadas ha requerido de los servicios de la empresa donde trabajo (Darknet Inc.) para diseñar su plataforma de Producción, usando exclusivamente tecnologías Microsoft. No le tienen miedo al Cloud ni a los arquitectos locos como yo, así que deciden arriesgarse.

Se recogen los siguientes **requerimientos**:

* Plataforma web e-commerce de venta de cestas
* Usarán tecnologías Microsoft (IIS, SQL Server)
* La solución debe ser fácilmente escalable
* La solución debe ser compatible con su actual Active Directory
* Requieren que la plataforma sea autoescalable

**Limitaciones**

* Necesitan que la plataforma (pagan en modalidad IaaS) sea cost-effective
* No quieren extender su Active Directory hacia la nube

**Hipótesis**

* Los desarrolladores son grandes expertos que consiguen que el código no tenga defectos que afecten negativamente al rendimiento
* El cliente proveerá de la conectividad necesaria en el DataCenter

**Riesgos**

* La falta de coordinación con los developers y SysAdmins del cliente pueden poner en riesgo el proyecto


Al ser un diseño completamente ficticio, basado lejanamente en experiencias propias, estos factores los iré ampliando según se me vayan ocurriendo :)
