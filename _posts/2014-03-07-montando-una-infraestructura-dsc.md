---
layout: post
title: Montando una infraestructura DSC
date: 2014-03-07 13:46
author: victor
comments: true
categories: [devops, dsc, powershell, Windows]
---
Windows 2012R2 (y Windows Management Framework 4.0) incluyen una funcionalidad muy interesante llamada DSC (Desired State Configuration), que nos permitirá de una forma similar a otras soluciones (Puppet, Chef...) tener la configuración de forma declarativa.

Los pasos para montar el Pull Server son los siguientes:

Abrir una consola de Powershell en el servidor donde vamos a alojar la configuración y ejecutar los siguientes comandos:

<em>Add-WindowsFeature Dsc-Service</em>

Una vez hecho,

<em>PS C:Usersadministrator&gt; New-Item -Type Directory C:inetpubwwwrootDSCPullServer</em>
<em> Directory: C:inetpubwwwroot</em>
<em>Mode LastWriteTime Length Name</em>
<em>---- ------------- ------ ----</em>
<em>d---- 3/7/2014 1:45 PM DSCPullServer</em>

<em>PS C:Usersadministrator&gt; $origen="C:WindowsSystem32WindowsPowerShellv1.0ModulesPSDesiredStateConfigurationPullServer"</em>
<em>PS C:Usersadministrator&gt; $destino="C:inetpubwwwrootDSCPullserver"</em>
<em>PS C:Usersadministrator&gt; Copy-Item $origenGlobal.asax $destino</em>
<em>PS C:Usersadministrator&gt; copy-item $origenPSDSCPullServer.mof $destino</em>
<em>PS C:Usersadministrator&gt; copy-item $origenPSDSCPullServer.svc $destino</em>
<em>PS C:Usersadministrator&gt; copy-item $origenPSDSCPullServer.xml $destino</em>
<em>PS C:Usersadministrator&gt; copy-item $origenPSDSCPullServer.config $destinoweb.config</em>
<em>PS C:Usersadministrator&gt; ls $destino</em>
<em> Directory: C:inetpubwwwrootDSCPullserver</em>
<em>Mode LastWriteTime Length Name</em>
<em>---- ------------- ------ ----</em>
<em>-a--- 7/1/2013 6:49 PM 141 Global.asax</em>
<em>-a--- 6/21/2013 9:50 AM 525 PSDSCPullServer.mof</em>
<em>-a--- 6/18/2013 2:25 PM 335 PSDSCPullServer.svc</em>
<em>-a--- 6/18/2013 2:25 PM 502 PSDSCPullServer.xml</em>
<em>-a--- 7/1/2013 6:49 PM 3065 web.config</em>

<em>PS C:Usersadministrator&gt; new-item -Type Directory $destinobin</em>
<em> Directory: C:inetpubwwwrootDSCPullserver</em>
<em>Mode LastWriteTime Length Name</em>
<em>---- ------------- ------ ----</em>
<em>d---- 3/7/2014 2:13 PM bin</em>

<em> </em>

<em>PS C:Usersadministrator&gt; import-module WebAdministration</em>
<em>PS C:Usersadministrator&gt; cd IIS:</em>
<em>PS IIS:&gt; new-item AppPoolsDSCAppPool</em>

<em>Name State Applications</em>
<em>---- ----- ------------</em>
<em>DSCAppPool Started</em>
<em>PS IIS:&gt; new-item IIS:SitesDSCPullServer -bindings @{protocol="http";bindingInformation=":80:*"} -physicalPath C:inetp</em>
<em>ubwwwrootDSCPullServer</em>
<em>PS C:&gt; copy-item $pshome/modules//psdesiredstateconfiguration/pullserver/Microsoft.Powershell.DesiredStateConfiguration</em>
<em>.Service.dll $destinobin</em>
<em>PS IIS:&gt; cd C:</em>
<em>PS C:&gt; $appcmd = "$env:windirsystem32inetsrvappcmd.exe"</em>
<em>PS C:&gt; &amp; $appCmd unlock config -section:access</em>
<em>Unlocked section "system.webServer/security/access" at configuration path "MACHINE/WEBROOT/APPHOST".</em>
<em>PS C:&gt; &amp; $appCmd unlock config -section:anonymousAuthentication</em>
<em>Unlocked section "system.webServer/security/authentication/anonymousAuthentication" at configuration path "MACHINE/WEBRO</em>
<em>OT/APPHOST".</em>
<em>PS C:&gt; &amp; $appCmd unlock config -section:basicAuthentication</em>
<em>Unlocked section "system.webServer/security/authentication/basicAuthentication" at configuration path "MACHINE/WEBROOT/A</em>
<em>PPHOST".</em>
<em>PS C:&gt; &amp; $appCmd unlock config -section:windowsAuthentication</em>
<em>Unlocked section "system.webServer/security/authentication/windowsAuthentication" at configuration path "MACHINE/WEBROOT</em>
<em>/APPHOST".</em>
<em>PS C:&gt; Copy-Item $origenDevices.mdb 'C:Program FilesWindowsPowerShellDscService'</em>
<em>PS C:&gt; notepad $destinoweb.config</em>

Añadimos en la parte de App settings lo siguiente
<em>&lt;add key="dbprovider" value="System.Data.OleDb" /&gt;</em>
<em>&lt;add key="dbconnectionstr" value="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:Program FilesWindowsPowerShellDscServiceDevices.mdb;" /&gt;</em>
<em>&lt;add key="ConfigurationPath" value="C:Program FilesWindowsPowerShellDscServiceConfiguration" /&gt;</em>
<em>&lt;add key="ModulePath" value="C:Program FilesWindowsPowerShellDscServiceModules" /&gt;</em>

Arrancamos el website y probamos en http://localhost/psdscpullserver.svc/

Con esto tendremos la primera parte del despliegue hecho, el servidor DSC.
