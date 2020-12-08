---
layout: post
title: Vagrant y vSphere
---

En el post de hoy, exploraremos como instalar Vagrant sobre CentOS 7.2 y cómo podemos hacer que ```vagrant up``` clone un template.

Lo primero de todo, desplegaremos nuestra máquina de desarrollo sobre CentOS 7.2, una vez desplegado, instalaremos [vagrant](https://www.vagrantup.com/), en el momento de redactar este post la 1.9.1 ya que la 1.9.2 sufre de un bug de dependencias en las gems:

```
 wget https://releases.hashicorp.com/vagrant/1.9.1/vagrant_1.9.1_x86_64.rpm
 yum localinstall vagrant_1.9.1_x86_64.rpm
```

Una vez instalado, instalaremos el plugin de vagrant-vsphere, que es el driver que se ocupará de la comunicación con el vCenter/ESXi:
```
vagrant plugin install vagrant-vsphere
```

Nos decargaremos el fichero metadate.json que está preparado como template para el driver y lo descomprimiremos:
```
curl -k https://raw.githubusercontent.com/nsidc/vagrant-vsphere/master/example_box/metadata.json -O
tar cvzf vsphere-dummy.box ./metadata.json
```

Añadiremos un nuevo box vacío, que nos valdrá como placeholder en la comunicación:
```
vagrant box add vsphere-dummy ./vsphere-dummy.box
```

Una vez añadido, podemos verificar que el box se ha creado correctamente
```
[root@chefdev ~]# vagrant box list

vsphere-dummy (vsphere, 0)
```

Crearemos un Vagrantfile similar a este:
```
Vagrant.configure("2") do |config|
  config.vm.box = "vsphere-dummy"
  config.vm.provider :vsphere do |vsphere|
    # The vSphere host we're going to connect to
    vsphere.host = 'vcenter.vfondevilla.com'
   # The ESX host for the new VM
    vsphere.compute_resource_name = 'pCluster'
    # The template we're going to clone
    vsphere.template_name = 'vagrant-centos'
    # The name of the new machine
    vsphere.name = 'vagrant-centos-test'
    # vSphere login
    vsphere.user = 'administrator@vsphere.local'
    # vSphere password
    vsphere.password = 'SuPerPassw0rdComplicada!'
    # If you don't have SSL configured correctly, set this to 'true'
    vsphere.insecure = true
  end
end
```

Con esto, tendremos la máquina de desarrollo completa, a falta de instalar el software de gestión de configuración que prefieras (Ansible, Chef, Puppet, Salt...), ya solo nos falta crear el template, con los siguientes pasos:

- Desplegar una nueva VM
- Añadir el usuario vagrant con la contraseña "vagrant"
- Añadir el usuario vagrant al fichero sudoers "vagrant ALL=(ALL) NOPASSWD:ALL"
- Añadir la clave de Vagrant al usuario vagrant
```
mkdir -p /home/vagrant/.ssh
wget --no-check-certificate https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub -O /home/vagrant/.ssh/authorized_keys
chmod 0700 /home/vagrant/.ssh
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh
```

Con estos pasos, podemos proceder a apagar la VM y convertirla en un template. A partir de ese momento, cuando hagamos vagrant up en la máquina de desarrollo, nos creará una nueva VM a partir del template de Vagrant.

```
[root@chefdev ~]# vagrant up
Bringing machine 'default' up with 'vsphere' provider...
==> default: Calling vSphere CloneVM with the following settings:
==> default:  -- Template VM: Homelab/vm/vagrant-centos
==> default:  -- Target VM: Homelab/vm/vagrant-centos-test
==> default: New virtual machine successfully cloned
==> default: Waiting for the machine to report its IP address...
    default: Timeout: 240 seconds
    default: IP: 10.2.0.142
==> default: Waiting for machine to boot. This may take a few minutes...
    default: SSH address: 10.2.0.142:22
    default: SSH username: vagrant
    default: SSH auth method: private key
    default:
    default: Vagrant insecure key detected. Vagrant will automatically replace
    default: this with a newly generated keypair for better security.
    default:
    default: Inserting generated public key within guest...
    default: Removing insecure key from the guest if it's present...
    default: Key inserted! Disconnecting and reconnecting using new SSH key...
==> default: Machine booted and ready!
==> default: Installing rsync to the VM...
==> default: Rsyncing folder: /root/ => /vagrant
```