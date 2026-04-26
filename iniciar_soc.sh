#!/bin/bash
echo "--- Iniciando Motores del SOC LMTM ---"
# 1. Base de Datos y Transporte
cd ~/Network-Intrusion-Detection-System-LMTM/automation
./loki-linux-amd64 -config.file=loki-config.yaml &
sleep 2
sudo ./promtail-linux-amd64 -config.file=../configs/promtail-config.yaml &

# 2. Motores de Detección
sudo systemctl restart snort
sudo systemctl restart fail2ban

# 3. Monitor de IA (Opcional)
source ~/nids_env/bin/activate
echo "--- Todo listo. Abre Grafana en el puerto 3000 ---"
