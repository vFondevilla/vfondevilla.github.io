---
layout: post
title: Resolviendo problemas con el SSO del VCSA
date: 2014-01-08 20:48
author: victor
comments: true
categories: [DNS, VCSA, vmware, vmware]
---
Si tuviéramos problemas para acceder mediante SSO al VCSA, los logs detallados de los problemas se encuentran en /var/log/vmware/sso/ssoAdminServer.log, lo que nos ayudará a hacer troubleshooting de las incidencias del SSO.

Una que me he encontrado bastantes veces en el entorno de laboratorio es la siguiente:

Tienes tu máquina correctamente unida al dominio (lo compruebas en Usuarios y Equipos del Active Directory), resuelve correctamente, puedes entrar correctamente con el usuario root@localos o administrator@vsphere.local, pero no con los usuarios del dominio (a pesar de estar bien configurado).

La solución pasa por revisar si tienes una zona de resolución inversa en el DNS, en la que se resuelva el Domain Controller.

Tras esto, el SSO funcionaba correctamente, con lo que puse fin a horas de romperme la cabeza.
