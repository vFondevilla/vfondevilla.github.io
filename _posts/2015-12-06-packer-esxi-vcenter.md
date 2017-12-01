---
layout: post
title: Usando Packer y Vagrant con nuestro vCenter como endpoint
---

Recientemente he descubierto una herramienta que encuentro de una utilidad muy evidente, llamada Packer, de los creadores de Vagrant. Es una vuelta de tuerca más al concepto de *Infrastructure as Code*, permitiéndonos crear de forma consistente VMs o instancias (dependiendo de la tecnología que estemos usando), de forma automatizada. 
Packer no viene a sustituir las herramientas especializadas de Configuration Management (Chef, Puppet, Ansible...), si no a complementarlas en una etapa más temprana, en lo que antes eran las *golden images*.

Otras herramientas de este mismo grupo cubren todo el espectro, desde la creación de máquina individuales (Vagrant, aunque todos sabemos que pueden hacer *Vagrantfiles multi-machine*), a toda la infraestructura, incluido configuración de DNS, en varios proveedores (Terraform).

La potencia de Packer es tal, que nos permitirá crear entornos completos (multimáquina) contra varias plataformas al mismo tiempo, de forma simultánea, asegurando la consistencia de las VMs/instancias.

Pero vayamos un poco al grano, me he planteado usar Packer para desplegar un grupo de hypervisores vSphere 6.0 contra nuestro sistema vCenter, de forma automática.

En primer lugar, tendremos que tener instalado: 

* Packer
* VMware Fusion
* el plugin de Vagrant de VMware Fusion 
* la herramienta OVFTool (disponible en my.vmware.com)

Adicionalmente, necesitaremos la ISO de vSphere 6.0 descargada en el mismo directorio donde estemos trabajando.

En mi repositorio de [GitHub de packer-esxi-vcenter](https://github.com/vFondevilla/packer-esxi-vcenter), tendréis los ficheros necesarios para realizar el build del sistema.

Editaremos el fichero esxi60-vcenter.json para reflejar los datos de nuestra infraestructura,

```"post-processors": [
    {
      "type": "vsphere",
      "cluster": "ManagementCluster",
      "datacenter": "Homelab",
      "datastore": "d01-vm02",
      "host": "vcenter.vfondevilla.com",
      "username": "administrator@vsphere.local",
      "password": "Passw0rd!",
      "vm_name": "vESX",
      "insecure": "true",
      "vm_network": "30-Lab"
    }```
    
mientras editamos los datos de la ISO (nombre y hash md5):
```"iso_checksum": "478e2c6f7a875dd3dacaaeb2b0b38228",
      "iso_checksum_type": "md5",
      "iso_urls": [
        "./VMware-VMvisor-Installer-6.0.0-2494585.x86_64.iso"
      ],```
      
Una vez tengamos todo editado, ejecutaremos la comprobación

```➜  packer-esxi git:(my) ✗ packer validate esxi60-vcenter.json```

y ejecutaremos el build de la solución:

```➜  packer-esxi git:(my) ✗ packer build esxi60-vcenter.json```

Automáticamente, se creará la VM en VMware Fusion, se ejecutará la instalación, se parará la máquina y se hará el upload a nuestro vCenter. Voilá!

En un futuro artículo subiré al repo el fichero de configuración para crear 3 ESXi nested con la suficiente configuración para poder montar un Cluster VSAN.

El repo en cuestión lo tenéis en https://github.com/vFondevilla/packer-esxi-vcenter