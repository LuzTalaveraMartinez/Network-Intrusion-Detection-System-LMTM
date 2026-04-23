#!/bin/bash
echo "🚀 Iniciando infraestructura de monitoreo LMTM..."

# 1. Preparar logs
sudo mkdir -p /var/log/snort
sudo touch /var/log/snort/alert
sudo chmod 644 /var/log/snort/alert

# 2. Iniciar Loki (con TU nombre de archivo real)
./loki-linux-amd64 -config.file=../configs/local-config-loki.yaml > loki.log 2>&1 &
echo "✅ Loki iniciado (Puerto 3100)."

# 3. Iniciar Promtail (con TU nombre de archivo real)
sudo ./promtail-linux-amd64 -config.file=../configs/promtail-config.yaml > promtail.log 2>&1 &
echo "✅ Promtail iniciado."

echo "----------------------------------------------------------"
echo "🌟 TODO LISTO, LUZ MARÍA TALAVERA MARTÍNEZ."
