---
layout: post
title: Autoscaling en VMware - Despliegue del servidor DSC
---

Como siguiente paso, vamos a proceder a desplegar una VM que alojará nuestro servidor DSC en modo *pull*, donde iremos alojando los ficheros de configuración (*mof*) de las máquinas de nuestro dominio.
La desplegaremos en el direccionamiento asignado al cliente Cestas Asociadas (192.168.30.0/24), conjuntamente con el Domain Controller.

Tras haberla desplegado, procederemos a instalar la característica (*feature*) de **Windows PowerShell Desired State Configuration**, tanto por la GUI como por Powershell. Si lo hacemos por powershell hay que añadir la consola de IIS a la instalación

```Powershell
Add-WindowsFeature Dsc-Service, Web-Mgmt-Console
```

Tras esto procedemos a instalar el módulo de Powershell xPSDesiredStateConfiguration descargándolo de https://gallery.technet.microsoft.com/xPSDesiredStateConfiguratio-417dc71d y descomprimiéndolo en *%programfiles%\WindowsPowerShell\modules*

Habilitamos el *listener* de WinRM (Windows Remote Management)

```Powershell
winrm quickconfig
```

Para darle más seguridad al sistema, vamos a proceder a configurar el servidor DSC en modo HTTPS. (*Paranoia mode on*)

Instalaremos un certificado emitido para el servidor dsc-server.test.local, que previamente habremos solicitado a la CA del dominio, con el friendly name de *dsc webserver*


Nos apuntaremos el *Thumbprint* del certificado, que conseguiremos de la siguiente forma:

```Powershell
Get-ChildItem -Path cert: -Recurse | Where { $_.FriendlyName –contains “dsc*” } | select Subject, FriendlyName, Thumbprint | Format-List
```


Tras esto crearemos una configuración DSC para el propio servidor DSC, que nos configurará todo lo necesario.

```Powershell
configuration NewPullServer
{
    param
    (
        [string[]]$ComputerName = 'localhost'
    )
    Import-DSCResource -ModuleName xPSDesiredStateConfiguration
    Node $ComputerName
    {
        WindowsFeature DSCServiceFeature
        {
            Ensure = "Present"
            Name   = "DSC-Service"
        }
        xDscWebService PSDSCPullServer
        {
            Ensure                  = "Present"
            EndpointName            = "PSDSCPullServer"
            Port                    = 8080
            PhysicalPath            = "$env:SystemDrive\inetpub\wwwroot\PSDSCPullServer"
            CertificateThumbPrint   = "E493BC34B3E0AA33A482FCB3E159670AE585A984"
            ModulePath              = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Modules"
            ConfigurationPath       = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration"
            State                   = "Started"
            DependsOn               = "[WindowsFeature]DSCServiceFeature"
        }
        xDscWebService PSDSCComplianceServer
        {
            Ensure                  = "Present"
            EndpointName            = "PSDSCComplianceServer"
            Port                    = 9080
            PhysicalPath            = "$env:SystemDrive\inetpub\wwwroot\PSDSCComplianceServer"
            CertificateThumbPrint   = "E493BC34B3E0AA33A482FCB3E159670AE585A984"
            State                   = "Started"
            IsComplianceServer      = $true
            DependsOn               = ("[WindowsFeature]DSCServiceFeature","[xDSCWebService]PSDSCPullServer")
        }
    }
}

NewPullServer –ComputerName dsc.test.local
```

Esto nos generará una nueva carpeta, llamada NewPullServer donde contendrá el .mof del servidor dsc.test.local
Tras intentar ejecutarlo, con *Start-DscConfiguration .\NewPullServer -Wait*
os dará un fallo, de este estilo:
```
PowerShell provider MSFT_xDSCWebService  failed to execute Set-TargetResource functionality with error message: ERROR:
C:\Windows\System32\WindowsPowerShell\v1.0\modules\PSDesiredStateConfiguration\PullServer\es\Microsoft.Powershell.Desir
edStateConfiguration.Service.Resources.dll does not exist
    + CategoryInfo          : InvalidOperation: (:) [], CimException
    + FullyQualifiedErrorId : ProviderOperationExecutionFailure
    + PSComputerName        : dsc.test.local

The SendConfigurationApply function did not succeed.
    + CategoryInfo          : NotSpecified: (root/Microsoft/...gurationManager:String) [], CimException
    + FullyQualifiedErrorId : MI RESULT 1
    + PSComputerName        : dsc.test.local
```
Se soluciona copiando y renombrando C:\Windows\System32\WindowsPowerShell\v1.0\modules\PSDesiredStateConfiguration\PullServer\en\ a C:\Windows\System32\WindowsPowerShell\v1.0\modules\PSDesiredStateConfiguration\PullServer\es\

Tras esto la ejecución de la configuración se completará correctamente. Desde el IIS Manager podremos confirmar que los bindings del servidor DSC se han creado en el protocolo HTTPS.
