---
layout: post
title: Conexiones a SQL Server desde Powershell
---

Desarrollando scripts para mi actual empresa, me he visto en la necesidad de añadir datos a un SQL Server desde Powershell (sin poder utilizar las herramientas de SQL Server, como sqlcmd). Todo esto implica entrar en el mundillo de .Net y conjugarlo con Powershell para poder realizar labores de reporting, siendo increíblemente potente:

Primero haremos un script que nos permitirá probar si esto realmente funciona o solo os estoy vendiendo humo :)

```Powershell
$servidor = "10.1.0.2"
$database = "smoke"
$usuario = "smokeUser"
$password = "SomeRandomP@ssword"

$connectionString = "Data Source=$Servidor;Initial Catalog=$database;Connect Timeout=3;User ID=$usuario;Password=$password"
$sqlConn = new-object ("Data.SqlClient.SqlConnection") $connectionString
trap
{
Write-Error "Cannot connect to $servidor.";
continue
}
$sqlConn.Open()

if ($sqlConn.State -eq 'Open')
{
$sqlConn.Close();
"Opened successfully."
}
```

Bien! Esto funciona y no todo es humo... Vamos a pasar a la parte más divertida, que es la de introducir los datos a la DB correspondiente.

Cogeremos y modificaremos el código antes puesto:

```Powershell
$connectionString = "Data Source=$Servidor;Initial Catalog=$database;Connect Timeout=3;User ID=$usuario;Password=$password"
$sqlConn = new-object ("Data.SqlClient.SqlConnection") $connectionString
trap
{
Write-Error "Cannot connect to $servidor.";
continue
}
$sqlConn.Open()

$sqlQuery = $sqlConn.CreateCommand()
$sqlQuery.CommandText = "INSERT INTO dbo.Tabla (Ok) VALUES ('SI')"
$sqlQuery.ExecuteNonQuery()

$sqlConn.Close()
```

Ejecutamos y... bingo :) si todo va bien, desde línea de comando nos devolverá un "1" como output, lo que significa que hemos introducido correctamente el valor en la tabla. Esto nos abre un mundo de posibilidades, como poder adjuntar el log de nuestros scripts en un SQL Server, por ejemplo.

Hasta aquí este post, espero que lo disfrutes :)