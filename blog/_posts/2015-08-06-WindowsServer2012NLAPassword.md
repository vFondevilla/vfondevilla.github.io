---
layout: post
title: Windows Server 2012 R2, NLA y cambios de contraseña
---

Recientemente me he encontrado con una incidencia usando Windows 2012 R2 entre dos dominios sin relación de confianza (por ejemplo remote.local y office.local), estando el usuario en office.local y el equipo en remote.local

Esta es una incidencia por la que de repente una cuenta no podía acceder, haciendo referencia al críptico mensaje de "The Local Security Authority cannot be contacted". Revisando el *event viewer* veo que el login es erróneo, pero en la razón da una pista: 

*Failure Information:
	Failure Reason:		The specified account's password has expired.
	Status:			0xC0000224*
	
Así que raudo y veloz cambio la contraseña extrañado porque no haya presentado el proceso de cambio de contraseña al que todos estamos acostumbrados. Le reseteo la contraseña y el usuario intenta acceder de nuevo. Nada, cero. Sigue sin funcionar.

Tras un troubleshooting detallado (todo tan serio como resetear la contraseña otra vez y probar yo), veo que sigue sin funcionar. Creo una cuenta con los mismos permisos y funciona correctamente. Esto ya empieza a ser desesperante. Y de repente se me enciende la bombilla, recordando una KB de Microsoft que leí hace tiempo ( https://support.microsoft.com/en-us/kb/2648402 ) que arrojó la solución que necesitaba:

*To work around the issue, use one of the following methods:*

*Disable the Allow connections only from computers running Remote Desktop with Network Level Authentication option on the RD Session Host server.*

*Change the password of the user account by using a different method.*


El problema radica en que por defecto el remote desktop viene con el Network Level Authentication activado, con lo que CredSSP por diseño no tiene contemplado poder cambiar la contraseña del usuario:

*In the protocol specification for CredSSP, there is no reference to the ability to change the user's password while NLA is running. Therefore, the observed behavior can be considered "by design."*

Tras esto, solo quedó activar una GPO que desactivara el NLA en los servidores de Remote Desktop.









