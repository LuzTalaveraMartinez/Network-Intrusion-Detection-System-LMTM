#!/bin/bash
# Ejecuta el chequeo de AIDE y guarda el resultado en un log
LOG_FILE="/var/log/aide_daily.log"
DATE=$(date +'%Y-%m-%d %H:%M:%S')

echo "--- Inicio de chequeo: $DATE ---" >> $LOG_FILE
/usr/bin/aide --check --config /etc/aide/aide.conf >> $LOG_FILE 2>&1
echo "--- Fin de chequeo ---" >> $LOG_FILE
