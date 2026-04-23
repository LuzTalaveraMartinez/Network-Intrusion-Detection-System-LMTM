#!/bin/bash
# LMTM Security - Integrity Check Automation
# Autor: Luz Maria Talavera Martinez
# Fecha: Abril 2026

# Definición de rutas
FECHA=$(date +%F_%H-%M)
LOG_DIR="/var/log/aide"
REPORTE="$LOG_DIR/reporte_$FECHA.txt"

# Crear directorio de logs si no existe
if [ ! -d "$LOG_DIR" ]; then
    sudo mkdir -p "$LOG_DIR"
fi

echo "[+] $(date) - Iniciando auditoría de integridad AIDE..."
sudo aide --check --config /etc/aide/aide.conf > "$REPORTE" 2>&1

# Verificar si el comando se ejecutó correctamente
if [ $? -eq 0 ]; then
    echo "✅ [$(date)] Auditoría finalizada: Sistema íntegro."
else
    echo "⚠️ [$(date)] ALERTA: Se detectaron cambios en el sistema de archivos."
fi

echo "-----------------------------------------------"
echo "[!] Resumen del reporte (primeras 25 líneas):"
head -n 25 "$REPORTE"
echo "-----------------------------------------------"
echo "[!] Log forense completo guardado en: $REPORTE"
