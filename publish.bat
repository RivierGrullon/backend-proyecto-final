@echo off
echo ========================================
echo Publicando aplicacion como ejecutable
echo ========================================
echo.

dotnet publish -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true -p:IncludeNativeLibrariesForSelfExtract=true -p:PublishTrimmed=false

echo.
echo ========================================
echo Publicacion completada!
echo ========================================
echo.
echo El ejecutable se encuentra en:
echo bin\Release\net7.0\win-x64\publish\programacion-proyecto-backend.exe
echo.
echo IMPORTANTE: Recuerda copiar el archivo .env junto al .exe
echo.
pause

