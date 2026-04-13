#!/bin/bash

# ==========================================================
# 🛡️ SCRIPT DE AUTOMATIZACIÓN SOC - LMTM
# Desarrollado por: Luz Maria Talavera Martinez
# Propósito: Iniciar el stack de monitoreo (Loki + Promtail)
# ==========================================================

echo "🚀 Iniciando infraestructura de monitoreo LMTM..."

# 1. Asegurar permisos en los logs de Snort
# Esto permite que el cartero (Promtail) pueda leer las alertas
sudo chmod 644 /var/log/snort/alert
echo "✅ Permisos de logs actualizados."

# 2. Iniciar Loki en segundo plano
# El '&' al final hace que corra 'atrás' y no te bloquee la consola
cd ~/loki
./loki-linux-amd64 -config.file=loki-local-config.yaml > loki.log 2>&1 &
echo "✅ Loki iniciado (Puerto 3100)."

# 3. Iniciar Promtail en segundo plano
# Redirigimos los mensajes a promtail.log para que no molesten en pantalla
sudo ./promtail-linux-amd64 -config.file=promtail-config.yaml > promtail.log 2>&1 &
echo "✅ Promtail iniciado y vinculado a Snort."

echo "----------------------------------------------------------"
echo "🌟 TODO LISTO, LUZ MARÍA."
echo "Accedé desde Windows a: http://localhost:3000"
echo "----------------------------------------------------------"

