---
layout: post
title: Cambiar proveedor por defecto Vagrant
---

Finalmente me he decidido a comprar el plugin de Vagrant para VMware Fusion, y dejo este blog como nota mental de como cambiar el default provider en Vagrant, bajo zsh.

Editamos el fichero ~/.zshrc y añadimos lo siguiente al final:

```

# Vagrant Configuration
export VAGRANT_DEFAULT_PROVIDER=vmware_fusion

```

Con esto nos ahorramos el tener que configurarlo cada vez que abrimos la línea de comandos.
