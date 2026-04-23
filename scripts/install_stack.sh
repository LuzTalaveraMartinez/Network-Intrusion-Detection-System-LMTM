#!/bin/bash
echo "Instalando Stack SOC - LMTM..."
# Descarga de binarios
wget https://github.com
wget https://github.com

# Descompresión
unzip -o "*.zip"
mv loki-linux-amd64 ../loki
mv promtail-linux-amd64 ../promtail
chmod +x ../loki ../promtail
rm *.zip
echo "Instalación completada. Ejecuta los servicios usando los archivos en /configs"
