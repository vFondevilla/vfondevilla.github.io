---
layout: post
title: Exportar los planes de mantenimiento sin Integration Services
date: 2014-08-01 11:40
author: victor
comments: true
categories: [Uncategorized]
---
Documentando un proyecto de un cliente y en un intento de implementar Control de Versiones para todo lo referido a ese cliente, necesitaba exportar los planes de mantenimiento (Maintenance Plans) del SQL Server, que no tiene instalado los Integration Services. Gracias a <a href="http://dba.stackexchange.com/questions/17695/can-i-export-a-maintenance-plan-without-using-integration-services" target="_blank">dba.stackexchange.com</a> (hurra!) encontré el siguiente <a href="http://billfellows.blogspot.com.es/2011/11/ssis-package-extract-from-msdb.html" target="_blank">post</a> que explica (y te facilita la consulta SQL que te permitirá extraer los planes de mantenimiento como ficheros dtsx.

Para que quede disponible aquí, pego el código (all merit goes to billfellows.blogspot.com)
<pre class="csharpcode" style="color: #000000;"><span class="kwrd" style="color: #0000ff;">WITH</span> FOLDERS <span class="kwrd" style="color: #0000ff;">AS</span>
(
    <span class="rem" style="color: #008000;">-- Capture root node</span>
    <span class="kwrd" style="color: #0000ff;">SELECT</span>
        <span class="kwrd" style="color: #0000ff;">cast</span>(PF.foldername <span class="kwrd" style="color: #0000ff;">AS</span> <span class="kwrd" style="color: #0000ff;">varchar</span>(<span class="kwrd" style="color: #0000ff;">max</span>)) <span class="kwrd" style="color: #0000ff;">AS</span> FolderPath
    ,   PF.folderid
    ,   PF.parentfolderid
    ,   PF.foldername
    <span class="kwrd" style="color: #0000ff;">FROM</span>
        msdb.dbo.sysssispackagefolders PF
    <span class="kwrd" style="color: #0000ff;">WHERE</span>
        PF.parentfolderid <span class="kwrd" style="color: #0000ff;">IS</span> <span class="kwrd" style="color: #0000ff;">NULL</span>

    <span class="rem" style="color: #008000;">-- build recursive hierarchy</span>
    <span class="kwrd" style="color: #0000ff;">UNION</span> <span class="kwrd" style="color: #0000ff;">ALL</span>
    <span class="kwrd" style="color: #0000ff;">SELECT</span>
        <span class="kwrd" style="color: #0000ff;">cast</span>(F.FolderPath + <span class="str" style="color: #a31515;">'\'</span> + PF.foldername <span class="kwrd" style="color: #0000ff;">AS</span> <span class="kwrd" style="color: #0000ff;">varchar</span>(<span class="kwrd" style="color: #0000ff;">max</span>)) <span class="kwrd" style="color: #0000ff;">AS</span> FolderPath
    ,   PF.folderid
    ,   PF.parentfolderid
    ,   PF.foldername
    <span class="kwrd" style="color: #0000ff;">FROM</span>
        msdb.dbo.sysssispackagefolders PF
        <span class="kwrd" style="color: #0000ff;">INNER</span> <span class="kwrd" style="color: #0000ff;">JOIN</span>
            FOLDERS F
            <span class="kwrd" style="color: #0000ff;">ON</span> F.folderid = PF.parentfolderid
)
,   PACKAGES <span class="kwrd" style="color: #0000ff;">AS</span>
(
    <span class="rem" style="color: #008000;">-- pull information about stored SSIS packages</span>
    <span class="kwrd" style="color: #0000ff;">SELECT</span>
        P.name <span class="kwrd" style="color: #0000ff;">AS</span> PackageName
    ,   P.id <span class="kwrd" style="color: #0000ff;">AS</span> PackageId
    ,   P.description <span class="kwrd" style="color: #0000ff;">as</span> PackageDescription
    ,   P.folderid
    ,   P.packageFormat
    ,   P.packageType
    ,   P.vermajor
    ,   P.verminor
    ,   P.verbuild
    ,   suser_sname(P.ownersid) <span class="kwrd" style="color: #0000ff;">AS</span> ownername
    <span class="kwrd" style="color: #0000ff;">FROM</span>
        msdb.dbo.sysssispackages P
)
<span class="kwrd" style="color: #0000ff;">SELECT</span> 
    <span class="rem" style="color: #008000;">-- assumes default instance and localhost</span>
    <span class="rem" style="color: #008000;">-- use serverproperty('servername') and serverproperty('instancename') </span>
    <span class="rem" style="color: #008000;">-- if you need to really make this generic</span>
    <span class="str" style="color: #a31515;">'dtutil /sourceserver localhost /SQL "'</span>+ F.FolderPath + <span class="str" style="color: #a31515;">'\'</span> + P.PackageName + <span class="str" style="color: #a31515;">'" /copy file;".\'</span> + P.PackageName +<span class="str" style="color: #a31515;">'.dtsx"'</span> <span class="kwrd" style="color: #0000ff;">AS</span> cmd
<span class="kwrd" style="color: #0000ff;">FROM</span> 
    FOLDERS F
    <span class="kwrd" style="color: #0000ff;">INNER</span> <span class="kwrd" style="color: #0000ff;">JOIN</span>
        PACKAGES P
        <span class="kwrd" style="color: #0000ff;">ON</span> P.folderid = F.folderid
<span class="rem" style="color: #008000;">-- uncomment this if you want to filter out the </span>
<span class="rem" style="color: #008000;">-- native Data Collector packages</span>
<span class="rem" style="color: #008000;">-- WHERE</span>
<span class="rem" style="color: #008000;">--     F.FolderPath &lt;&gt; '\Data Collector'</span></pre>
