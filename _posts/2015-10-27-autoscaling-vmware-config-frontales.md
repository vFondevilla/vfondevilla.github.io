---
layout: post
title: Autoscaling en VMware - Configuración frontales con Chef
---

Empezaremos creando el *cookbook*, que es la recopilación de "recetas" que configurarán nuestros equipos con la configuración que deseemos.

```knife cookbook create chef-autoscale-frontal```

Esto nos creará una serie de directorios que almacenarán las recetas de este cookbook.

Personalmente, prefiero tener varias recetas en vez de una receta muy grande ya que me permitirá centrarme en cada una de las facetas de la VM, pero esto va acorde a los gustos de cada uno.

Generamos la configuración del servidor web, bajo el nombre de frontal
```chef generate recipe chef-autoscale-frontal frontal```

Esta receta contendrá la configuración de IIS, de momento lo haremos muy simple:

```
#
# Cookbook Name:: chef-autoscale-frontal
# Recipe:: frontal
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

dsc_script 'Web-Server' do
  code <<-EOH
  WindowsFeature InstallWebServer
  {
    Name = "Web-Server"
    Ensure = "Present"
  }
  EOH
end

dsc_script 'Web-Mgmt-Console' do
  code <<-EOH
  WindowsFeature InstallIISConsole
  {
    Name = "Web-Mgmt-Console"
    Ensure = "Present"
  }
  EOH
end
```

Incluiremos esta receta en el default.rb para que en tiempo de ejecución sea incluida y de paso, procederemos a crear el usuario y el grupo bajo el que se ejecutará el AppPool del IIS:

```
#
# Cookbook Name:: chef-autoscale-frontal
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'chef-autoscale-frontal::frontal'

user 'AppUser' do
	password "P@ssw0rd!"
end

group 'AppUsers Group' do
	action :create
	members "AppUser"
	append true
end
```

Lo siguiente será asignar este cookbook a los dos nodos frontales, con los siguientes comandos:

```
knife node run_list set chefwin-frontal01 'recipe[chef-autoscale-frontal]'
knife node run_list set chefwin-frontal02 'recipe[chef-autoscale-frontal]'
```
En este primer momento solo les asignaré un cookbook, pero se pueden asignar varios a un mismo host.

Con esto concluimos esta primera configuración de los frontales.