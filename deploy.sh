#!/bin/bash

# --- SOC LMTM 2.0 Deployment Script (CORREGIDO) ---
echo "🛡️ Iniciando despliegue de Infraestructura SOC LMTM..."

# 1. Actualizar e instalar (usando nombres de paquetes correctos para Ubuntu 24.04)
echo "📦 Instalando Snort, AIDE, Fail2ban y Docker..."
sudo apt update
sudo apt install -y docker.io docker-compose-v2 aide snort fail2ban

# 2. Configurar AIDE
echo "🔍 Configurando AIDE..."
# Usamos la ruta completa para evitar errores de contexto
if [ -f "/home/luztalavera/Network-Intrusion-Detection-System-LMTM/config/aide.conf" ]; then
    sudo cp /home/luztalavera/Network-Intrusion-Detection-System-LMTM/config/aide.conf /etc/aide/aide.conf
fi

# 3. Preparar directorios de logs y permisos
echo "🚚 Configurando permisos de logs para Grafana/Promtail..."
sudo mkdir -p /var/log/aide
sudo touch /var/log/aide/aide.log
sudo chmod -R 755 /var/log/snort
sudo chmod -R 755 /var/log/aide

# 4. Levantar Stack PLG (Usando el comando moderno 'docker compose')
echo "🐳 Levantando contenedores (Grafana, Loki, Promtail)..."
cd /home/luztalavera/Network-Intrusion-Detection-System-LMTM/config
sudo docker compose up -d

echo "✅ SOC LMTM desplegado correctamente."
echo "🌐 Accede a Grafana en: http://localhost:3000 (admin/admin)"
echo "🚀 RECUERDA: Si es la primera vez, ejecuta: sudo aideinit"
