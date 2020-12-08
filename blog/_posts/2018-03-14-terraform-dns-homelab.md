---
layout: post
title: Usando Terraform para gestionar el DNS de mi homelab
---

Mientras estoy avanzando en implantar metodologías y herramientas DevOps, he decidido adoptar el paradigma de Infrastructure as Code (Code everything!) para la gestión del estado de mi laboratorio, siempre que pueda. 

Una de esas cosas que ahora me pregunto como podía vivir sin ello es el módulo de gestión de DNS de Terraform. Esto me permite tener en mi repositorio privado de Git la configuración de DNS (entradas e IPs), con lo que si destruyo el laboratorio, puedo recuperar su estado mucho más fácilmente que haciendo un backup de las zonas e importándolas. Todo desde git.

Lo primero de todo, ¿como narices funciona todo esto de DNS con Terraform?

Pues básicamente se basa sobre la RFC 2845, que permite la actualización y creación de registros de DNS mediante transacciones autenticadas mediante una clave secreta. El proveedor de DNS de Terraform es el encargado de mandar los mensajes adecuados al servidor de DNS que configuremos, permitiéndonos crear, actualizar y destruir registros de DNS del servidor, en este caso el servidor de DNS integrado de Synology, basado en BIND.

Lo primero de todo, generaremos una clave en el servidor BIND y nos guardaremos la key secreta que ha generado que usaremos en nuestra configuración de Terraform.

En el texto adjunto, se puede ver la configuración del servidor DNS (10.1.0.3), la keyname (es importante que en la configuración de terraform se añada un punto al final del nombre, ya que si no, suele dar fallo) y el key_secret que nos ha devuelto el servidor BIND.

```
provider "dns" {
    update {
        server          = "10.1.0.3"
        key_name        = "terraform."
        key_algorithm   = "hmac-md5"
        key_secret      = "SOMERANDOMSTRING"
    }
}

resource "dns_a_record_set" "ansible-master" {
  zone = "vfondevilla.com."
  name = "ansible-master"
  addresses = [
    "10.2.0.20",
  ]
  ttl = "300"
}
resource "dns_a_record_set" "db1" {
  zone = "vfondevilla.com."
  name = "db1"
  addresses = [
    "10.2.0.101",
  ]
  ttl = "300"
}
```

Con esta configuración, Terraform creará dos registros, llamados ansible-master.vfondevilla.com y db1.vfondevilla.com dentro de la zona "vfondevilla.com." del servidor BIND. Fácil y rápido. Y muy potente.
