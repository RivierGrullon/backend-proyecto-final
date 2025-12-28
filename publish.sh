#!/bin/bash
echo "========================================"
echo "Publicando aplicacion como ejecutable"
echo "========================================"
echo ""

dotnet publish -c Release -r linux-x64 --self-contained true -p:PublishSingleFile=true -p:PublishTrimmed=false

echo ""
echo "========================================"
echo "Publicacion completada!"
echo "========================================"
echo ""
echo "El ejecutable se encuentra en:"
echo "bin/Release/net7.0/linux-x64/publish/"
echo ""
echo "IMPORTANTE: Recuerda copiar el archivo .env junto al ejecutable"
echo ""

