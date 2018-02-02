---
layout: post
title: Empezando con Kubernetes y Minikube en MacOS High Sierra
---

Aunque llevo tiempo trabajando con OpenShift Origin, considero importante conocer la tecnología subyacente a la solución, con lo que he empezado a jugar directamente con Kubernetes "vainilla" para conocer un poco más los entresijos de K8s.

Para los que no conozcan Minikube, es una solución que despliega un clúster mono-nodo de Kubernetes, alojando todo 

Para comenzar, usaré mi equipo personal, un MacBook Pro de 13" (Año 2017) con i7, 16GB de RAM y High Sierra, así que no puedo asegurar los mismos resultados en cada versión de MacOS. Como requisito, necesitamos tener instalado Homebrew y yo personalmente uso VMware Fusion como programa de virtualización, ya que VirtualBox nunca fue santo de mi devoción.

He intentado utilizar HyperKit que es el plugin que va a sustituir a xhyve, pero de momento no he sido capaz de instalarlo correctamente en High Sierra, así que... Volvemos a VMware Fusion, que tiene driver nativo en la solución de Minikube.

Empezamos instalando minikube:

```
➜  ~ brew cask install minikube
==> Satisfying dependencies
All Formula dependencies satisfied.
==> Downloading https://storage.googleapis.com/minikube/releases/v0.25.0/minikub
######################################################################## 100.0%
==> Verifying checksum for Cask minikube
==> Installing Cask minikube
==> Linking Binary 'minikube-darwin-amd64' to '/usr/local/bin/minikube'.
🍺  minikube was successfully installed!
```

A continuación instalamos kubectl, que es el binario de gestión de K8s

```
➜  ~ brew install kubectl
==> Downloading https://homebrew.bintray.com/bottles/kubernetes-cli-1.9.2.high_s
==> Downloading from https://akamai.bintray.com/05/05744f3da06368bbf92ad09813071
######################################################################## 100.0%
==> Pouring kubernetes-cli-1.9.2.high_sierra.bottle.tar.gz
==> Caveats
Bash completion has been installed to:
  /usr/local/etc/bash_completion.d

zsh completions have been installed to:
  /usr/local/share/zsh/site-functions
==> Summary
🍺  /usr/local/Cellar/kubernetes-cli/1.9.2: 172 files, 65.3MB
```

Ya tenemos todo lo necesario para comenzar a utilizar minikube en nuestro ordenador, así que vamos a lanzar el clúster con el comando minikube start. Aunque tendremos que pasarle el flag --vm-driver ya que por defecto, intenta utilizar VBoxManage y nosotros vamos a utilizar VMware Fusion.

```
➜  ~ minikube start --vm-driver=vmwarefusion
Starting local Kubernetes v1.9.0 cluster...
Starting VM...
Getting VM IP address...
Moving files into cluster...
Downloading localkube binary
 162.41 MB / 162.41 MB [============================================] 100.00% 0s
 0 B / 65 B [----------------------------------------------------------]   0.00%
 65 B / 65 B [======================================================] 100.00% 0sSetting up certs...
Connecting to cluster...
Setting up kubeconfig...
Starting cluster components...
Kubectl is now configured to use the cluster.
Loading cached images from config file.
```

Con esto, ya tendremos nuestro clúster operativo:
```
➜  ~ kubectl get nodes
NAME       STATUS    ROLES     AGE       VERSION
minikube   Ready     <none>    27s       v1.9.0
```

Y podremos acceder a Kubernetes dashboard. Aunque en mi caso, al lanzar el comando ```minikube dashboard``` no me abre correctamente el dashboard, podemos obtener su URL utilizando el siguiente comando ```minikube dashboard --url```

Al entrar en la URL veremos el servicio Dashboard de Kubernetes en funcionamiento :)