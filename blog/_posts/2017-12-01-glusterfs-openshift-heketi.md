---
layout: post
title: Desplegando GlusterFS e integrándolo con OpenShift Origin
---
Últimamente estoy más metido con todas las tecnologías Cloud Native y me he encontrado probando tecnologías de almacenamiento ágil, que permitan reducir el Time To Market y automatizar al máximo posible la provisión y la gestión del almacenamiento. 

En este caso me centraré sobre la plataforma PaaS OpenShift Origin basada sobre Kubernetes, que tiene disponible la funcionalidad de Dynamic Volume Provisioning, en la que automáticamente se crearán los Persistent Volume (PV) en base a las Persistent Volume Claims (PVC) que se creen.

He escogido Glusterfs debido a la facilidad de despliegue en un entorno PoC y al uso de Heketi, que básicamente es una interfaz REST para gestión de Glusterfs.

En este entorno de prueba tenemos un único nodo de OpenShift y 3 nodos de almacenamiento GlusterFS, cada uno con un disco (sdb).

En todos los nodos de almacenamiento haremos los siguientes pasos
Crearemos el Physical Volume

```pvcreate /dev/sdb```

Creamos el Volume Group

```vgcreate vg_gluster /dev/sdb```

Creamos el Logical Volume

```lvcreate -l 100%FREE -n brick1 vg_gluster```

Empezamos la instalación del software de Gluster

```yum -y  install centos-release-gluster310.noarch
yum -y install glusterfs-server```


Una vez está instalado el software, procedemos a arrancar Gluster y a permitir en SELinux que los contenedores escriban en los volúmenes

```
systemctl start glusterd
systemctl enable glusterd
setsebool -P virt_sandbox_use_fusefs on
```

Un paso importante es el de permitir el acceso entre los nodos, al ser un entorno de pruebas, directamente he deshabilitado los firewalls (niños, no hagais esto en producción)

Tras haber preparado todos los nodos, trabajaremos únicamente en el nodo que usaremos como master de GlusterFS:

Procedemos a instalar Heketi
```
yum install -y epel-release
yum -y --enablerepo=epel install heketi heketi-client
```

Es necesario que el master pueda hablar con los otros nedios mediante ssh sin claves, con lo que generaremos y distribuiremos un juego de claves
```
ssh-keygen
ssh-copy-id root@gluster02
ssh-copy-id root@gluster03
```

Haremos que Heteki tenga disponible la clave ssh
```
 cp /root/.ssh/id_rsa /etc/heketi/heketi_key
 chown heketi: /etc/heketi/heketi_key
```

Editaremos el fichero de configuracion de Heketi

<script src="https://gist.github.com/vFondevilla/6ab3f5bbc668d6a3be1f5fcde49eb5fb.js"></script>

Tras esto, crearemos el fichero de topología, donde vamos a definir los servidores y los discos que se usarán en el pool de gluster, para que automáticamente, los añada al pool de glusterfs:

<script src="https://gist.github.com/vFondevilla/683b88603ec44608c5bccf1e5e3e7064.js"></script>

Una vez creada la topología, la cargaremos, pero antes, para agilizar como trabajos con heketi-cli pasaremos unas variables de entorno:
```
export HEKETI_CLI_SERVER=http://10.2.0.52:8080
export HEKETI_CLI_USER=admin
export HEKETI_CLI_KEY=Passw0rdSuperMegaComplicada
heketi-cli topology load --json=topology.json
```

Una vez lo hayamos cargado, podemos comprobar que Heketi está funcionando correctamente:
```
[root@gluster heketi]# curl http://10.2.0.52:8080/hello
Hello from Heketi
```

Tras esto, pasaremos al nodo de OpenShift donde configuraremos la conexión con GlusterFS.
Crearemos el Storage Class:
```

apiVersion: storage.k8s.io/v1beta1
kind: StorageClass
metadata:
  name: heketi
provisioner: kubernetes.io/glusterfs
parameters:
  resturl: "http://10.2.0.52:8080"
  restuser: "admin"
  restuserkey: "Passw0rdSuperMegaComplicada"
```

Y una PVC de prueba:
```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
 name: heketi-pvc
 annotations:
   volume.beta.kubernetes.io/storage-class: heketi
spec:
 accessModes:
  - ReadWriteMany
 resources:
   requests:
     storage: 2Gi
```

Cargamos primer el SC, comprobamos que existe para a continuación cargar la PVC y ver como automáticamente se genera el volumen y se bindea con la PVC:
```
[root@origin victor]# oc create -f StorageClassHeketi.yml
storageclass "heketi" created
[root@origin victor]# oc get sc
NAME      TYPE
heketi    kubernetes.io/glusterfs
[root@origin victor]# oc create -f pvc_test.yml
persistentvolumeclaim "heketi-pvc" created
[root@origin victor]# oc get pvc
NAME         STATUS    VOLUME                                     CAPACITY   ACCESSMODES   STORAGECLASS   AGE
heketi-pvc   Bound     pvc-43ea1baa-d6bf-11e7-8282-0050569070f5   2Gi        RWX           heketi         6s
postgresql   Bound     pv0001                                     100Gi      RWO                          1d
```
