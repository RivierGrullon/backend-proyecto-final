# Publicar como Ejecutable (.exe)

## Descripción

Este proyecto puede compilarse como un ejecutable autocontenido (.exe) que incluye todo lo necesario para ejecutarse sin necesidad de tener .NET instalado en el sistema.

## Publicar el Ejecutable

### Opción Rápida: Usar el Script

**Windows:**
```bash
.\publish.bat
```

**Linux/Mac:**
```bash
chmod +x publish.sh
./publish.sh
```

### Opción Manual: Comandos

### Opción 1: Windows x64 (Recomendado)

```bash
dotnet publish -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true -p:IncludeNativeLibrariesForSelfExtract=true
```

Esto generará un archivo `.exe` en:
```
bin/Release/net7.0/win-x64/publish/programacion-proyecto-backend.exe
```

### Opción 2: Windows x86

```bash
dotnet publish -c Release -r win-x86 --self-contained true -p:PublishSingleFile=true
```

### Opción 3: Linux x64

```bash
dotnet publish -c Release -r linux-x64 --self-contained true -p:PublishSingleFile=true
```

### Opción 4: macOS (Intel)

```bash
dotnet publish -c Release -r osx-x64 --self-contained true -p:PublishSingleFile=true
```

### Opción 5: macOS (Apple Silicon)

```bash
dotnet publish -c Release -r osx-arm64 --self-contained true -p:PublishSingleFile=true
```

## Ejecutar el .exe

### Preparación

1. **Crear el archivo .env** en el mismo directorio que el .exe:

```
programacion-proyecto-backend.exe
.env
```

Contenido del `.env`:
```env
DATABASE_CONNECTION_STRING=Host=tu-host;Port=5432;Database=tu-db;Username=tu-usuario;Password=tu-contraseña
JWT_KEY=TuClaveSecretaSuperSeguraQueDebeTenerAlMenos32Caracteres2024!
JWT_ISSUER=ProgramacionProyectoBackend
JWT_AUDIENCE=ProgramacionProyectoBackend
JWT_EXPIRY_MINUTES=1440
PORT=5148
```

### Ejecutar

Simplemente ejecuta el archivo `.exe`:

```bash
.\programacion-proyecto-backend.exe
```

O haz doble clic en el archivo en el explorador de Windows.

## Scripts de Publicación

### Script para Windows (publish.bat)

```batch
@echo off
echo Publicando aplicacion como ejecutable...
dotnet publish -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true -p:IncludeNativeLibrariesForSelfExtract=true

echo.
echo Publicacion completada!
echo El ejecutable se encuentra en: bin\Release\net7.0\win-x64\publish\
pause
```

### Script para Linux/Mac (publish.sh)

```bash
#!/bin/bash
echo "Publicando aplicacion como ejecutable..."
dotnet publish -c Release -r linux-x64 --self-contained true -p:PublishSingleFile=true

echo ""
echo "Publicacion completada!"
echo "El ejecutable se encuentra en: bin/Release/net7.0/linux-x64/publish/"
```

## Opciones de Publicación

### Tamaño del Ejecutable

- **PublishSingleFile=true**: Genera un único archivo .exe (más grande pero más fácil de distribuir)
- **PublishTrimmed=true**: Reduce el tamaño pero puede causar problemas con algunas librerías (desactivado por defecto)

### Plataformas Soportadas

- `win-x64` - Windows 64-bit
- `win-x86` - Windows 32-bit
- `linux-x64` - Linux 64-bit
- `osx-x64` - macOS Intel
- `osx-arm64` - macOS Apple Silicon

## Estructura de Archivos Después de Publicar

Cuando publicas como ejecutable, obtienes:

```
bin/Release/net7.0/win-x64/publish/
├── programacion-proyecto-backend.exe  (ejecutable principal)
├── appsettings.json                   (configuración)
├── appsettings.Development.json       (configuración desarrollo)
└── (archivos de soporte si no usas PublishSingleFile)
```

## Variables de Entorno

El ejecutable busca el archivo `.env` en el mismo directorio donde se ejecuta. Asegúrate de:

1. Copiar el archivo `.env` junto al `.exe`
2. O configurar las variables de entorno del sistema

## Notas Importantes

### ⚠️ Primera Ejecución

La primera vez que ejecutes el .exe puede tardar un poco más porque extrae los archivos necesarios (si usas PublishSingleFile).

### 🔒 Seguridad

- Nunca incluyas el archivo `.env` en la distribución
- Usa diferentes credenciales para desarrollo y producción
- Protege el archivo `.exe` con permisos adecuados

### 📦 Distribución

Para distribuir la aplicación:

1. Publica el ejecutable
2. Copia el `.exe` y el `appsettings.json`
3. Crea un `.env.example` como plantilla
4. Incluye instrucciones de configuración

### 🚀 Optimización

Si el tamaño del ejecutable es importante, puedes:

```bash
# Publicar con trimming (reduce tamaño pero puede causar problemas)
dotnet publish -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true -p:PublishTrimmed=true

# Publicar sin incluir símbolos de depuración
dotnet publish -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true -p:DebugType=None
```

## Troubleshooting

### Error: "The application failed to start"

1. Verifica que tienes los permisos de ejecución
2. Asegúrate de que el archivo `.env` existe en el mismo directorio
3. Verifica que la base de datos está accesible

### Error: "Could not load file or assembly"

1. Publica con `PublishTrimmed=false` (ya está configurado)
2. Usa `PublishSingleFile=false` si persiste el problema

### El .exe no encuentra el .env

- Asegúrate de que el archivo `.env` está en el mismo directorio que el `.exe`
- O configura las variables de entorno del sistema

## Ejemplo Completo

```bash
# 1. Publicar
dotnet publish -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true

# 2. Navegar a la carpeta de publicación
cd bin/Release/net7.0/win-x64/publish

# 3. Crear el archivo .env
copy ..\..\..\..\..\..\..\..\.env.example .env
# Editar .env con tus valores

# 4. Ejecutar
.\programacion-proyecto-backend.exe
```

