#!/bin/bash

echo "🚀 Iniciando el Ecosistema SOC LMTM..."

# 1. Iniciar Zeek NIDS
echo "🔍 Desplegando Zeek..."
sudo /opt/zeek/bin/zeekctl deploy

# 2. Levantar el stack de monitoreo (Loki, Grafana, Promtail)
echo "🐳 Levantando contenedores Docker..."
cd ~/Network-Intrusion-Detection-System-LMTM/config
sudo docker compose up -d

# 3. Ajustar permisos de lectura de logs
echo "🔐 Asegurando permisos de logs..."
sudo chmod -R 755 /opt/zeek/logs/
sudo chmod -R 755 /var/log/snort/
sudo chmod 644 /var/log/fail2ban.log
sudo chmod 644 /var/log/syslog

# 4. Refrescar Promtail para capturar datos frescos
echo "🔄 Reiniciando Promtail..."
sudo docker restart promtail

echo "✅ SOC Activo. Puedes entrar a http://localhost:3000"
