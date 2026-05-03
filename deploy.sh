#!/bin/bash

# --- SOC LMTM 2.0 Deployment Script ---
echo "🛡️ Iniciando despliegue de Infraestructura SOC LMTM..."

# 1. Actualizar sistema e instalar dependencias de seguridad
echo "📦 Instalando Snort, AIDE, Fail2ban y Docker..."
sudo apt update && sudo apt install -y docker.io docker-compose aide snort fail2ban

# 2. Configurar AIDE (HIDS)
echo "🔍 Configurando AIDE..."
if [ -f "./config/aide.conf" ]; then
    sudo cp ./config/aide.conf /etc/aide/aide.conf
fi

# 3. Preparar Promtail
echo "🚚 Configurando pipeline de logs..."
sudo mkdir -p /etc/promtail
sudo cp ./config/promtail.yml /etc/promtail/config.yml

# 4. Levantar Stack PLG (Docker)
echo "🐳 Levantando contenedores (Grafana, Loki, Promtail)..."
sudo docker-compose -f ./config/docker-compose.yml up -d

echo "✅ SOC LMTM desplegado correctamente."
echo "🌐 Accede a Grafana en: http://localhost:3000 (admin/admin)"
echo "🚀 No olvides inicializar AIDE con: sudo aide --init"
