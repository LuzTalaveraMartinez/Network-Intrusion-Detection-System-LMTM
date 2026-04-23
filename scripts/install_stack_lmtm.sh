#!/bin/bash
echo "--- Iniciando Instalación del SOC LMTM ---"

# Descarga de Loki y Promtail (Versiones oficiales)
wget https://github.com/grafana/loki/releases/download/v2.9.1/loki-linux-amd64.zip
wget https://github.com/grafana/loki/releases/download/v2.9.1/promtail-linux-amd64.zip

# Descompresión y permisos
unzip -o "*.zip"
chmod +x loki-linux-amd64 promtail-linux-amd64

# Limpieza de archivos temporales
rm *.zip

echo "--- Instalación completada con éxito por Luz Maria Talavera Martinez ---"
