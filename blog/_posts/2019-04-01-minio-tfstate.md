---
layout: post
title: Utilizando Minio como Backend S3 para Terraform
tags: Terraform, Openstack
---

Para el que no conozca [Minio](https://min.io), es un software que ofrece almacenamiento de objetos compatible con las APIs de S3, lo que abre la puerta a utilizar software pensado para S3 manteniéndolo dentro del perímetro del Datacenter, sin tener que utilizar servicios de AWS, en mi caso, lo utilizo para mantener el estado de mis ficheros tfstate de Terraform.

Peeeeeeero no podía ser tan fácil habilitar el backend de S3 de Terraform para Minio, ya que arroja mensajes de error como por ejemplo:

```Error configuring the backend "s3": InvalidClientTokenId: The security token included in the request is invalid.
	status code: 403, request id: 0f9a1265-54b5-11e9-854c-a321c26e14a2
    ```

Pero esto tiene fácil solución, en la configuración del provider habéis de incluir la siguiente información:

```
terraform {
  backend "s3" {
    bucket = "terraform"
    key    = "openstack/terraform.tfstate"
    region = "us-west-2"
    endpoint = "http://10.1.0.3:9000"
    skip_requesting_account_id = true
    skip_credentials_validation = true
    skip_get_ec2_platforms = true
    skip_metadata_api_check = true
    force_path_style = "True"
  }
}
```

Con esto, podremos ejecutar el comando terraform init que nos permitirá copiar nuestro fichero tfstate al nuevo backend y trabajar con Terraform utilizando esta funcionalidad de forma transparente :)

