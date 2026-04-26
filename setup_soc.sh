#!/bin/bash
# --- SOC LMTM: INSTALADOR AUTOMÁTICO ---

echo "Iniciando instalación de dependencias..."
sudo apt update && sudo apt install -y snort fail2ban aide grafana-server wget unzip

echo "Configurando entorno Python..."
python3 -m venv ~/nids_env
source ~/nids_env/bin/activate
pip install --upgrade pip

echo "Descargando binarios de Loki y Promtail..."
mkdir -p ~/Network-Intrusion-Detection-System-LMTM/automation
cd ~/Network-Intrusion-Detection-System-LMTM/automation
wget https://github.com/grafana/loki/releases/download/v2.9.1/loki-linux-amd64.zip
unzip -o loki-linux-amd64.zip && chmod +x loki-linux-amd64
wget https://github.com/grafana/loki/releases/download/v2.9.1/promtail-linux-amd64.zip

unzip -o promtail-linux-amd64.zip && chmod +x promtail-linux-amd64

echo "Ajustando permisos de seguridad..."
sudo chown -R snort:snort /var/log/snort
sudo chmod -R 775 /var/log/snort
sudo chmod 644 /var/log/fail2ban.log

echo "--- INSTALACIÓN COMPLETADA CON ÉXITO ---"
