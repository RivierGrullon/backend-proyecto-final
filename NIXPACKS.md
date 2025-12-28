# Configuración Nixpacks

Este proyecto está configurado para usar **Nixpacks** para el despliegue automático.

## Archivo de Configuración

El archivo `nixpacks.toml` contiene la configuración necesaria:

```toml
[providers]
dotnet = "7.0"

[phases.setup]
nixPkgs = ["dotnet-sdk_7"]

[phases.install]
cmds = [
    "dotnet restore"
]

[phases.build]
cmds = [
    "dotnet publish -c Release -o /app/publish --no-restore"
]

[start]
cmd = "dotnet /app/publish/programacion-proyecto-backend.dll"

[variables]
ASPNETCORE_URLS = "http://+:$PORT"
```

## Comandos Nixpacks

### Build
```bash
dotnet restore
dotnet publish -c Release -o /app/publish --no-restore
```

### Install
```bash
dotnet restore
```

### Start
```bash
dotnet /app/publish/programacion-proyecto-backend.dll
```

## Variables de Entorno Requeridas

Configura estas variables en tu plataforma de despliegue (Coolify, Railway, etc.):

### Base de Datos
- `DATABASE_CONNECTION_STRING` - Cadena de conexión completa a PostgreSQL

### JWT
- `JWT_KEY` - Clave secreta para firmar tokens (mínimo 32 caracteres)
- `JWT_ISSUER` - Emisor del token (opcional, por defecto: ProgramacionProyectoBackend)
- `JWT_AUDIENCE` - Audiencia del token (opcional, por defecto: ProgramacionProyectoBackend)
- `JWT_EXPIRY_MINUTES` - Tiempo de expiración en minutos (opcional, por defecto: 1440)

### Servidor
- `PORT` - Puerto donde escuchará la aplicación (configurado automáticamente por la plataforma)

### Ambiente
- `ASPNETCORE_ENVIRONMENT` - Ambiente de ejecución (Development, Production, etc.)

## Despliegue en Coolify

1. **Conectar el repositorio** a Coolify
2. **Seleccionar Nixpacks** como método de build
3. **Configurar variables de entorno** en la sección de configuración
4. **Desplegar** - Coolify detectará automáticamente el `nixpacks.toml`

## Despliegue en Railway

1. **Conectar el repositorio** a Railway
2. Railway detectará automáticamente el archivo `nixpacks.toml`
3. **Configurar variables de entorno** en la pestaña Variables
4. **Desplegar**

## Verificación

Después del despliegue, verifica que la aplicación esté funcionando:

```bash
# Health check
curl https://tu-dominio.com/api/health

# Debería responder:
{
  "status": "OK",
  "message": "La API está funcionando correctamente",
  "database": "Conectado a PostgreSQL",
  "timestamp": "..."
}
```

## Troubleshooting

### Error: "Could not find a part of the path '/app/publish'"

Asegúrate de que el comando de build esté creando el directorio:
```bash
dotnet publish -c Release -o /app/publish
```

### Error: "Database connection failed"

Verifica que la variable `DATABASE_CONNECTION_STRING` esté configurada correctamente en tu plataforma.

### Error: "JWT Key is too short"

Asegúrate de que `JWT_KEY` tenga al menos 32 caracteres.

### La aplicación no inicia

1. Revisa los logs de la plataforma
2. Verifica que todas las variables de entorno estén configuradas
3. Verifica que la base de datos esté accesible desde el servidor

## Notas

- El puerto se configura automáticamente desde la variable `PORT` proporcionada por la plataforma
- Nixpacks detectará automáticamente .NET 7.0 desde el archivo `.csproj`
- El seeder se ejecutará automáticamente al iniciar si la base de datos está vacía

